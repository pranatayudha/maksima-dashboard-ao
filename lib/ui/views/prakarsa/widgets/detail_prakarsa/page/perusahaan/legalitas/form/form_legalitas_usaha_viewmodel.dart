import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_legalitas.dart';
import '../../../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../../infrastructure/apis/perusahaan_api.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormLegalitasUsahaViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _dialogService = locator<DialogService>();
  final _mediaService = locator<MaksimaMediaService>();
  final _navigationService = locator<NavigationService>();

  final _masterAPI = locator<MasterAPI>();
  final _perusahaanAPI = locator<PerusahaanAPI>();

  final String prakarsaId;
  final int codeTable;

  FormLegalitasUsahaViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  String _prakarsaType = '';
  Future initialize() async {
    _prakarsaType = InitialCodeTableFormatter.getPrakarsaType(codeTable);

    await _fecthLegalitas();
  }

  DetailLegalitas? _legalitas;
  DetailLegalitas? get legalitas => _legalitas;
  Future _fecthLegalitas() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchLegalitas(
        prakarsaId: prakarsaId,
        prakarsaType: _prakarsaType,
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _legalitas = result;
        notifyListeners();

        await _prepopulateAktaPendirianTextFields();
        await _prepopulateAktaPendirianDocuments();

        if (_legalitas!.deedOthers != null) {
          _legalitas!.deedOthers!.forEach((e) => addAktaPerubahanLain());
          await _prepopulateAktaPerubahanTerakhirTextFields();
          await _prepopulateAktaPerubahanTerakhirDocuments();
        }
      },
    );
  }

  Future _prepopulateAktaPendirianTextFields() async {
    noAktaPendirianController
      ..text = (_legalitas!.deedEstNum?.isNotEmpty ?? false)
          ? _legalitas!.deedEstNum!
          : '-'
      ..selection = TextSelection.collapsed(
        offset: noAktaPendirianController.text.length,
      );

    tanggalAktaPendirianController
      ..text = (_legalitas!.dateOfDeedEst?.isNotEmpty ?? false)
          ? DateStringFormatter.forOutputRitel(
              _legalitas!.dateOfDeedEst!,
            )
          : '-'
      ..selection = TextSelection.collapsed(
        offset: tanggalAktaPendirianController.text.length,
      );

    tempatAktaPendirianController
      ..text = (_legalitas!.placeOfDeedEst?.isNotEmpty ?? false)
          ? _legalitas!.placeOfDeedEst!
          : '-'
      ..selection = TextSelection.collapsed(
        offset: tempatAktaPendirianController.text.length,
      );

    namaNotarisController
      ..text = (_legalitas!.notaryName?.isNotEmpty ?? false)
          ? _legalitas!.notaryName!
          : ''
      ..selection = TextSelection.collapsed(
        offset: namaNotarisController.text.length,
      );

    tempatKedudukanNotarisController
      ..text = (_legalitas!.notaryPosition?.isNotEmpty ?? false)
          ? _legalitas!.notaryPosition!
          : ''
      ..selection = TextSelection.collapsed(
        offset: tempatKedudukanNotarisController.text.length,
      );

    noSKKumhamPendirianController
      ..text = (_legalitas!.skKumhamNum?.isNotEmpty ?? false)
          ? _legalitas!.skKumhamNum!
          : ''
      ..selection = TextSelection.collapsed(
        offset: noSKKumhamPendirianController.text.length,
      );

    tanggalSKKumhamPendirianController
      ..text = (_legalitas!.dateOfSkKumham?.isNotEmpty ?? false)
          ? DateStringFormatter.forOutputRitel(
              _legalitas!.dateOfSkKumham!,
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalSKKumhamPendirianController.text.length,
      );
  }

  String aktaPendirianUrl = '';
  String aktaPendirianUrlPublic = '';
  String skKumhamPendirianUrl = '';
  String skKumhamPendirianUrlPublic = '';
  Future _prepopulateAktaPendirianDocuments() async {
    if (_legalitas!.deedEstPath != null) {
      aktaPendirianUrl = _legalitas!.deedEstPath!;
      aktaPendirianUrlPublic = await _getPublicFile(aktaPendirianUrl);
      notifyListeners();
    }

    if (_legalitas!.skKumhamPath != null) {
      skKumhamPendirianUrl = _legalitas!.skKumhamPath!;
      skKumhamPendirianUrlPublic = await _getPublicFile(skKumhamPendirianUrl);
      notifyListeners();
    }
  }

  void clearFilePendirian(int index) {
    switch (index) {
      case 0:
        aktaPendirianUrl = '';
        aktaPendirianUrlPublic = '';
        break;
      case 1:
        skKumhamPendirianUrl = '';
        skKumhamPendirianUrlPublic = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFilePendirian(int index, String url) async {
    switch (index) {
      case 0:
        aktaPendirianUrl = url;
        aktaPendirianUrlPublic = await _getPublicFile(url);
        break;
      case 1:
        skKumhamPendirianUrl = url;
        skKumhamPendirianUrlPublic = await _getPublicFile(url);
        break;
      default:
    }
    notifyListeners();
  }

  Future uploadFilePendirian(BuildContext ctx, int index) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _uploadDocumentPendirian(res, index);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
    notifyListeners();
  }

  Future _uploadDocumentPendirian(
    PlatformFile file,
    int index,
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
        _setUrlFilePendirian(index, url);
        notifyListeners();
      },
    );
  }

  Future _prepopulateAktaPerubahanTerakhirTextFields() async {
    if (_legalitas!.deedOthers != null) {
      for (int i = 0; i < _legalitas!.deedOthers!.length; i++) {
        noAktaPerubahanTerakhirController[i]
          ..text = _legalitas!.deedOthers![i].deedEstNum ?? ''
          ..selection = TextSelection.collapsed(
            offset: noAktaPerubahanTerakhirController[i].text.length,
          );

        tanggalAktaPerubahanTerakhirController[i]
          ..text = _legalitas!.deedOthers![i].dateOfDeedEst != null
              ? DateStringFormatter.forOutputRitel(
                  _legalitas!.deedOthers![i].dateOfDeedEst!,
                )
              : ''
          ..selection = TextSelection.collapsed(
            offset: tanggalAktaPerubahanTerakhirController[i].text.length,
          );

        tempatAktaPerubahanTerakhirController[i]
          ..text = _legalitas!.deedOthers![i].placeOfDeedEst ?? ''
          ..selection = TextSelection.collapsed(
            offset: tempatAktaPerubahanTerakhirController[i].text.length,
          );

        namaNotarisKeduaController[i]
          ..text = _legalitas!.deedOthers![i].notaryName ?? ''
          ..selection = TextSelection.collapsed(
            offset: namaNotarisKeduaController[i].text.length,
          );

        tempatKedudukanNotarisKeduaController[i]
          ..text = (_legalitas!.deedOthers![i].notaryPosition ?? '')
          ..selection = TextSelection.collapsed(
            offset: tempatKedudukanNotarisKeduaController[i].text.length,
          );

        noSKKumhamPerubahanTerakhirController[i]
          ..text = _legalitas!.deedOthers![i].skKumhamNum ?? ''
          ..selection = TextSelection.collapsed(
            offset: noSKKumhamPerubahanTerakhirController[i].text.length,
          );

        tanggalSKKumhamPerubahanTerakhirController[i]
          ..text = _legalitas!.deedOthers![i].dateOfSkKumham != null
              ? DateStringFormatter.forOutputRitel(
                  _legalitas!.deedOthers![i].dateOfSkKumham!,
                )
              : ''
          ..selection = TextSelection.collapsed(
            offset: tanggalSKKumhamPerubahanTerakhirController[i].text.length,
          );
      }
    }
  }

  List<String?> aktaPerubahanTerakhirUrl = [];
  List<String?> aktaPerubahanTerakhirUrlPublic = [];
  List<String?> skKumhamPerubahanTerakhirUrl = [];
  List<String?> skKumhamPerubahanTerakhirUrlPublic = [];
  Future _prepopulateAktaPerubahanTerakhirDocuments() async {
    if (_legalitas!.deedOthers != null) {
      for (int i = 0; i < _legalitas!.deedOthers!.length; i++) {
        if (_legalitas!.deedOthers![i].deedEstFilePath != null) {
          aktaPerubahanTerakhirUrl[i] =
              (_legalitas!.deedOthers![i].deedEstFilePath!);
          aktaPerubahanTerakhirUrlPublic[i] = await _getPublicFile(
            _legalitas!.deedOthers![i].deedEstFilePath!,
          );
          notifyListeners();
        }

        if (_legalitas!.deedOthers![i].skKumhamFilePath != null) {
          skKumhamPerubahanTerakhirUrl[i] =
              (_legalitas!.deedOthers![i].skKumhamFilePath!);
          skKumhamPerubahanTerakhirUrlPublic[i] = await _getPublicFile(
            _legalitas!.deedOthers![i].skKumhamFilePath!,
          );
          notifyListeners();
        }
      }
    }
  }

  void clearFilePerubahan(int indexData, int indexUrl) {
    switch (indexUrl) {
      case 0:
        aktaPerubahanTerakhirUrl[indexData] = '';
        aktaPerubahanTerakhirUrlPublic[indexData] = '';
        break;
      case 1:
        skKumhamPerubahanTerakhirUrl[indexData] = '';
        skKumhamPerubahanTerakhirUrlPublic[indexData] = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFilePerubahan(int indexData, int indexUrl, String url) async {
    switch (indexUrl) {
      case 0:
        aktaPerubahanTerakhirUrl[indexData] = url;
        aktaPerubahanTerakhirUrlPublic[indexData] = await _getPublicFile(url);
        break;
      case 1:
        skKumhamPerubahanTerakhirUrl[indexData] = url;
        skKumhamPerubahanTerakhirUrlPublic[indexData] =
            await _getPublicFile(url);
        break;
      default:
    }
    notifyListeners();
  }

  Future uploadFilePerubahan(
    BuildContext ctx,
    int indexData,
    int indexUrl,
  ) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _uploadDocumentPerubahan(res, indexData, indexUrl);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
    notifyListeners();
  }

  Future _uploadDocumentPerubahan(
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
        _setUrlFilePerubahan(indexData, indexUrl, url);
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

  final noAktaPendirianController = TextEditingController();
  final tanggalAktaPendirianController = TextEditingController();
  final tempatAktaPendirianController = TextEditingController();

  final namaNotarisController = TextEditingController();
  void updateNamaNotarisController(String val) =>
      namaNotarisController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final tempatKedudukanNotarisController = TextEditingController();
  void updateTempatKedudukanNotarisController(String val) =>
      tempatKedudukanNotarisController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final noSKKumhamPendirianController = TextEditingController();
  void updateNoSKKumhamPendirianController(String val) =>
      noSKKumhamPendirianController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final tanggalSKKumhamPendirianController = TextEditingController();
  void updateTanggalSKKumhamPendirianController(String val) =>
      tanggalSKKumhamPendirianController.text = val.trim();

  List<TextEditingController> noAktaPerubahanTerakhirController = [];
  void updateNoAktaPerubahanTerakhirController(String val, int i) =>
      noAktaPerubahanTerakhirController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> tanggalAktaPerubahanTerakhirController = [];
  void updateTanggalAktaPerubahanTerakhirController(String val, int i) =>
      tanggalAktaPerubahanTerakhirController[i].text = val.trim();

  List<TextEditingController> tempatAktaPerubahanTerakhirController = [];
  void updateTempatAktaPerubahanTerakhirController(String val, int i) =>
      tempatAktaPerubahanTerakhirController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> namaNotarisKeduaController = [];
  void updateNamaNotarisKeduaController(String val, int i) =>
      namaNotarisKeduaController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> tempatKedudukanNotarisKeduaController = [];
  void updateTempatKedudukanNotarisKeduaController(String val, int i) =>
      tempatKedudukanNotarisKeduaController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> noSKKumhamPerubahanTerakhirController = [];
  void updateNoSKKumhamPerubahanTerakhirController(String val, int i) =>
      noSKKumhamPerubahanTerakhirController[i].value.copyWith(
            text: val,
            selection: TextSelection(
              baseOffset: val.length,
              extentOffset: val.length,
            ),
          );

  List<TextEditingController> tanggalSKKumhamPerubahanTerakhirController = [];
  void updateTanggalSKKumhamPerubahanTerakhirController(String val, int i) =>
      tanggalSKKumhamPerubahanTerakhirController[i].text = val.trim();

  int aktaPerubahanLength = 0;
  Future addAktaPerubahanLain() async {
    noAktaPerubahanTerakhirController.add(TextEditingController());
    tanggalAktaPerubahanTerakhirController.add(TextEditingController());
    tempatAktaPerubahanTerakhirController.add(TextEditingController());
    namaNotarisKeduaController.add(TextEditingController());
    tempatKedudukanNotarisKeduaController.add(TextEditingController());
    noSKKumhamPerubahanTerakhirController.add(TextEditingController());
    tanggalSKKumhamPerubahanTerakhirController.add(TextEditingController());
    aktaPerubahanTerakhirUrl.add(null);
    aktaPerubahanTerakhirUrlPublic.add(null);
    skKumhamPerubahanTerakhirUrl.add(null);
    skKumhamPerubahanTerakhirUrlPublic.add(null);
    aktaPerubahanLength++;
    notifyListeners();
  }

  Future removeAktaPerubahanLain(int i) async {
    if (i < aktaPerubahanLength) {
      noAktaPerubahanTerakhirController.removeAt(i);
      tanggalAktaPerubahanTerakhirController.removeAt(i);
      tempatAktaPerubahanTerakhirController.removeAt(i);
      namaNotarisKeduaController.removeAt(i);
      tempatKedudukanNotarisKeduaController.removeAt(i);
      noSKKumhamPerubahanTerakhirController.removeAt(i);
      tanggalSKKumhamPerubahanTerakhirController.removeAt(i);
      aktaPerubahanTerakhirUrl.removeAt(i);
      aktaPerubahanTerakhirUrlPublic.removeAt(i);
      skKumhamPerubahanTerakhirUrl.removeAt(i);
      skKumhamPerubahanTerakhirUrlPublic.removeAt(i);
      aktaPerubahanLength--;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> _generateLegalitasUsahaMap({
    required bool isSavedDrafts,
  }) async {
    final latestDeed = [];

    for (int i = 0; i < aktaPerubahanLength; i++) {
      latestDeed.add({
        'deedEstNum': noAktaPerubahanTerakhirController[i].text.trim(),
        'dateOfDeedEst':
            tanggalAktaPerubahanTerakhirController[i].text.isNotEmpty
                ? DateStringFormatter.forInputDate(
                    tanggalAktaPerubahanTerakhirController[i].text.trim(),
                  )
                : '',
        'placeOfDeedEst': tempatAktaPerubahanTerakhirController[i].text.trim(),
        'skKumhamNum': noSKKumhamPerubahanTerakhirController[i].text.trim(),
        'dateOfSkKumham':
            tanggalSKKumhamPerubahanTerakhirController[i].text.isNotEmpty
                ? DateStringFormatter.forInputDate(
                    tanggalSKKumhamPerubahanTerakhirController[i].text.trim(),
                  )
                : '',
        'notaryName': namaNotarisKeduaController[i].text.trim(),
        'notaryPosition': tempatKedudukanNotarisKeduaController[i].text.trim(),
        'deedEstFilePath': aktaPerubahanTerakhirUrl[i] ?? '',
        'deedEstFileName': '$prakarsaId-akta-perubahan($i)',
        'skKumhamFilePath': skKumhamPerubahanTerakhirUrl[i] ?? '',
        'skKumhamFileName': '$prakarsaId-skkumham-perubahan($i)',
      });
    }

    return {
      'prakarsaId': prakarsaId,
      'isDraft': isSavedDrafts,
      'deedEstNum': noAktaPendirianController.text.trim(),
      'dateOfDeedEst': tanggalAktaPendirianController.text.isNotEmpty
          ? DateStringFormatter.forInputDate(
              tanggalAktaPendirianController.text.trim(),
            )
          : '',
      'placeOfDeedEst': tempatAktaPendirianController.text.trim(),
      'skKumhamNum': noSKKumhamPendirianController.text.trim(),
      'dateOfSkKumham': tanggalSKKumhamPendirianController.text.isNotEmpty
          ? DateStringFormatter.forInputDate(
              tanggalSKKumhamPendirianController.text.trim(),
            )
          : '',
      'notaryName': namaNotarisController.text.trim(),
      'notaryPosition': tempatKedudukanNotarisController.text.trim(),
      'deedEstFilePath': aktaPendirianUrl,
      'deedEstFileName': '$prakarsaId-akta-pendirian',
      'skKumhamFilePath': skKumhamPendirianUrl,
      'skKumhamFileName': '$prakarsaId-skkumham-pendirian',
      'deedOthers': latestDeed,
    };
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final legalitasUsahaMap = await _generateLegalitasUsahaMap(
      isSavedDrafts: isSavedDrafts,
    );

    final res = await runBusyFuture(
      _perusahaanAPI.saveLegalitasUsaha(
        prakarsaType: _prakarsaType,
        payload: legalitasUsahaMap,
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
