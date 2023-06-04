import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/calculation_agunan_model.dart';
import '../../../../../../../../../../application/models/detail_agunan_pokok_model.dart';
import '../../../../../../../../../../application/services/url_launcher_service.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_pokok_api.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';

class FormAgunanPiutangViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  final _agunanPokokAPI = locator<AgunanPokokAPI>();
  final _masterAPI = locator<MasterAPI>();
  final _dialogService = locator<DialogService>();

  final String prakarsaId;
  final int codeTable;
  final String id;

  FormAgunanPiutangViewModel({
    required this.id,
    required this.prakarsaId,
    required this.codeTable,
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
      'https://storage.googleapis.com/bridgtl-prt-d-bkt-apps/custom/file/Template-Piutang_New.xlsx';

  double? coveragePiutang;
  double? coverageNL;
  double? coveragePNPW;
  double? coveragePNL;
  double? maxValuePNL;

  bool isLoadingUpload = false;
  bool isLoadingForm = false;

  void initialize() async {
    idAgunan = id;
    setLoadingForm(true);
    if (idAgunan.isNotEmpty) {
      await fetchDetailAgunanPokok(int.parse(idAgunan));
    } else {
      await getCalculation();
    }
    setLoadingForm(false);
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
      },
    );
    notifyListeners();
  }

  Future getCalculation() async {
    final res = await runBusyFuture(
      _agunanPokokAPI.getCalculationAgunan(
        prakarsaId: prakarsaId,
        jenisAgunanPokok: 250,
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
        jenisAgunanPokok: 250,
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
        idAgunanPokok: idAgunan.isNotEmpty ? int.parse(idAgunan) : null,
        codeTable: codeTable,
      ),
    );

    res.fold(
      (l) => _showErrorDialog(l),
      (r) async {
        idAgunan = '$r';
        await fetchDetailAgunanPokok(r);
      },
    );
    setLoading(false);
    notifyListeners();
  }

  Map<String, dynamic> _generatePayload(bool isDraft) {
    return {
      'isDraft': isDraft,
      'prakarsaId': prakarsaId,
      'jenisAgunanPokok': 250,
      'jenisPengikatan': 'Fidusia Sesuai UU',
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
      'pathFotoAgunan': [],
      'analisaPokok': analisaAgunanPokokController.text.trim(),
    };
  }

  Future validateInputs({
    required bool isSavedDrafts,
  }) async {
    if (!isSavedDrafts && (agunanPublicUrl ?? '').isEmpty) {
      _showErrorDialog('File Rincian Piutang belum di upload');
    } else {
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
        saveAgunanPokok(isSavedDrafts);
      }
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
      (r) => _showSuccessDialog(isDraft).then(
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

  void updateJenisPengikatanController(String val) {
    jenisPengikatanController.text = val;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoadingUpload = value;
    notifyListeners();
  }

  void setLoadingForm(bool value) {
    isLoadingForm = value;
    notifyListeners();
  }
}
