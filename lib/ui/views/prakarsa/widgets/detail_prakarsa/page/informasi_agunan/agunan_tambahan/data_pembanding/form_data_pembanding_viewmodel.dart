import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/detail_agunan_tambahan_model.dart';
import '../../../../../../../../../application/models/item_data_pembanding_model.dart';
import '../../../../../../../../../application/services/location_service.dart';
import '../../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormDataPembandingViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _mediaService = locator<MaksimaMediaService>();
  final _masterAPI = locator<MasterAPI>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();
  final _locationService = locator<MaksimaLocationService>();

  final String id;
  final String prakarsaId;
  final double width;

  FormDataPembandingViewModel({
    required this.prakarsaId,
    required this.id,
    required this.width,
  });

  List<String> listSumberData = [
    'Foto Langsung',
    'Internet',
  ];

  List<TextEditingController> listValue = [];
  List<List<String>> urlPembandingPublic = [];
  List<ItemDataPembandingModel> listDataPembanding = [];

  List<TextEditingController> linkInternetController = [];
  List<TextEditingController> noHpPemilikController = [];
  List<TextEditingController> hargaAssetController = [];
  List<TextEditingController> luasAssetPembandingController = [];
  List<String> hargaTanahController = [];

  final dateNow = DateTime.now();
  String selectedLatLng = '';
  String tagLocation = '';

  bool isLoadingForm = false;

  void initialize() async {
    setLoadingForm(true);
    await initLoc();
    await fetchDetailDataPembanding();
    setLoadingForm(false);
  }

  void setLoadingForm(bool val) {
    isLoadingForm = val;
    notifyListeners();
  }

  void addDataPembanding() {
    listDataPembanding.add(
      ItemDataPembandingModel(
        pathDokumenPembanding: [],
        pathFoto: [],
      ),
    );
    urlPembandingPublic.add([]);
    listValue.add(TextEditingController());
    linkInternetController.add(TextEditingController());
    noHpPemilikController.add(TextEditingController());
    hargaAssetController.add(TextEditingController());
    luasAssetPembandingController.add(TextEditingController());
    hargaTanahController.add('');
    notifyListeners();
  }

  void deleteDataPembanding(int index) {
    listDataPembanding.removeAt(index);
    urlPembandingPublic.removeAt(index);
    listValue.removeAt(index);
    linkInternetController.removeAt(index);
    noHpPemilikController.removeAt(index);
    hargaAssetController.removeAt(index);
    luasAssetPembandingController.removeAt(index);
    hargaTanahController.removeAt(index);
    notifyListeners();
  }

  void updateSumberData(String val, int index) {
    listValue[index].text = val;
    listDataPembanding[index].sumberData = val;
    notifyListeners();
  }

  void updateNoHp(int index) {
    listDataPembanding[index].noHp = '+62${noHpPemilikController[index].text}';
    notifyListeners();
  }

  void updateHargaAsset(int index) {
    listDataPembanding[index].hargaAsetPembanding =
        hargaAssetController[index].text.replaceAll('.', '');
    updateHargaTanah(index);
    notifyListeners();
  }

  void updateLinkInternet(int index) {
    listDataPembanding[index].linkInternet = linkInternetController[index].text;
    notifyListeners();
  }

  void updateLuasAsset(int index) {
    listDataPembanding[index].luasAsetPembanding =
        luasAssetPembandingController[index].text.replaceAll('.', '');
    updateHargaTanah(index);
    notifyListeners();
  }

  void updateHargaTanah(int index) {
    int tempHrgAsset = int.parse(
      hargaAssetController[index].text.replaceAll('.', ''),
    );
    int tempLuasAsset = int.parse(
      luasAssetPembandingController[index].text.replaceAll('.', ''),
    );

    hargaTanahController[index] = RupiahFormatter.formatWithOutRp(
      (tempHrgAsset / tempLuasAsset).toString(),
    );
  }

  Future initLoc() async {
    final tempLoc = await _locationService.getLocation();

    tagLocation = await _locationService.getAddressFromLatLng(
      tempLoc?.latitude ?? 0,
      tempLoc?.longitude ?? 0,
    );

    selectedLatLng = '${tempLoc?.latitude ?? 0}, ${tempLoc?.longitude ?? 0}';
  }

  void openFile({
    required BuildContext context,
    required String url,
  }) {
    if (url.contains('png') || url.contains('jpg') || url.contains('jpeg')) {
      openDialog(
        context: context,
        child: Image.network(url),
      );
    } else if (url.contains('pdf')) {
      openDialog(
        context: context,
        child: SfPdfViewer.network(url),
      );
    } else {
      openDialog(
        context: context,
        child: Text('Invalid File Format! $url'),
      );
    }
  }

  void openDialog({required BuildContext context, required Widget child}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        );
      },
    );
  }

  void clearFotoPembanding(int index, int pos) {
    bool isFromPhoto = listValue[index].text == 'Foto Langsung';
    urlPembandingPublic[index].removeAt(pos);
    if (isFromPhoto) {
      listDataPembanding[index].pathFoto?.removeAt(pos);
    } else {
      listDataPembanding[index].pathDokumenPembanding?.removeAt(pos);
    }

    notifyListeners();
  }

  Future uploadFotoPembanding(BuildContext ctx, int index) async {
    final res = await _mediaService.getMultiFileType(
      allowedExtensions: _getAllowedType(index),
    );

    if (res != null) {
      if (_getValidationType(index, res.extension!)) {
        loadingCustomDialog(ctx);
        _setFotoPembanding(index, res);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png${listValue[index].text == 'Foto Langsung' ? '' : ' atau pdf'}!',
        );
      }
    }
    notifyListeners();
  }

  Future fetchDetailDataPembanding() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchDataPembanding(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    response.fold(
      (l) => addDataPembanding(),
      (res) async {
        listDataPembanding = res;
        listDataPembanding.forEach(
          (element) {
            hargaTanahController.add('');
            listValue.add(TextEditingController(text: element.sumberData));
            linkInternetController
                .add(TextEditingController(text: element.linkInternet));
            noHpPemilikController.add(
              TextEditingController(
                text: (element.noHp ?? '').isNotEmpty
                    ? element.noHp?.replaceAll('+62', '')
                    : '',
              ),
            );
            hargaAssetController.add(
              TextEditingController(
                text: RupiahFormatter.formatWithOutRp(
                  element.hargaAsetPembanding,
                ),
              ),
            );
            luasAssetPembandingController.add(
              TextEditingController(
                text:
                    RupiahFormatter.formatWithOutRp(element.luasAsetPembanding),
              ),
            );

            urlPembandingPublic.add([]);
          },
        );

        for (var i = 0; i < listDataPembanding.length; i++) {
          var listPath = ((listDataPembanding[i].pathFoto ?? []).isNotEmpty)
              ? listDataPembanding[i].pathFoto
              : listDataPembanding[i].pathDokumenPembanding;

          updateHargaAsset(i);

          for (var j = 0; j < (listPath?.length ?? 0); j++) {
            urlPembandingPublic[i].add(
              await _getPublicFile(listPath?[j].path ?? ''),
            );
          }
        }
      },
    );
    notifyListeners();
  }

  Future postDataPembanding(bool isSavedDrafts) async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.postDataPembanding(
        payload: generatePayload(isSavedDrafts),
      ),
    );

    response.fold(
      (errorMessage) {
        _showErrorDialogForm();
        notifyListeners();
      },
      (successMap) {
        _showSuccessDialog(isSavedDrafts);
        notifyListeners();
      },
    );
  }

  Future _setFotoPembanding(int index, PlatformFile file) async {
    bool isFromPhoto = listValue[index].text == 'Foto Langsung';
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (url) async {
        var temp = await _getPublicFile(url);
        urlPembandingPublic[index].add(temp);
        final outputFormat = DateFormat('dd MMM yyyy', 'id');
        String date = outputFormat.format(dateNow);
        if (isFromPhoto) {
          listDataPembanding[index].pathFoto?.add(
                PathFotoAgunanTambahan(
                  path: url,
                  photoName: date,
                  tagLocation: TagLocation(
                    latLng: selectedLatLng,
                    name: tagLocation,
                  ),
                ),
              );
        } else {
          listDataPembanding[index].pathDokumenPembanding?.add(
                PathFotoAgunanTambahan(
                  path: url,
                  photoName:
                      'Data Pembanding ${(listDataPembanding[index].pathDokumenPembanding?.length ?? 0) + 1}',
                  tagLocation: TagLocation(
                    latLng: selectedLatLng,
                    name: tagLocation,
                  ),
                ),
              );
        }

        _navigationService.back();
        notifyListeners();
      },
    );
  }

  Future validateInputs({
    required bool isSavedDrafts,
  }) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Konfirmasi Pengisian Data',
      description: 'Apakah anda yakin data yang diisi sudah sesuai?',
      mainButtonTitle: 'Batalkan',
      secondaryButtonTitle: 'Ya, sesuai',
      data: {
        'main': false,
        'secondary': true,
      },
    );

    if (response != null && response.confirmed) {
      await postDataPembanding(isSavedDrafts);
    }
  }

  Future<String> _getPublicFile(String url) async {
    String temp = '';
    final res = await runBusyFuture(
      _masterAPI.getPublicFile(url),
    );

    res.fold(
      (err) => temp = '',
      (success) => temp = success,
    );

    return temp;
  }

  Future _showSuccessDialog(
    bool isSavedDrafts,
  ) async {
    await _dialogService
        .showCustomDialog(
          variant: DialogType.baseImage,
          data: {
            'imageAsset': ImageConstants.successVerification,
          },
          title: isSavedDrafts
              ? 'Data Disimpan Sementara'
              : 'Data Berhasil Disimpan',
          description: isSavedDrafts
              ? 'Pastikan lengkapi seluruh data dari debitur'
              : 'Data telah berhasil disimpan disistem',
          mainButtonTitle: 'Sip, mengerti',
        )
        .then((value) => navigateBack(isPassed: true));
  }

  Future _showErrorDialogForm() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.baseImage,
      data: {
        'imageAsset': ImageConstants.failedVerification,
      },
      title: 'Data belum lengkap, lengkapi seluruh data yang tersedia',
      description: 'Simpan draft jika data yang diterima debitur belum lengkap',
      mainButtonTitle: 'Sip, mengerti',
    );
  }

  Future _showErrorDialog(String errorMessage) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.error,
      title: 'Gagal',
      description: errorMessage,
      mainButtonTitle: 'COBA LAGI',
    );
  }

  Map<String, dynamic> generatePayload(bool isDraft) {
    return {
      'isDraft': isDraft,
      'prakarsaId': prakarsaId,
      'agunanTambahanTanahId': id,
      'pembanding': List.generate(
        listDataPembanding.length,
        (index) => listDataPembanding[index].toJson(),
      ),
    };
  }

  List<String> _getAllowedType(int index) {
    List<String> listAllowedType = [];

    if (listValue[index].text == 'Foto Langsung') {
      listAllowedType = ['jpg', 'jpeg', 'png'];
    } else {
      listAllowedType = ['jpg', 'jpeg', 'png', 'pdf'];
    }

    return listAllowedType;
  }

  bool _getValidationType(int index, String type) {
    bool validation = false;

    if (listValue[index].text == 'Internet') {
      validation = isImageOrPdf(type);
    } else {
      validation = isImage(type);
    }

    return validation;
  }
}
