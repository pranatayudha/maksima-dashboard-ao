import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../application/models/detail_izin_usaha.dart';
import '../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../infrastructure/apis/perusahaan_api.dart';
import '../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormIzinUsahaViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _dialogService = locator<DialogService>();
  final _mediaService = locator<MaksimaMediaService>();
  final _navigationService = locator<NavigationService>();

  final _masterAPI = locator<MasterAPI>();
  final _perusahaanAPI = locator<PerusahaanAPI>();

  final String prakarsaId;
  final int codeTable;

  FormIzinUsahaViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  Future initialize() async {
    await fetchIzinUsaha();

    if (_izinUsaha == null) {
      addIzinUsaha();
    }
  }

  List<DetailIzinUsaha>? _izinUsaha;
  List<DetailIzinUsaha>? get izinUsaha => _izinUsaha;
  Future fetchIzinUsaha() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchIzinUsaha(
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (errorMessage) {
        _izinUsaha = null;
        notifyListeners();
      },
      (result) async {
        _izinUsaha = result;
        notifyListeners();

        _izinUsaha!.forEach((e) => addIzinUsaha());
        await _prepopulateIzinUsahaTextFields();
        await _prepopulateIzinUsahaDoc();
      },
    );
  }

  Future _prepopulateIzinUsahaTextFields() async {
    if (_izinUsaha != null) {
      for (int i = 0; i < _izinUsaha!.length; i++) {
        jenisDokumenController[i]
          ..text = (_izinUsaha![i].jenisDokumen ?? '').toUpperCase()
          ..selection = TextSelection.collapsed(
            offset: jenisDokumenController[i].text.length,
          );

        noDokumenController[i]
          ..text = _izinUsaha![i].numDokumen ?? ''
          ..selection = TextSelection.collapsed(
            offset: noDokumenController[i].text.length,
          );

        tanggalTerbitController[i]
          ..text = _izinUsaha![i].tanggalDokumen != null
              ? _izinUsaha![i].tanggalDokumen! != ''
                  ? DateStringFormatter.forOutputDate(
                      _izinUsaha![i].tanggalDokumen!,
                    )
                  : ''
              : ''
          ..selection = TextSelection.collapsed(
            offset: tanggalTerbitController[i].text.length,
          );

        tempatTerbitController[i]
          ..text = _izinUsaha![i].tempatTerbitDokumen ?? ''
          ..selection = TextSelection.collapsed(
            offset: tempatTerbitController[i].text.length,
          );
      }
    }
  }

  List<String?> docUrl = [];
  List<String?> docUrlPublic = [];
  Future _prepopulateIzinUsahaDoc() async {
    if (_izinUsaha != null) {
      for (int i = 0; i <= _izinUsaha!.length; i++) {
        docUrl[i] = _izinUsaha![i].pathDokumen!;
        docUrlPublic[i] = await _getPublicFile(_izinUsaha![i].pathDokumen!);
        notifyListeners();
      }
    }
  }

  void clearFileIzinUsaha(int indexData, int indexUrl) {
    switch (indexUrl) {
      case 0:
        docUrl[indexData] = '';
        docUrlPublic[indexData] = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFileIzinUsaha(int indexData, int indexUrl, String url) async {
    switch (indexUrl) {
      case 0:
        docUrl[indexData] = url;
        docUrlPublic[indexData] = await _getPublicFile(url);
        break;
      default:
    }
    notifyListeners();
  }

  Future uploadFileIzinUsaha(
    BuildContext ctx,
    int indexData,
    int indexUrl,
  ) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _uploadDocumentIzinUsaha(res, indexData, indexUrl);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
    notifyListeners();
  }

  Future _uploadDocumentIzinUsaha(
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
        _setUrlFileIzinUsaha(indexData, indexUrl, url);
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

  List<TextEditingController> jenisDokumenController = [];
  void updateJenisDokumenController(String val, int i) {
    jenisDokumenController[i].text = val;
    notifyListeners();
  }

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

  List<TextEditingController> tempatTerbitController = [];
  void updateTempatTerbitController(String val, int i) =>
      tempatTerbitController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  int izinUsahaLength = 0;
  Future addIzinUsaha() async {
    jenisDokumenController.add(TextEditingController());
    noDokumenController.add(TextEditingController());
    tanggalTerbitController.add(TextEditingController());
    tempatTerbitController.add(TextEditingController());
    docUrl.add(null);
    docUrlPublic.add(null);
    izinUsahaLength++;
    notifyListeners();
  }

  Future removeIzinUsaha(int i) async {
    if (i < izinUsahaLength) {
      jenisDokumenController.removeAt(i);
      noDokumenController.removeAt(i);
      tanggalTerbitController.removeAt(i);
      tempatTerbitController.removeAt(i);
      docUrl.removeAt(i);
      docUrlPublic.removeAt(i);
      izinUsahaLength--;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> _generateIzinUsahaMap({
    required bool isSavedDrafts,
  }) async {
    final izinUsahaMap = [];

    for (int i = 0; i < izinUsahaLength; i++) {
      izinUsahaMap.add({
        'jenisDokumen': jenisDokumenController[i].text.trim(),
        'numDokumen': noDokumenController[i].text.trim(),
        'tanggalDokumen': tanggalTerbitController[i].text.isNotEmpty
            ? DateStringFormatter.forInputDate(
                tanggalTerbitController[i].text.trim(),
              )
            : tanggalTerbitController[i].text.trim(),
        'tempatTerbitDokumen': tempatTerbitController[i].text.trim(),
        'pathDokumen': docUrl[i] ?? '',
      });
    }

    return {
      'prakarsaId': prakarsaId,
      'isDraft': isSavedDrafts,
      'izinUsahaDoc': izinUsahaMap,
    };
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final izinUsahaMap = await _generateIzinUsahaMap(
      isSavedDrafts: isSavedDrafts,
    );

    final res = await runBusyFuture(
      _perusahaanAPI.saveIzinUsaha(
        payload: izinUsahaMap,
      ),
    );

    res.fold(
      (errorMessage) {
        if (errorMessage.contains('tidak')) {
          _showErrorDialogValidate(errorMessage);
        } else {
          _showErrorDialogForm();
        }
      },
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

  Future _showErrorDialogValidate(String desc) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.baseImage,
      data: {
        'imageAsset': ImageConstants.failedVerification,
      },
      title: 'Invalid',
      description: desc,
      mainButtonTitle: 'Sip, mengerti',
    );
  }
}
