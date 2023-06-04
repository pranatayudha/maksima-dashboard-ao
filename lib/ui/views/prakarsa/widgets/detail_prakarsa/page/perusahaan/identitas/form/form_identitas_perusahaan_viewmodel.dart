import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';

import '../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../application/helpers/thousands_separator.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/detail_identitas_perusahaan.dart';
import '../../../../../../../../../application/models/postal_code_model.dart';
import '../../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../infrastructure/apis/perusahaan_api.dart';
import '../../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormIdentitasPerusahaanViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _dialogService = locator<DialogService>();
  final _mediaService = locator<MaksimaMediaService>();
  final _navigationService = locator<NavigationService>();

  final _masterAPI = locator<MasterAPI>();
  final _perusahaanAPI = locator<PerusahaanAPI>();

  final String prakarsaId;
  final int codeTable;

  FormIdentitasPerusahaanViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  String _prakarsaType = '';
  Future initialize() async {
    _prakarsaType = InitialCodeTableFormatter.getPrakarsaType(codeTable);

    await _fetchIdentitasPerusahaan();
  }

  DetailIdentitasPerusahaan? _identitasPerusahaan;
  DetailIdentitasPerusahaan? get identitasPerusahaan => _identitasPerusahaan;
  Future _fetchIdentitasPerusahaan() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchIdentitasPerusahaan(
        prakarsaId: prakarsaId,
        prakarsaType: _prakarsaType,
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _identitasPerusahaan = result;
        notifyListeners();

        await _prepopulateTextFields();
        await _prepopulateNpwpPath();
      },
    );
  }

  // ignore: long-method
  Future _prepopulateTextFields() async {
    jenisKreditController
      ..text = 'Pinang Maksima - PTR'
      ..selection =
          TextSelection.collapsed(offset: jenisKreditController.text.length);

    bentukUsahaController
      ..text = codeTable == 3
          ? 'Badan Usaha Berbadan Hukum'
          : codeTable == 2
              ? 'Badan Usaha Tidak Berbadan Hukum'
              : '-'
      ..selection =
          TextSelection.collapsed(offset: bentukUsahaController.text.length);

    badanUsahaController
      ..text = codeTable == 3
          ? 'PT'
          : codeTable == 2
              ? 'CV'
              : '-'
      ..selection =
          TextSelection.collapsed(offset: badanUsahaController.text.length);

    namaPerusahaanController
      ..text = (_identitasPerusahaan!.companyName?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.companyName!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: namaPerusahaanController.text.length);

    npwpPerusahaanController
      ..text = (_identitasPerusahaan!.companyNpwpNum?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.companyNpwpNum!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: npwpPerusahaanController.text.length);

    sektorEkonomiController
      ..text = (_identitasPerusahaan!.economySectorName?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.economySectorName!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: sektorEkonomiController.text.length);

    subSektorEkonomiController
      ..text = (_identitasPerusahaan!.economySubSectorName?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.economySubSectorName!
          : '-'
      ..selection = TextSelection.collapsed(
        offset: subSektorEkonomiController.text.length,
      );

    if (_identitasPerusahaan!.tagLocation!.latLng != null) {
      if (_identitasPerusahaan!.tagLocation!.latLng! != '') {
        tagAlamatLatLng['lat'] = double.parse(
          _identitasPerusahaan!.tagLocation!.latLng!.split(', ')[0],
        );

        tagAlamatLatLng['lng'] = double.parse(
          _identitasPerusahaan!.tagLocation!.latLng!.split(', ')[1],
        );

        tagLocationController
          ..text = '${tagAlamatLatLng['lat']}, ${tagAlamatLatLng['lng']}'
          ..selection = TextSelection.collapsed(
            offset: tagLocationController.text.length,
          );

        tagLocationNameController
          ..text = _identitasPerusahaan!.tagLocation!.name!
          ..selection = TextSelection.collapsed(
            offset: tagLocationNameController.text.length,
          );
      }
    }

    alamatUsahaController
      ..text = (_identitasPerusahaan!.detail?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.detail!
          : ''
      ..selection =
          TextSelection.collapsed(offset: alamatUsahaController.text.length);

    kodePosController
      ..text = (_identitasPerusahaan!.postalCode?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.postalCode!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: kodePosController.text.length);

    provinsiController
      ..text = (_identitasPerusahaan!.province?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.province!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: provinsiController.text.length);

    kotaController
      ..text = (_identitasPerusahaan!.city?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.city!
          : '-'
      ..selection = TextSelection.collapsed(
        offset: kotaController.text.length,
      );

    kecamatanController
      ..text = (_identitasPerusahaan!.district?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.district!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: kecamatanController.text.length);

    kelurahanController
      ..text = (_identitasPerusahaan!.village?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.village!
          : '-'
      ..selection =
          TextSelection.collapsed(offset: kelurahanController.text.length);

    rtController
      ..text = (_identitasPerusahaan!.rw?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.rw!
          : ''
      ..selection = TextSelection.collapsed(offset: rtController.text.length);

    rwController
      ..text = (_identitasPerusahaan!.rw?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.rw!
          : ''
      ..selection = TextSelection.collapsed(offset: rwController.text.length);

    totalNominalSahamController
      ..text =
          (_identitasPerusahaan!.totalnominalValueShares?.isNotEmpty ?? false)
              ? formatter.format(
                  double.parse(_identitasPerusahaan!.totalnominalValueShares!),
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: totalNominalSahamController.text.length,
      );

    totalLembarSahamController
      ..text = (_identitasPerusahaan!.totalCompanyShares?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.totalCompanyShares!
          : ''
      ..selection = TextSelection.collapsed(
        offset: totalLembarSahamController.text.length,
      );

    namaPICController
      ..text = (_identitasPerusahaan!.fullnamePIC?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.fullnamePIC!
          : ''
      ..selection =
          TextSelection.collapsed(offset: namaPICController.text.length);

    noHandphoneController
      ..text = (_identitasPerusahaan!.phoneNumPIC?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.phoneNumPIC!.split('+62').last
          : ''
      ..selection =
          TextSelection.collapsed(offset: noHandphoneController.text.length);

    posisiPICController
      ..text = (_identitasPerusahaan!.positionPIC?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.positionPIC!
          : ''
      ..selection =
          TextSelection.collapsed(offset: posisiPICController.text.length);

    emailController
      ..text = (_identitasPerusahaan!.emailPIC?.isNotEmpty ?? false)
          ? _identitasPerusahaan!.emailPIC!
          : ''
      ..selection =
          TextSelection.collapsed(offset: emailController.text.length);
  }

  String? npwpPerusahaanUrl;
  String? npwpPerusahaanUrlPublic;
  String? npwpPerusahaanErrorText;
  Future _prepopulateNpwpPath() async {
    if (_identitasPerusahaan!.companyNpwpPath!.isNotEmpty) {
      npwpPerusahaanUrl = _identitasPerusahaan!.companyNpwpPath!;
      npwpPerusahaanUrlPublic = await _getPublicFile(npwpPerusahaanUrl!);
      notifyListeners();
    }
  }

  final jenisKreditController = TextEditingController();
  final bentukUsahaController = TextEditingController();
  final badanUsahaController = TextEditingController();
  final namaPerusahaanController = TextEditingController();
  final npwpPerusahaanController = TextEditingController();
  final sektorEkonomiController = TextEditingController();
  final subSektorEkonomiController = TextEditingController();

  final Map<String, dynamic> tagAlamatLatLng = {};
  final tagLocationController = TextEditingController();
  final tagLocationNameController = TextEditingController();
  void updateTagloc(Map<String, dynamic> data) {
    LatLng selectedLatlng = data['latLng'];
    tagLocationController
      ..text = '${selectedLatlng.latitude}, ${selectedLatlng.longitude}'
      ..selection = TextSelection.collapsed(
        offset: tagLocationController.text.length,
      );

    tagLocationNameController
      ..text = data['address']
      ..selection = TextSelection.collapsed(
        offset: tagLocationNameController.text.length,
      );

    notifyListeners();
  }

  final alamatUsahaController = TextEditingController();
  void updateAlamatUsahaController(String val) =>
      alamatUsahaController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final kodePosController = TextEditingController();
  void updatePostalCode(PostalCodeModel data) {
    kodePosController
      ..text = data.postalCode ?? ''
      ..selection = TextSelection.collapsed(
        offset: kodePosController.text.length,
      );

    provinsiController
      ..text = data.province ?? ''
      ..selection = TextSelection.collapsed(
        offset: provinsiController.text.length,
      );

    kotaController
      ..text = data.city ?? ''
      ..selection = TextSelection.collapsed(
        offset: kotaController.text.length,
      );

    kecamatanController
      ..text = data.district ?? ''
      ..selection = TextSelection.collapsed(
        offset: kecamatanController.text.length,
      );

    kelurahanController
      ..text = data.village ?? ''
      ..selection = TextSelection.collapsed(
        offset: kelurahanController.text.length,
      );
    notifyListeners();
  }

  final provinsiController = TextEditingController();
  final kotaController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kelurahanController = TextEditingController();

  final rtController = TextEditingController();
  void updateRTController(String val) => rtController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final rwController = TextEditingController();
  void updateRWController(String val) => rwController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final totalNominalSahamController = TextEditingController();
  void updateTotalNominalSahamController(String val) =>
      totalNominalSahamController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final totalLembarSahamController = TextEditingController();
  void updateTotalLembarSahamController(String val) =>
      totalLembarSahamController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final namaPICController = TextEditingController();
  void updateNamaPICController(String val) => namaPICController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final noHandphoneController = TextEditingController();
  void updateNoHandphonePICController(String val) =>
      noHandphoneController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  final posisiPICController = TextEditingController();
  void updatePosisiPIC(String val) {
    posisiPICController.text = val;
    notifyListeners();
  }

  final emailController = TextEditingController();
  void updateEmailController(String val) => emailController.value.copyWith(
        text: val,
        selection: TextSelection(
          baseOffset: val.length,
          extentOffset: val.length,
        ),
      );

  Future captureNpwpPerusahaan(BuildContext ctx) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        npwpPerusahaanErrorText = null;
        loadingCustomDialog(ctx);
        uploadNpwpPerusahaan(res);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
  }

  Future uploadNpwpPerusahaan(PlatformFile file) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (url) async {
        _navigationService.back();
        npwpPerusahaanUrl = url;
        npwpPerusahaanUrlPublic = await _getPublicFile(url);
        notifyListeners();
      },
    );
  }

  Future clearNpwpPerusahaan() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Hapus File',
      description: 'Anda yakin akan menghapus file NPWP Perusahaan ini?',
      data: {'color': CustomColor.primaryRed80},
      mainButtonTitle: 'HAPUS',
    );

    if (response!.confirmed) {
      npwpPerusahaanUrl = null;
      npwpPerusahaanUrlPublic = null;
      notifyListeners();
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

  Future<Map<String, dynamic>> _generateIdentitasPerusahaanMap({
    required bool isSavedDrafts,
  }) async {
    return {
      'isDraft': isSavedDrafts,
      'prakarsaId': prakarsaId,
      'fullnamePIC': namaPICController.text.trim(),
      'positionPIC': posisiPICController.text.trim(),
      'detail': alamatUsahaController.text.trim(),
      'phoneNumPIC': noHandphoneController.text.isNotEmpty
          ? '+62${noHandphoneController.text.trim()}'
          : '',
      'emailPIC': emailController.text.trim(),
      'totalnominalValueShares': totalNominalSahamController.text.isNotEmpty
          ? ThousandsSeparator.remove(totalNominalSahamController.text)
          : 0,
      'totalCompanyShares': totalLembarSahamController.text.isNotEmpty
          ? ThousandsSeparator.remove(totalLembarSahamController.text)
          : 0,
      'tagLocation': {
        'latLng': tagLocationController.text,
        'name': tagLocationNameController.text,
      },
      'rt': rtController.text.trim(),
      'rw': rwController.text.trim(),
      'companyNpwpPath': npwpPerusahaanUrl ?? '',
      'postalCode': kodePosController.text.trim(),
      'province': provinsiController.text.trim(),
      'city': kotaController.text.trim(),
      'district': kecamatanController.text.trim(),
      'village': kelurahanController.text.trim(),
    };
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final identitasPerusahaanMap = await _generateIdentitasPerusahaanMap(
      isSavedDrafts: isSavedDrafts,
    );

    final res = await runBusyFuture(
      _perusahaanAPI.saveIdentitasPerusahaan(
        prakarsaType: _prakarsaType,
        payload: identitasPerusahaanMap,
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
