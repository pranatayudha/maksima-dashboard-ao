import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/calculation_agunan_model.dart';
import '../../../../../../../../../../application/models/detail_agunan_pokok_model.dart';
import '../../../../../../../../../../application/models/user_location.dart';
import '../../../../../../../../../../application/services/location_service.dart';
import '../../../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../../../application/services/url_launcher_service.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_pokok_api.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormAgunanPersediaanViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  final _agunanPokokAPI = locator<AgunanPokokAPI>();
  final _masterAPI = locator<MasterAPI>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _mediaService = locator<MaksimaMediaService>();
  final _locationService = locator<MaksimaLocationService>();

  final String prakarsaId;
  final int codeTable;
  final String id;
  final double width;

  FormAgunanPersediaanViewModel({
    required this.id,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
  });

  final jenisPengikatanController = TextEditingController();
  final nominalNPWController = TextEditingController();
  final nominalNLController = TextEditingController();
  final nominalPNPWController = TextEditingController();
  final nominalPNLController = TextEditingController();
  final nominalNilaiPengikatanController = TextEditingController();
  final analisaAgunanPokokController = TextEditingController();

  DetailAgunanPokokModel? _detailAgunanPokok;
  DetailAgunanPokokModel? get detailAgunanPokok => _detailAgunanPokok;
  CalculationAgunanModel? _calculationAgunan;
  CalculationAgunanModel? get calculationAgunan => _calculationAgunan;

  String idAgunan = '';
  String agunanType = '';
  String? agunanPublicUrl;
  String templateDocument =
      'https://storage.googleapis.com/bridgtl-prt-d-bkt-apps/custom/file/tamplate-persediaan.xlsx';

  double? coveragePiutang;
  double? coverageNL;
  double? coveragePNPW;
  double? coveragePNL;
  double? maxValuePNL;

  bool isLoadingUpload = false;

  void initialize() async {
    await _getUserLocation();
    idAgunan = id;
    if (id.isNotEmpty) {
      await fetchDetailAgunanPokok(int.parse(id));
    } else {
      await getCalculation();
    }
  }

  UserLocation? userLocation;
  String addressName = '';
  Future _getUserLocation() async {
    userLocation = await _locationService.getLocation();
    notifyListeners();

    if (userLocation != null) {
      addressName = await _locationService.getAddressFromLatLng(
        userLocation!.latitude!,
        userLocation!.longitude!,
      );
      notifyListeners();
    }
  }

  Future fetchDetailAgunanPokok(int id) async {
    final response = await runBusyFuture(
      _agunanPokokAPI.fetchAgunanPokokDetail(
        id: id,
        prakarsaId: prakarsaId,
      ),
    );

    response.fold(
      (l) => null,
      (res) async {
        _detailAgunanPokok = res;
        agunanType = _detailAgunanPokok?.jenisAgunanPokok != 250
            ? 'Persediaan'
            : 'Piutang';
        agunanPublicUrl =
            await _getPublicFile(_detailAgunanPokok?.pathUploadExcel ?? '');
        await getCalculation();

        if (_detailAgunanPokok!.pathFotoAgunanPersediaan != null) {
          listPathFotoPersediaan.clear();
          listPathFotoPersediaanPublic.clear();
          _detailAgunanPokok!.pathFotoAgunanPersediaan!.forEach((foto) async {
            String? temp = await _getPublicFile(foto.path!);
            if (temp.isNotEmpty) {
              listPathFotoPersediaan.add(foto.path);
              listPathFotoPersediaanPublic.add(temp);
              listLocationFotoPersediaan.add(
                foto.meta!.locationDetail!.latLng,
              );
              listLocationNameFotoPersediaan.add(
                foto.meta!.locationDetail!.name,
              );
              listLocationDateFotoPersediaan.add(
                foto.meta!.photoName,
              );
              listLocationTimeFotoPersediaan.add(
                foto.meta!.timeName,
              );
              notifyListeners();
            }
          });
        }

        await getCalculation();
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future getCalculation() async {
    final res = await runBusyFuture(
      _agunanPokokAPI.getCalculationAgunan(
        prakarsaId: prakarsaId,
        jenisAgunanPokok: 193,
      ),
    );

    res.fold(
      (l) => null,
      (calculationResult) {
        _calculationAgunan = calculationResult;
        _prepopulateAgunan();
      },
    );
    notifyListeners();
  }

  Future deleteExcelPath() async {
    final res = await runBusyFuture(
      _agunanPokokAPI.deleteAgunanPokok(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (r) {
        agunanPublicUrl = null;
        notifyListeners();
      },
    );
  }

  void _prepopulateAgunan() {
    var valueNPW = (detailAgunanPokok?.nPW ?? '').isNotEmpty
        ? double.parse((detailAgunanPokok?.nPW ?? '0')).toInt().toString()
        : (calculationAgunan?.npw ?? '0');
    nominalNPWController
      ..text = RupiahFormatter.formatWithOutRp(valueNPW)
      ..selection = TextSelection.collapsed(
        offset: nominalNPWController.text.length,
      );

    var valueNL = (detailAgunanPokok?.nL ?? '').isNotEmpty
        ? double.parse((detailAgunanPokok?.nL ?? '0')).toInt().toString()
        : (calculationAgunan?.nl ?? '0');
    nominalNLController
      ..text = RupiahFormatter.formatWithOutRp(valueNL)
      ..selection = TextSelection.collapsed(
        offset: nominalNLController.text.length,
      );

    var valuePNPW = (detailAgunanPokok?.pNPW ?? '').isNotEmpty
        ? double.parse((detailAgunanPokok?.pNPW ?? '0')).toInt().toString()
        : (calculationAgunan?.pnpw ?? '0');
    nominalPNPWController
      ..text = RupiahFormatter.formatWithOutRp(valuePNPW)
      ..selection = TextSelection.collapsed(
        offset: nominalPNPWController.text.length,
      );

    var valuePNL = (detailAgunanPokok?.pNL ?? '').isNotEmpty
        ? double.parse((detailAgunanPokok?.pNL ?? '0')).toInt().toString()
        : (calculationAgunan?.pnl ?? '0');
    nominalPNLController
      ..text = RupiahFormatter.formatWithOutRp(valuePNL)
      ..selection = TextSelection.collapsed(
        offset: nominalPNLController.text.length,
      );

    nominalNilaiPengikatanController
      ..text = (detailAgunanPokok?.nilaiPengikatan ?? '').isNotEmpty
          ? RupiahFormatter.formatWithOutRp(
              double.parse(detailAgunanPokok?.nilaiPengikatan ?? '0')
                  .toInt()
                  .toString(),
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: nominalNilaiPengikatanController.text.length,
      );

    analisaAgunanPokokController
      ..text = detailAgunanPokok?.analisapokok ?? ''
      ..selection = TextSelection.collapsed(
        offset: analisaAgunanPokokController.text.length,
      );

    jenisPengikatanController
      ..text = detailAgunanPokok?.jenisPengikatan ?? ''
      ..selection = TextSelection.collapsed(
        offset: jenisPengikatanController.text.length,
      );
    updateNominalPengikat(nominalNilaiPengikatanController.text);

    updateJenisPengikatanController('Fidusia Sesuai UU');

    updateCoverage();
  }

  void updateCoverage() {
    updateCoverageNL(nominalNLController.text);
    updateCoveragePNPW(nominalPNPWController.text);
    updateCoveragePNL(nominalPNLController.text);
    notifyListeners();
  }

  static int _removeThousandsSeparator(String text) {
    final removedThousandsSeparator = text.split('.').join();

    return int.parse(removedThousandsSeparator);
  }

  void updateNominalPengikat(String value) {
    if (value.isNotEmpty) {
      int temp = _removeThousandsSeparator(value);
      coveragePiutang =
          (temp / double.parse(calculationAgunan?.plafonAwal ?? '0')) * 100;
    }
    notifyListeners();
  }

  void updateCoverageNL(String value) {
    if (value.isNotEmpty) {
      int temp = _removeThousandsSeparator(value);
      coverageNL =
          (temp / double.parse(calculationAgunan?.plafonAwal ?? '0')) * 100;
    }
    notifyListeners();
  }

  void updateCoveragePNPW(String value) {
    if (value.isNotEmpty) {
      int temp = _removeThousandsSeparator(value);
      maxValuePNL = 0.7 * temp;
      coveragePNPW =
          (temp / double.parse(calculationAgunan?.plafonAwal ?? '0')) * 100;
    }
    notifyListeners();
  }

  void updateCoveragePNL(String value) {
    if (value.isNotEmpty) {
      int temp = _removeThousandsSeparator(value);
      coveragePNL =
          (temp / double.parse(calculationAgunan?.plafonAwal ?? '0')) * 100;
    }
    notifyListeners();
  }

  Future pickFile() async {
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (res != null) {
      setLoading(true);
      uploadFile(
        file: res.files[0],
        jenisAgunanPokok: 193,
      );
      notifyListeners();
    }
  }

  Future uploadFile({
    required PlatformFile file,
    required int jenisAgunanPokok,
  }) async {
    final res = await runBusyFuture(
      _masterAPI.uploadExcelAgunan(
        file: file,
        prakarsaId: prakarsaId,
        jenisAgunanPokok: jenisAgunanPokok,
        idAgunanPokok: id.isNotEmpty ? int.parse(id) : null,
        codeTable: codeTable,
      ),
    );

    res.fold(
      (l) => null,
      (r) async {
        await fetchDetailAgunanPokok(r);
      },
    );
    setLoading(false);
    notifyListeners();
  }

  void clearFotoAgunanPersediaan(int indexData, int indexUrl) {
    switch (indexUrl) {
      case 0:
        listPathFotoPersediaanPublic[indexData] = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFotoAgunanPersediaan(
    String url,
  ) async {
    listPathFotoPersediaan.add(url);
    listPathFotoPersediaanPublic.add(await _getPublicFile(url));
    listLocationFotoPersediaan
        .add('${userLocation!.latitude!},${userLocation!.longitude!}');
    listLocationNameFotoPersediaan.add(addressName);
    listLocationDateFotoPersediaan.add(
      DateFormat('dd MMMM yyyy', 'id').format(DateTime.now()).toString(),
    );
    listLocationTimeFotoPersediaan.add(
      DateFormat('hh:mm', 'id').format(DateTime.now()).toString(),
    );
    notifyListeners();
  }

  Future uploadFotoAgunanPersediaan(BuildContext ctx) async {
    final res = await _mediaService.getMultiFileType(
      allowedExtensions: [],
      fileType: FileType.image,
      allowMultiple: false,
    );

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _uploadFotoAgunanPersediaan(res);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, atau png!',
        );
      }
    }
    notifyListeners();
  }

  Future _uploadFotoAgunanPersediaan(
    PlatformFile file,
  ) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (url) {
        _navigationService.back();
        _setUrlFotoAgunanPersediaan(url);
        notifyListeners();
      },
    );
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

  Map<String, dynamic> _generatePayload(bool isDraft) {
    final data = {
      'isDraft': isDraft,
      'prakarsaId': prakarsaId,
      'jenisAgunanPokok': 193,
      'jenisPengikatan': jenisPengikatanController.text,
      'NL': nominalNLController.text.trim().isNotEmpty
          ? int.parse(nominalNLController.text.replaceAll('.', ''))
          : null,
      'PNPW': nominalPNPWController.text.trim().isNotEmpty
          ? int.parse(nominalPNPWController.text.replaceAll('.', ''))
          : null,
      'PNL': nominalPNLController.text.trim().isNotEmpty
          ? int.parse(nominalPNLController.text.replaceAll('.', ''))
          : null,
      'nilaiPengikatan': nominalNilaiPengikatanController.text.trim().isNotEmpty
          ? int.parse(
              nominalNilaiPengikatanController.text.replaceAll('.', ''),
            )
          : null,
      'analisaPokok': analisaAgunanPokokController.text.trim(),
    };

    return {
      ...data,
      'pathFotoAgunan': List.generate(
        listPathFotoPersediaan.length,
        (index) => {
          'path': listPathFotoPersediaan[index],
          'meta': {
            'photoName': listPathFotoPersediaan[index] != null
                ? listLocationDateFotoPersediaan[index].toString()
                : '',
            'timeName': listPathFotoPersediaan[index] != null
                ? listLocationTimeFotoPersediaan[index].toString()
                : '',
            'locationDetail': {
              'latLng': listLocationFotoPersediaan[index].toString(),
              'name': listLocationNameFotoPersediaan[index].toString(),
            },
          },
        },
      ),
    };
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
    );

    if (response != null && !response.confirmed) {
      saveAgunanPokok(isSavedDrafts);
    }
  }

  Future saveAgunanPokok(bool isDraft) async {
    final payload = _generatePayload(isDraft);

    final res = await _agunanPokokAPI.saveAgunanPokok(
      payload,
      codeTable,
    );

    res.fold(
      (l) => _showErrorDialogForm(),
      (r) => _showSuccessDialog(true).then(
        (value) {
          if (id.isNotEmpty) {
            navigateBack(isPassed: true);
          }
        },
      ),
    );
  }

  void downloadTemplate() => locator<URLLauncherService>().browse(
        templateDocument,
      );

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
              ? 'Pastikan lengkapi seluruh data agunan pokok'
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

  void updateJenisPengikatanController(String val) {
    jenisPengikatanController.text = val;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoadingUpload = value;
    notifyListeners();
  }

  List<String?> listPathFotoPersediaan = [];
  List<String?> listPathFotoPersediaanPublic = [];
  List<String?> listLocationFotoPersediaan = [];
  List<String?> listLocationNameFotoPersediaan = [];
  List<String?> listLocationDateFotoPersediaan = [];
  List<String?> listLocationTimeFotoPersediaan = [];
}
