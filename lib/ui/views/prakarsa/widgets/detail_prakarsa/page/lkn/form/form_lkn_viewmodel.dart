import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../application/models/detail_lkn.dart';
import '../../../../../../../../infrastructure/apis/lkn_api.dart';
import '../../../../../../../../infrastructure/apis/master_api.dart';

class FormLKNViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _dialogService = locator<DialogService>();

  final _lknAPI = locator<LKNAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;
  FormLKNViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  String _prakarsaType = '';
  Future initialize() async {
    _prakarsaType = InitialCodeTableFormatter.getPrakarsaType(codeTable);

    await _fetchLaporanKunjunganNasabah();
  }

  DetailLKN? _detailLKN;
  DetailLKN? get detailLKN => _detailLKN;
  Future _fetchLaporanKunjunganNasabah() async {
    final res = await runBusyFuture(
      _lknAPI.fetch(
        prakarsaId: prakarsaId,
        prakarsaType: _prakarsaType,
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _detailLKN = result;
        notifyListeners();

        await _prepopulateTextFields();
        await _prepopulateVisitPath();
      },
    );
  }

  Future _prepopulateTextFields() async {
    cbTerdekatController
      ..text = _detailLKN!.dataLkn!.cbName ?? '-'
      ..selection =
          TextSelection.collapsed(offset: cbTerdekatController.text.length);

    jenisProdukPinjamanController
      ..text = InitialCodeTableFormatter.getJenisKredit(codeTable)
      ..selection = TextSelection.collapsed(
        offset: jenisProdukPinjamanController.text.length,
      );

    tujuanKunjunganNasabahController
      ..text = _detailLKN!.dataLkn!.purposeVisit ?? ''
      ..selection = TextSelection.collapsed(
        offset: tujuanKunjunganNasabahController.text.length,
      );

    plafondPengajuanController
      ..text = _detailLKN!.dataLkn!.loanAmount != null
          ? formatter.format(
              double.parse(_detailLKN!.dataLkn!.loanAmount!),
            )
          : '-'
      ..selection = TextSelection.collapsed(
        offset: plafondPengajuanController.text.length,
      );

    waktuTempuhLokasiController
      ..text = _detailLKN!.dataLkn!.etaToCB ?? ''
      ..selection = TextSelection.collapsed(
        offset: waktuTempuhLokasiController.text.length,
      );

    // tanggalKunjunganNasabahController
    //   ..text = _detailLKN!.dataLkn!.dateOfVisit != null
    //       ? DateStringFormatter.forOutputRitel(
    //           _detailLKN!.dataLkn!.dateOfVisit!,
    //         )
    //       : ''
    //   ..selection = TextSelection.collapsed(
    //     offset: tanggalKunjunganNasabahController.text.length,
    //   );
    if (_detailLKN!.dataLkn!.dateOfVisit != null) {
      tanggalKunjunganNasabahController.text = DateStringFormatter.forInput(
        _detailLKN!.dataLkn!.dateOfVisit!,
      );
    }

    hasilKunjunganNasabahController
      ..text = _detailLKN!.dataLkn!.visitResult ?? ''
      ..selection = TextSelection.collapsed(
        offset: hasilKunjunganNasabahController.text.length,
      );

    rencanaTindakLanjutController
      ..text = _detailLKN!.dataLkn!.followUpPlan ?? ''
      ..selection = TextSelection.collapsed(
        offset: rencanaTindakLanjutController.text.length,
      );

    namaPejabatController
      ..text = _detailLKN!.dataLkn!.nameOfficer ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaPejabatController.text.length,
      );

    jabatanController
      ..text = _detailLKN!.dataLkn!.position ?? ''
      ..selection = TextSelection.collapsed(
        offset: jabatanController.text.length,
      );

    namaDivisiController
      ..text = _detailLKN!.dataLkn!.divisionOfficer ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaDivisiController.text.length,
      );

    namaPejabatLainController
      ..text = _detailLKN!.dataLkn!.nameOfficerOther ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaPejabatLainController.text.length,
      );

    jabatanLainController
      ..text = _detailLKN!.dataLkn!.positionOther ?? ''
      ..selection = TextSelection.collapsed(
        offset: jabatanLainController.text.length,
      );

    namaDivisiLainController
      ..text = _detailLKN!.dataLkn!.divisionOfficerOther ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaDivisiLainController.text.length,
      );
  }

  List<String> fotoKunjunganURL = [];
  List<String> fotoKunjunganPublicURL = [];
  Future _prepopulateVisitPath() async {
    if (_detailLKN!.dataLkn!.visitPath!.isNotEmpty) {
      for (var i = 0; i <= _detailLKN!.dataLkn!.visitPath!.length; i++) {
        fotoKunjunganURL.add(_detailLKN!.dataLkn!.visitPath![i].path!);
        fotoKunjunganPublicURL.add(
          await _getPublicFile(_detailLKN!.dataLkn!.visitPath![i].path!),
        );
        notifyListeners();
      }
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

  final cbTerdekatController = TextEditingController();
  final jenisProdukPinjamanController = TextEditingController();
  final tujuanKunjunganNasabahController = TextEditingController();
  final plafondPengajuanController = TextEditingController();

  final waktuTempuhLokasiController = TextEditingController();
  void updateWaktuTempuhLokasiController(String val) =>
      waktuTempuhLokasiController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final tanggalKunjunganNasabahController = TextEditingController();
  void updateTanggalKunjunganNasabah(String val) =>
      tanggalKunjunganNasabahController.text = val.trim();

  Future selecttglKunjunganDebitur(BuildContext context) async {
    DateTime? pickedDate = await _showingDatePicker(context);
    // ignore: unnecessary_null_comparison
    if (pickedDate != null) {
      updateTanggalKunjunganNasabah(
        DateFormat('dd/MM/yyyy').format(pickedDate).toString(),
      );
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<DateTime> _showingDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    return picked!;
  }

  final namaPejabatController = TextEditingController();
  void updateNamaPejabat(String val) => namaPejabatController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final jabatanController = TextEditingController();
  void updateJabatan(String val) {
    jabatanController.text = val;
    notifyListeners();
  }

  final namaDivisiController = TextEditingController();
  void updateNamaDivisi(String val) => namaDivisiController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final namaPejabatLainController = TextEditingController();
  void updateNamaPejabatLain(String val) =>
      namaPejabatLainController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final jabatanLainController = TextEditingController();
  void updateJabatanLain(String val) {
    jabatanLainController.text = val;
    notifyListeners();
  }

  final namaDivisiLainController = TextEditingController();
  void updateNamaDivisiLain(String val) =>
      namaDivisiLainController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final hasilKunjunganNasabahController = TextEditingController();
  void updateHasilKunjunganNasabah(String val) =>
      hasilKunjunganNasabahController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final rencanaTindakLanjutController = TextEditingController();
  void updateRencanaTindakLanjut(String val) =>
      rencanaTindakLanjutController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  Future<Map<String, dynamic>> _generateLaporanKunjunganNasabahMap({
    required bool isSavedDrafts,
  }) async {
    final data = {
      'pipelinesId': _detailLKN!.dataLkn!.pipelinesId!,
      'etaToCB': waktuTempuhLokasiController.text.isNotEmpty
          ? waktuTempuhLokasiController.text.trim()
          : '',
      'dateOfVisit': tanggalKunjunganNasabahController.text.isNotEmpty
          ? tanggalKunjunganNasabahController.text.trim()
          : _detailLKN != null
              ? _detailLKN!.dataLkn!.dateOfVisit != null
                  ? DateStringFormatter.forInput(
                      _detailLKN!.dataLkn!.dateOfVisit!,
                    )
                  : null
              : null,
      //  tanggalKunjunganNasabahController.text.isNotEmpty
      //     ? DateStringFormatter.forInputDate(
      //         tanggalKunjunganNasabahController.text.trim(),
      //       )
      //     : null,
      'visitResult': hasilKunjunganNasabahController.text.isNotEmpty
          ? hasilKunjunganNasabahController.text.trim()
          : '',
      'nameOfficer': namaPejabatController.text.trim(),
      'position': jabatanController.text.trim(),
      'divisionOfficer': jabatanController.text.trim() == 'Kadiv Bisnis' ||
              jabatanController.text.trim() == 'Wakadiv Bisnis' ||
              jabatanController.text.trim() == 'Kabag Bisnis' ||
              jabatanController.text.trim() == 'RM Pusat'
          ? namaDivisiController.text.trim()
          : '',
      'nameOfficerOther': namaPejabatLainController.text.trim(),
      'positionOther': jabatanLainController.text.trim(),
      'divisionOfficerOther':
          jabatanLainController.text.trim() == 'Kadiv Bisnis' ||
                  jabatanLainController.text.trim() == 'Wakadiv Bisnis' ||
                  jabatanLainController.text.trim() == 'Kabag Bisnis' ||
                  jabatanLainController.text.trim() == 'RM Pusat'
              ? namaDivisiLainController.text.trim()
              : '',
      'followUpPlan': rencanaTindakLanjutController.text.trim(),
      'visitPath': _detailLKN!.dataLkn!.visitPath!,
      'isSavedrafts': isSavedDrafts,
    };

    return data;
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final laporanKunjunganNasabahMap =
        await _generateLaporanKunjunganNasabahMap(
      isSavedDrafts: isSavedDrafts,
    );

    final res = await runBusyFuture(
      _lknAPI.update(
        prakarsaType: _prakarsaType,
        payload: laporanKunjunganNasabahMap,
      ),
    );

    res.fold(
      (errorMessage) {
        if (errorMessage.contains('not allowed') ||
            errorMessage.contains('must')) {
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
