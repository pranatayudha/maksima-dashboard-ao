import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../application/models/detail_dokumen_lainnya.dart';
import '../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../infrastructure/apis/perusahaan_api.dart';
import '../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormDokumenLainnyaViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _dialogService = locator<DialogService>();
  final _mediaService = locator<MaksimaMediaService>();
  final _navigationService = locator<NavigationService>();

  final _masterAPI = locator<MasterAPI>();
  final _perusahaanAPI = locator<PerusahaanAPI>();

  final String prakarsaId;
  final int codeTable;
  FormDokumenLainnyaViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  Future initialize() async {
    await fetchDokumenLainnya();

    if (_dokumenLainnya == null) {
      addDokumenLainnya();
    }
  }

  List<DetailDokumenLainnya>? _dokumenLainnya;
  List<DetailDokumenLainnya>? get dokumenLainnya => _dokumenLainnya;
  Future fetchDokumenLainnya() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchDokumenLainnya(
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (errorMessage) {
        _dokumenLainnya = null;
        notifyListeners();
      },
      (result) async {
        _dokumenLainnya = result;
        notifyListeners();

        if (_dokumenLainnya != null) {
          _dokumenLainnya!.forEach((element) => addDokumenLainnya());
          await _prepopulateDokumenLainnyaTextFields();
          await _prepopulateDokumenLainnyaDoc();
        }
      },
    );
  }

  Future _prepopulateDokumenLainnyaTextFields() async {
    for (int i = 0; i < _dokumenLainnya!.length; i++) {
      namaDokumenController[i]
        ..text = (_dokumenLainnya![i].docName ?? '').toUpperCase()
        ..selection = TextSelection.collapsed(
          offset: namaDokumenController[i].text.length,
        );

      noDokumenController[i]
        ..text = _dokumenLainnya![i].docNum ?? ''
        ..selection = TextSelection.collapsed(
          offset: noDokumenController[i].text.length,
        );

      tanggalTerbitController[i]
        ..text = _dokumenLainnya![i].dateOfDocument != null
            ? _dokumenLainnya![i].dateOfDocument! != ''
                ? DateStringFormatter.forOutputDate(
                    _dokumenLainnya![i].dateOfDocument!,
                  )
                : ''
            : ''
        ..selection = TextSelection.collapsed(
          offset: tanggalTerbitController[i].text.length,
        );
    }
  }

  List<String?> docUrl = [];
  List<String?> docUrlPublic = [];
  Future _prepopulateDokumenLainnyaDoc() async {
    for (var i = 0; i <= _dokumenLainnya!.length; i++) {
      docUrl[i] = _dokumenLainnya![i].path!;
      docUrlPublic[i] = await _getPublicFile(_dokumenLainnya![i].path!);
      notifyListeners();
    }
  }

  void clearFileDokumenLainnya(int indexData, int indexUrl) {
    switch (indexUrl) {
      case 0:
        docUrlPublic[indexData] = '';
        docUrl[indexData] = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFileDokumenLainnya(
    int indexData,
    int indexUrl,
    String url,
  ) async {
    switch (indexUrl) {
      case 0:
        docUrl[indexData] = url;
        docUrlPublic[indexData] = await _getPublicFile(url);
        break;
      default:
    }
    notifyListeners();
  }

  Future uploadFileDokumenLainnya(
    BuildContext ctx,
    int indexData,
    int indexUrl,
  ) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _uploadDocumentDokumenLainnya(res, indexData, indexUrl);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
    notifyListeners();
  }

  Future _uploadDocumentDokumenLainnya(
    PlatformFile file,
    int indexData,
    int indexUrl,
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
        _setUrlFileDokumenLainnya(indexData, indexUrl, url);
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

  List<TextEditingController> namaDokumenController = [];
  void updateNamaDokumenController(String val, int i) =>
      namaDokumenController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> noDokumenController = [];
  void updateNoDokumenController(String val, int i) =>
      noDokumenController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> tanggalTerbitController = [];
  void updateTanggalTerbitController(String val, int i) =>
      tanggalTerbitController[i].text = val.trim();

  int dokumenLainnyaLength = 0;
  Future addDokumenLainnya() async {
    namaDokumenController.add(TextEditingController());
    noDokumenController.add(TextEditingController());
    tanggalTerbitController.add(TextEditingController());
    docUrl.add(null);
    docUrlPublic.add(null);
    dokumenLainnyaLength++;
    notifyListeners();
  }

  Future removeDokumenLainnya(int i) async {
    if (i < dokumenLainnyaLength) {
      namaDokumenController.removeAt(i);
      noDokumenController.removeAt(i);
      tanggalTerbitController.removeAt(i);
      docUrl.removeAt(i);
      docUrlPublic.removeAt(i);
      dokumenLainnyaLength--;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> _generateDokumenLainnyaMap({
    required bool isSavedDrafts,
  }) async {
    final dokumenLainnyaMap = [];

    for (int i = 0; i < dokumenLainnyaLength; i++) {
      dokumenLainnyaMap.add({
        'docName': namaDokumenController[i].text.trim(),
        'path': docUrl[i] ?? '',
        'docNum': noDokumenController[i].text.trim(),
        'dateOfDocument': tanggalTerbitController[i].text.isNotEmpty
            ? DateStringFormatter.forInputDate(
                tanggalTerbitController[i].text.trim(),
              )
            : tanggalTerbitController[i].text.trim(),
      });
    }

    return {
      'prakarsaId': prakarsaId,
      'isDraft': isSavedDrafts,
      'otherDocument': dokumenLainnyaMap,
    };
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final dokumenLainnyaMap = await _generateDokumenLainnyaMap(
      isSavedDrafts: isSavedDrafts,
    );

    final res = await runBusyFuture(
      _perusahaanAPI.saveDokumenLainnya(
        payload: dokumenLainnyaMap,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialogForm(),
      (successMap) => _showSuccessDialog(isSavedDrafts),
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
      _postData(isSavedDrafts: isSavedDrafts);
    }
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
}
