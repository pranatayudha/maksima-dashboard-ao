import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_penilaian_model.dart';
import '../../../../../../../../../../application/models/item_data_pembanding_model.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';

class FormPenilaianViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  final _dialogService = locator<DialogService>();
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();

  final String prakarsaId;
  final String jenisPenilaian;
  final String id;

  FormPenilaianViewModel({
    required this.id,
    required this.prakarsaId,
    required this.jenisPenilaian,
  });

  final jugmentHargaAssetController = TextEditingController();
  final nominalNPWController = TextEditingController();
  final nominalNLController = TextEditingController();
  final nominalPNPWController = TextEditingController();
  final nominalPNLController = TextEditingController();
  final nominalNilaiPengikatanController = TextEditingController();
  final bankNeedToKnowController = TextEditingController();
  final analisaAgunanTambahan = TextEditingController();

  DetailPenilaianModel? _detailPenilaian;
  DetailPenilaianModel? get detailPenilaian => _detailPenilaian;
  List<ItemDataPembandingModel> listDataPembanding = [];

  String idAgunan = '';
  String agunanType = '';

  double? coveragePiutang;
  double? coverageNL;
  double? coveragePNPW;
  double? coveragePNL;
  double? coverageNPW;
  double plafondAwal = 500000000; //initial value

  double? maxValueNL;
  double? maxValuePNPW;
  double? maxValuePNL;

  // Judgement NJOP
  double? njopPerM2;
  double? luasTanah;

  // Judgement Data tertinggi
  double? hargaTanahTertinggi;

  // Judgement Data rata-rata
  double? hargaTanahRata2;

  // Judgement Data Terendah
  double? hargaTanahTerendah;

  bool isLoadingForm = false;

  void initialize() async {
    idAgunan = id;
    setLoadingForm(true);
    if (idAgunan.isNotEmpty) {
      await fetchPenilaian(int.parse(idAgunan));
    }
    await fetchDetailAgunanTambahan();
    await fetchDetailDataPembanding();
    _prepopulatePenilaian();
    setLoadingForm(false);
  }

  void setLoadingForm(bool value) {
    isLoadingForm = value;
    notifyListeners();
  }

  void _prepopulatePenilaian() {
    if (detailPenilaian != null) {
      nominalNPWController
        ..text = RupiahFormatter.formatWithOutRp(detailPenilaian?.nPW)
        ..selection = TextSelection.collapsed(
          offset: nominalNPWController.text.length,
        );

      nominalNLController
        ..text = RupiahFormatter.formatWithOutRp(detailPenilaian?.nL)
        ..selection = TextSelection.collapsed(
          offset: nominalNLController.text.length,
        );

      nominalPNPWController
        ..text = RupiahFormatter.formatWithOutRp(detailPenilaian?.pNPW)
        ..selection = TextSelection.collapsed(
          offset: nominalPNPWController.text.length,
        );

      nominalPNLController
        ..text = RupiahFormatter.formatWithOutRp(detailPenilaian?.pNL)
        ..selection = TextSelection.collapsed(
          offset: nominalPNLController.text.length,
        );

      nominalNilaiPengikatanController
        ..text =
            RupiahFormatter.formatWithOutRp(detailPenilaian?.nilaiPengikatan)
        ..selection = TextSelection.collapsed(
          offset: nominalNilaiPengikatanController.text.length,
        );

      analisaAgunanTambahan
        ..text = detailPenilaian?.analisaAgunanTambahan ?? ''
        ..selection = TextSelection.collapsed(
          offset: analisaAgunanTambahan.text.length,
        );

      jugmentHargaAssetController
        ..text = detailPenilaian?.judgementHargaAset ?? ''
        ..selection = TextSelection.collapsed(
          offset: jugmentHargaAssetController.text.length,
        );

      bankNeedToKnowController
        ..text = detailPenilaian?.judgementHargaAset ?? ''
        ..selection = TextSelection.collapsed(
          offset: bankNeedToKnowController.text.length,
        );

      updatejugmentHargaAssetController(
        detailPenilaian?.judgementHargaAset ?? '',
      );
      updateNominalPengikat(nominalNilaiPengikatanController.text);
    }
  }

  static int _removeThousandsSeparator(String text) {
    final removedThousandsSeparator = text.split('.').join();

    return int.parse(removedThousandsSeparator);
  }

  void updatejugmentHargaAssetController(String val) {
    jugmentHargaAssetController.text = val;
    double temp = 0.0;
    switch (val) {
      case 'NJOP':
        temp = (njopPerM2 ?? 0).round() * (luasTanah ?? 0);
        break;
      case 'Data Pembanding Tertinggi':
        temp = (hargaTanahTertinggi ?? 0).round() * (luasTanah ?? 0);
        break;
      case 'Data Pembanding Rata-rata':
        temp = (hargaTanahRata2 ?? 0).round() * (luasTanah ?? 0);
        break;
      case 'Data Pembanding Terendah':
        temp = (hargaTanahTerendah ?? 0).round() * (luasTanah ?? 0);
        break;
      default:
        temp = 0;
        break;
    }

    nominalNPWController.text =
        RupiahFormatter.formatWithOutRp(temp.round().toString());

    updateNominalPengikat(nominalNPWController.text);
    updateCoverageNPW(nominalNPWController.text);
    updateCoverageNL(nominalNLController.text);
    updateCoveragePNPW(nominalPNPWController.text);
    updateCoveragePNL(nominalPNLController.text);

    updateValueNL(nominalNPWController.text);
    updateValuePNL(nominalPNPWController.text);
    updateValuePNPW(nominalNPWController.text);
    notifyListeners();
  }

  void updateNominalPengikat(String value) {
    int temp = _removeThousandsSeparator(value);
    coveragePiutang = (temp / plafondAwal) * 100;
    notifyListeners();
  }

  void updateCoverageNL(String value) {
    int temp = _removeThousandsSeparator(value);
    coverageNL = (temp / plafondAwal) * 100;
    notifyListeners();
  }

  void updateCoveragePNPW(String value) {
    int temp = _removeThousandsSeparator(value);
    coveragePNPW = (temp / plafondAwal) * 100;
    notifyListeners();
  }

  void updateCoveragePNL(String value) {
    int temp = _removeThousandsSeparator(value);
    coveragePNL = (temp / plafondAwal) * 100;
    notifyListeners();
  }

  void updateCoverageNPW(String value) {
    int temp = _removeThousandsSeparator(value);
    coverageNPW = (temp / plafondAwal) * 100;
    notifyListeners();
  }

  void updateValueNL(String value) {
    int temp = _removeThousandsSeparator(value);
    double result = (0.9 * temp).roundToDouble();
    maxValueNL = result;
    nominalNLController.text = RupiahFormatter.formatWithOutRp(result);
    notifyListeners();
  }

  void updateValuePNPW(String value) {
    int temp = _removeThousandsSeparator(value);
    double result = (1.1 * temp).roundToDouble();
    maxValuePNPW = result;
    nominalPNPWController.text = RupiahFormatter.formatWithOutRp(result);
    notifyListeners();
  }

  void updateValuePNL(String value) {
    int temp = _removeThousandsSeparator(value);
    double result = (0.9 * temp).roundToDouble();
    maxValuePNL = result;
    nominalPNLController.text = RupiahFormatter.formatWithOutRp(result);
    notifyListeners();
  }

  Future fetchDetailAgunanTambahan() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahDetail(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        njopPerM2 =
            (res?.nJOPm2 ?? '').isNotEmpty ? double.parse(res?.nJOPm2 ?? '0') : 0;
        luasTanah = (res?.luasTanah ?? '').isNotEmpty
            ? double.parse(res?.luasTanah ?? '0')
            : 0;
      },
    );
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
      (l) => null,
      (res) async {
        listDataPembanding = res;
        listDataPembanding.sort(
          ((a, b) => double.parse(a.hargaTanahPerM2 ?? '0')
              .compareTo(double.parse(b.hargaTanahPerM2 ?? '0'))),
        );

        hargaTanahTerendah =
            double.parse(listDataPembanding[0].hargaTanahPerM2 ?? '0');

        hargaTanahTertinggi = double.parse(
          listDataPembanding[listDataPembanding.length - 1].hargaTanahPerM2 ??
              '0',
        );

        double temp = 0;

        listDataPembanding.forEach((element) {
          temp = temp + double.parse(element.hargaTanahPerM2 ?? '0');
        });

        hargaTanahRata2 = temp / listDataPembanding.length;
      },
    );
    notifyListeners();
  }

  Future fetchPenilaian(int id) async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchDetailPenilaian(
        id: id,
        prakarsaId: prakarsaId,
      ),
    );

    response.fold(
      (l) => null,
      (res) async {
        _detailPenilaian = res;
        notifyListeners();
      },
    );
    notifyListeners();
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
      savePenilaian(isSavedDrafts);
    }
  }

  Map<String, dynamic> _generatePayload(bool isDraft) {
    return {
      'isDraft': isDraft,
      'agunanTambahanTanahId': idAgunan,
      'prakarsaId': prakarsaId,
      'jenisPenilaian': jenisPenilaian,
      if (jenisPenilaian == 'Penilaian Internal')
        'metodePendekatan': 'Pendekatan Data Pasar',
      if (jenisPenilaian == 'Penilaian Internal')
        'judgementHargaAset': jugmentHargaAssetController.text,
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
      if (jenisPenilaian == 'Penilaian KJPP Rekanan' ||
          jenisPenilaian == 'Penilaian KJPP Non Rekanan')
        'opiniKJPP': bankNeedToKnowController.text,
      'analisaAgunanTambahan': analisaAgunanTambahan.text,
      if (jenisPenilaian == 'Penilaian Internal')
        'thingsBanksNeedToKnow': bankNeedToKnowController.text,
    };
  }

  Future savePenilaian(bool isDraft) async {
    final payload = _generatePayload(isDraft);

    final res = await _agunanTambahanAPI.postDataPenilaian(
      payload: payload,
    );

    res.fold(
      (l) => _showErrorDialog(l),
      (r) => _showSuccessDialog(isDraft).then(
        (value) {
          if (id.isNotEmpty) {
            navigateBack(isPassed: true);
          }
        },
      ),
    );
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
              ? 'Pastikan lengkapi seluruh data agunan pokok'
              : 'Data telah berhasil disimpan disistem',
          mainButtonTitle: 'Sip, mengerti',
        )
        .then((value) => navigateBack(isPassed: true));
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
