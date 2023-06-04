import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../application/helpers/thousands_separator.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/detail_identitas_perusahaan.dart';
import '../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../../application/models/postal_code_model.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../infrastructure/apis/perusahaan_api.dart';

class FormPengurusViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _dialogService = locator<DialogService>();
  final _masterAPI = locator<MasterAPI>();
  final _perusahaanAPI = locator<PerusahaanAPI>();

  String prakarsaId;
  int codeTable;
  String pipelineId;

  final InformasiPengurusModel dataPengurus;
  FormPengurusViewModel({
    required this.dataPengurus,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  final decimalFormatter = NumberFormat.decimalPattern();

  final namaPengurusController = TextEditingController();
  final posisiPengurusController = TextEditingController();
  final noKtpPengurusController = TextEditingController();
  final nomorNPWPController = TextEditingController();
  final jenisKelaminController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final statusPerkawinanController = TextEditingController();
  final nomorKKController = TextEditingController();
  final tanggalKKController = TextEditingController();
  final noAktaNikahController = TextEditingController();
  final tglAktaNikahController = TextEditingController();
  final phoneNumController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final districController = TextEditingController();
  final villageController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();
  final nominalSahamController = TextEditingController();
  final lembarSahamController = TextEditingController();
  final presentaseSahamController = TextEditingController();
  final namaPasanganController = TextEditingController();
  final noKtpPasanganController = TextEditingController();
  final tempatLahirPasanganController = TextEditingController();
  final tanggalLahirPasanganController = TextEditingController();
  final noSuratBelumNikahController = TextEditingController();
  final tanggalSuratBelumNikahController = TextEditingController();
  final noAktaCeraiController = TextEditingController();
  final tglAktaCeraiController = TextEditingController();
  final noSuratKematianController = TextEditingController();
  final tglSuratKematianController = TextEditingController();

  DetailIdentitasPerusahaan? _identitasPerusahaan;
  DetailIdentitasPerusahaan? get identitasPerusahaan => _identitasPerusahaan;
  List<InformasiPengurusModel>? _ritelInformasiPengurus;
  List<InformasiPengurusModel>? get ritelInformasiPengurus =>
      _ritelInformasiPengurus;
  InformasiPengurusModel? infoPengurus;

  String urlKtpPengurus = '';
  String urlNpwpPengurus = '';
  String urlKtpPasangan = '';
  String urlKkPengurus = '';
  String urlAktaNikah = '';
  String urlSuratCerai = '';
  String urlSuratKematian = '';
  String urlKtpPengurusPublic = '';
  String urlNpwpPengurusPublic = '';
  String urlKtpPasanganPublic = '';
  String urlKkPengurusPublic = '';
  String urlAktaNikahPublic = '';
  String urlSuratCeraiPublic = '';
  String urlSuratKematianPublic = '';
  String urlBelumNikah = '';
  String urlBelumNikahPublic = '';

  final Map<String, dynamic> tagAlamatLatLng = {};

  bool isLoadingData = true;
  List<bool> isLoadingFile = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  double? totalSharePercentage;

  Future initialize() async {
    isLoadingData = true;
    await fetchInformasiPengurus();
    await _prePopulateDocument();
    _fetchIdentitasPerusahaan();
    _prePopulatePengurus();
    if (infoPengurus?.maritalStatus == Common.kawin) {
      _prePopulatePasangan();
    } else if (infoPengurus?.maritalStatus == Common.belumKawin) {
      _prepopulateStatusBelumNikah();
    } else if (infoPengurus?.maritalStatus == Common.ceraiHidup) {
      _prepopulateStatusCeraiHidup();
    } else if (infoPengurus?.maritalStatus == Common.ceraiMati) {
      _prepopulateStatusCeraiMati();
    }
    isLoadingData = false;
    notifyListeners();
  }

  Future fetchInformasiPengurus() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchByIdInformasiPengurus(
        codeTable: codeTable,
        prakarsaId: prakarsaId,
        pipelineId: pipelineId,
      ),
    );
    res.fold(
      (l) => null,
      (ritelPrakarsa) async {
        _ritelInformasiPengurus = ritelPrakarsa;
        ritelPrakarsa.forEach((element) {
          if (element.id == dataPengurus.id) {
            infoPengurus = element;
          }
        });
        notifyListeners();
      },
    );
  }

  Future _fetchIdentitasPerusahaan() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchIdentitasPerusahaan(
        prakarsaId: prakarsaId,
        prakarsaType: InitialCodeTableFormatter.getPrakarsaType(codeTable),
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _identitasPerusahaan = result;
        totalSharePercentage = result.totalCompanyShares != null
            ? double.parse(result.totalCompanyShares ?? '0')
            : null;
        notifyListeners();
      },
    );
  }

  void getTotalLembarSaham(String val) {
    if (totalSharePercentage != null && val.isNotEmpty) {
      presentaseSahamController.text =
          (double.parse(val) / totalSharePercentage! * 100).toStringAsFixed(2);
    } else {
      presentaseSahamController.clear();
    }
    notifyListeners();
  }

  // ignore: long-method
  void _prePopulatePengurus() {
    namaPengurusController
      ..text = infoPengurus?.fullName ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaPengurusController.text.length,
      );

    posisiPengurusController
      ..text = infoPengurus?.jobDescription ?? ''
      ..selection = TextSelection.collapsed(
        offset: posisiPengurusController.text.length,
      );

    noKtpPengurusController
      ..text = infoPengurus?.ktpNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: noKtpPengurusController.text.length,
      );

    nomorNPWPController
      ..text = infoPengurus?.npwpNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: nomorNPWPController.text.length,
      );

    jenisKelaminController
      ..text = infoPengurus?.gender ?? ''
      ..selection = TextSelection.collapsed(
        offset: jenisKelaminController.text.length,
      );

    tempatLahirController
      ..text = infoPengurus?.placeOfBirth ?? ''
      ..selection = TextSelection.collapsed(
        offset: tempatLahirController.text.length,
      );

    tanggalLahirController
      ..text = (infoPengurus?.dateOfBirth?.isNotEmpty ?? false)
          ? DateStringFormatter.forDetailPrakarsaDate(
              infoPengurus?.dateOfBirth ?? '',
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalLahirController.text.length,
      );

    statusPerkawinanController
      ..text = infoPengurus?.maritalStatus ?? ''
      ..selection = TextSelection.collapsed(
        offset: statusPerkawinanController.text.length,
      );

    nomorKKController
      ..text = infoPengurus?.kkNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: nomorKKController.text.length,
      );

    tanggalKKController
      ..text = (infoPengurus?.kkDate ?? '').toString().isNotEmpty
          ? DateStringFormatter.forDetailPrakarsaDate(infoPengurus?.kkDate)
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalKKController.text.length,
      );

    noAktaNikahController
      ..text = infoPengurus?.marriageNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: noAktaNikahController.text.length,
      );

    tglAktaNikahController
      ..text = (infoPengurus?.marriageDate ?? '').toString().isNotEmpty
          ? DateStringFormatter.forDetailPrakarsaDate(
              infoPengurus?.marriageDate,
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tglAktaNikahController.text.length,
      );

    phoneNumController
      ..text = (infoPengurus?.phoneNum ?? '').replaceAll('+62', '')
      ..selection = TextSelection.collapsed(
        offset: phoneNumController.text.length,
      );

    emailController
      ..text = infoPengurus?.email ?? ''
      ..selection = TextSelection.collapsed(
        offset: emailController.text.length,
      );

    addressController
      ..text = infoPengurus?.detail ?? ''
      ..selection = TextSelection.collapsed(
        offset: addressController.text.length,
      );

    postalCodeController
      ..text = infoPengurus?.postalCode ?? ''
      ..selection = TextSelection.collapsed(
        offset: postalCodeController.text.length,
      );

    provinceController
      ..text = infoPengurus?.province ?? ''
      ..selection = TextSelection.collapsed(
        offset: provinceController.text.length,
      );

    cityController
      ..text = infoPengurus?.city ?? ''
      ..selection = TextSelection.collapsed(
        offset: cityController.text.length,
      );

    districController
      ..text = infoPengurus?.district ?? ''
      ..selection = TextSelection.collapsed(
        offset: districController.text.length,
      );

    villageController
      ..text = infoPengurus?.village ?? ''
      ..selection = TextSelection.collapsed(
        offset: villageController.text.length,
      );

    rtController
      ..text = infoPengurus?.rt ?? ''
      ..selection = TextSelection.collapsed(
        offset: rtController.text.length,
      );

    rwController
      ..text = infoPengurus?.rw ?? ''
      ..selection = TextSelection.collapsed(
        offset: rwController.text.length,
      );

    nominalSahamController
      ..text = ((infoPengurus?.shareNominal ?? '').toString().isNotEmpty)
          ? RupiahFormatter.formatWithOutRp(
              double.parse(infoPengurus?.shareNominal ?? '').toString(),
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: nominalSahamController.text.length,
      );

    lembarSahamController
      ..text = (infoPengurus?.shares ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: lembarSahamController.text.length,
      );

    presentaseSahamController
      ..text = (infoPengurus?.sharePercentage ?? '').toString().isNotEmpty
          ? double.parse(infoPengurus?.sharePercentage ?? '').toString()
          : ''
      ..selection = TextSelection.collapsed(
        offset: presentaseSahamController.text.length,
      );
  }

  void _prePopulatePasangan() {
    namaPasanganController
      ..text = infoPengurus?.spouseFullname ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaPasanganController.text.length,
      );

    noKtpPasanganController
      ..text = infoPengurus?.spouseKtpNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: noKtpPasanganController.text.length,
      );

    tempatLahirPasanganController
      ..text = infoPengurus?.spousePlaceOfBirth ?? ''
      ..selection = TextSelection.collapsed(
        offset: tempatLahirPasanganController.text.length,
      );

    tanggalLahirPasanganController
      ..text = (infoPengurus?.dateOfBirth?.isNotEmpty ?? false)
          ? DateStringFormatter.forDetailPrakarsaDate(
              infoPengurus?.spouseDateOfBirth ?? '',
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalLahirPasanganController.text.length,
      );

    tagAlamatLatLng['lat'] = infoPengurus?.tagLocation!.latLng!.split(', ')[0];

    tagAlamatLatLng['lng'] = infoPengurus?.tagLocation!.latLng!.split(', ')[1];
  }

  void _prepopulateStatusBelumNikah() {
    noSuratBelumNikahController
      ..text = (infoPengurus?.notMarriageNum ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: noSuratBelumNikahController.text.length,
      );
    tanggalSuratBelumNikahController
      ..text = (infoPengurus?.notMarriageDate ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: tanggalSuratBelumNikahController.text.length,
      );
  }

  void _prepopulateStatusCeraiHidup() {
    noAktaCeraiController
      ..text = (infoPengurus?.divorceNum ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: noAktaCeraiController.text.length,
      );
    tglAktaCeraiController
      ..text = (infoPengurus?.divorceDate ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: tglAktaCeraiController.text.length,
      );
  }

  void _prepopulateStatusCeraiMati() {
    noSuratKematianController
      ..text = (infoPengurus?.deathCertificateNum ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: noSuratKematianController.text.length,
      );
    tglSuratKematianController
      ..text = (infoPengurus?.deathCertificateDate ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: tglSuratKematianController.text.length,
      );
  }

  Future _prePopulateDocument() async {
    urlKtpPengurusPublic = await _getPublicFile(infoPengurus?.ktpPath ?? '');
    urlKtpPengurus = infoPengurus?.ktpPath ?? '';
    urlNpwpPengurusPublic = await _getPublicFile(infoPengurus?.npwpPath ?? '');
    urlNpwpPengurus = infoPengurus?.npwpPath ?? '';
    urlKkPengurusPublic = await _getPublicFile(infoPengurus?.kkPath ?? '');
    urlKkPengurus = infoPengurus?.kkPath ?? '';
    if (infoPengurus?.maritalStatus == Common.kawin) {
      urlKtpPasanganPublic =
          await _getPublicFile(infoPengurus?.spouseKtpPath ?? '');
      urlKtpPasangan = infoPengurus?.spouseKtpPath ?? '';
      urlAktaNikahPublic =
          await _getPublicFile(infoPengurus?.marriagePath ?? '');
      urlAktaNikah = infoPengurus?.marriagePath ?? '';
    } else if (infoPengurus?.maritalStatus == Common.ceraiHidup) {
      urlSuratCeraiPublic =
          await _getPublicFile(infoPengurus?.divorcePath ?? '');
      urlSuratCerai = infoPengurus?.divorcePath ?? '';
    } else if (infoPengurus?.maritalStatus == Common.ceraiMati) {
      urlSuratKematianPublic =
          await _getPublicFile(infoPengurus?.deathCertificatePath ?? '');
      urlSuratKematian = infoPengurus?.deathCertificatePath ?? '';
    } else if (infoPengurus?.maritalStatus == Common.belumKawin) {
      urlBelumNikahPublic =
          await _getPublicFile(infoPengurus?.notMarriagePath ?? '');
      urlBelumNikah = infoPengurus?.notMarriagePath ?? '';
    }
  }

  void clearFile(int index) {
    switch (index) {
      case 0:
        urlKtpPengurusPublic = '';
        urlKtpPengurus = '';
        break;
      case 1:
        urlNpwpPengurusPublic = '';
        urlNpwpPengurus = '';
        break;
      case 2:
        urlKtpPasanganPublic = '';
        urlKtpPasangan = '';
        break;
      case 3:
        urlKkPengurusPublic = '';
        urlKkPengurus = '';
        break;
      case 4:
        urlAktaNikahPublic = '';
        urlAktaNikah = '';
        break;
      case 5:
        urlSuratCeraiPublic = '';
        urlSuratCerai = '';
        break;
      case 6:
        urlSuratKematianPublic = '';
        urlSuratKematian = '';
        break;
      case 7:
        urlBelumNikahPublic = '';
        urlBelumNikah = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFile(int index, String url) async {
    switch (index) {
      case 0:
        urlKtpPengurusPublic = await _getPublicFile(url);
        urlKtpPengurus = url;
        break;
      case 1:
        urlNpwpPengurusPublic = await _getPublicFile(url);
        urlNpwpPengurus = url;
        break;
      case 2:
        urlKtpPasanganPublic = await _getPublicFile(url);
        urlKtpPasangan = url;
        break;
      case 3:
        urlKkPengurusPublic = await _getPublicFile(url);
        urlKkPengurus = url;
        break;
      case 4:
        urlAktaNikahPublic = await _getPublicFile(url);
        urlAktaNikah = url;
        break;
      case 5:
        urlSuratCeraiPublic = await _getPublicFile(url);
        urlSuratCerai = url;
        break;
      case 6:
        urlSuratKematianPublic = await _getPublicFile(url);
        urlSuratKematian = url;
        break;
      case 7:
        urlBelumNikahPublic = await _getPublicFile(url);
        urlBelumNikah = url;
        break;
      default:
    }
    notifyListeners();
  }

  void setLoadingFile(int index, bool val) {
    isLoadingFile[index] = val;
    notifyListeners();
  }

  Future uploadFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
    );

    if (result != null) {
      setLoadingFile(index, true);
      _uploadDocument(result.files[0], index);
    }
    notifyListeners();
  }

  Future _uploadDocument(
    PlatformFile file,
    int index,
  ) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );

    res.fold(
      (errorMessage) {
        setLoadingFile(index, false);
        _showErrorDialog(errorMessage);
      },
      (url) {
        _setUrlFile(index, url);
        setLoadingFile(index, false);
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
      _postData(isSavedDrafts: isSavedDrafts);
    }
  }

  Map<String, dynamic> _generateInformasiPengurusPtMap(bool isSavedDrafts) {
    phoneNumController.text.replaceAll('+62', '');

    return {
      'prakarsaId': prakarsaId,
      'pt_mgmtId': infoPengurus?.id,
      'npwpNum': nomorNPWPController.text.trim(),
      'phoneNum': phoneNumController.text.trim().isNotEmpty
          ? '+62${phoneNumController.text.trim()}'
          : '',
      'email': emailController.text.trim(),
      'sharePercentage': presentaseSahamController.text.trim().isEmpty
          ? null
          : presentaseSahamController.text.trim(),
      'shares': lembarSahamController.text.trim().isEmpty
          ? null
          : lembarSahamController.text.trim(),
      'shareNominal': nominalSahamController.text.trim().isEmpty
          ? null
          : double.parse(
              ThousandsSeparator.remove(nominalSahamController.text.trim())
                  .toString(),
            ),
      'npwpPath': urlNpwpPengurus,
      'isDraft': isSavedDrafts,
      'rt': rtController.text.trim(),
      'rw': rwController.text.trim(),
      'tagLocation': infoPengurus?.tagLocation != null
          ? addressController.text.trim() == infoPengurus?.tagLocation?.name
              ? infoPengurus?.tagLocation
              : {
                  'latLng':
                      "${tagAlamatLatLng['lat']}, ${tagAlamatLatLng['lng']}",
                  'name': addressController.text.trim(),
                }
          : {
              'latLng': "${tagAlamatLatLng['lat']}, ${tagAlamatLatLng['lng']}",
              'name': addressController.text.trim(),
            },
    };
  }

  Map<String, dynamic> _generateInformasiPengurusCvMap(bool isSavedDrafts) {
    phoneNumController.text.replaceAll('+62', '');

    final map = {
      'prakarsaId': prakarsaId,
      'cv_mgmtId': infoPengurus?.id,
      'maritalStatus': infoPengurus?.maritalStatus,
      'phoneNum': phoneNumController.text.trim().isNotEmpty
          ? '+62${phoneNumController.text.trim()}'
          : '',
      'email': emailController.text.trim(),
      'npwpPath': urlNpwpPengurus,
      'kkPath': urlKkPengurus,
      'npwpNum': nomorNPWPController.text.trim(),
      'sharePercentage': presentaseSahamController.text.trim().isEmpty
          ? null
          : presentaseSahamController.text.trim(),
      'shares': lembarSahamController.text.trim().isEmpty
          ? null
          : lembarSahamController.text.trim(),
      'shareNominal': nominalSahamController.text.trim().isEmpty
          ? null
          : double.parse(
              ThousandsSeparator.remove(nominalSahamController.text.trim())
                  .toString(),
            ),
      'isDraft': isSavedDrafts,
      'rt': rtController.text.trim(),
      'rw': rwController.text.trim(),
      'kkNum': nomorKKController.text.trim(),
      'kkDate': tanggalKKController.text.trim().isNotEmpty
          ? DateStringFormatter.forInputDate(tanggalKKController.text.trim())
          : '',
    };

    if (infoPengurus?.maritalStatus == Common.kawin) {
      map['marriagePath'] = urlAktaNikah;
      map['marriageNum'] = noAktaNikahController.text.trim().isEmpty
          ? ''
          : noAktaNikahController.text.trim();
      map['marriageDate'] = tglAktaNikahController.text.trim().isEmpty
          ? ''
          : DateStringFormatter.forInputDate(
              tglAktaNikahController.text.trim(),
            );
    }

    if (infoPengurus?.maritalStatus == Common.ceraiMati) {
      map['deathCertificatePath'] = urlSuratKematian;
      map['deathCertificateDate'] =
          tglSuratKematianController.text.trim().isEmpty
              ? ''
              : DateStringFormatter.forInputDate(
                  tglSuratKematianController.text.trim(),
                );
    }

    if (infoPengurus?.maritalStatus == Common.ceraiHidup) {
      map['divorcePath'] = urlSuratCerai;
      map['divorceNum'] = noAktaCeraiController.text.trim();
      map['divorceDate'] = tglAktaCeraiController.text.trim().isEmpty
          ? ''
          : DateStringFormatter.forInputDate(
              tglAktaCeraiController.text.trim(),
            );
    }

    if (infoPengurus?.maritalStatus == Common.belumKawin) {
      map['notMarriageNum'] = noSuratBelumNikahController.text.trim();
      map['notMarriageDate'] =
          tanggalSuratBelumNikahController.text.trim().isEmpty
              ? ''
              : DateStringFormatter.forInputDate(
                  tanggalSuratBelumNikahController.text.trim(),
                );
      map['notMarriagePath'] = urlBelumNikah;
    }

    return map;
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final payload = codeTable == Common.CodeTable.PT
        ? _generateInformasiPengurusPtMap(isSavedDrafts)
        : _generateInformasiPengurusCvMap(isSavedDrafts);

    final res = await runBusyFuture(
      _perusahaanAPI.updateInformasiPengurus(
        payload: payload,
        codeTable: codeTable,
      ),
    );

    res.fold(
      (errorMessage) {
        _showErrorDialogForm();
        notifyListeners();
      },
      (successMap) {
        _showSuccessDialog(
          isSavedDrafts,
        ).then((value) => navigateBack(isPassed: true));
        notifyListeners();
      },
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

  void updatePostalCode(PostalCodeModel data) {
    postalCodeController
      ..text = data.postalCode ?? ''
      ..selection = TextSelection.collapsed(
        offset: postalCodeController.text.length,
      );

    provinceController
      ..text = data.province ?? ''
      ..selection = TextSelection.collapsed(
        offset: provinceController.text.length,
      );

    cityController
      ..text = data.city ?? ''
      ..selection = TextSelection.collapsed(
        offset: cityController.text.length,
      );

    districController
      ..text = data.district ?? ''
      ..selection = TextSelection.collapsed(
        offset: districController.text.length,
      );

    villageController
      ..text = data.village ?? ''
      ..selection = TextSelection.collapsed(
        offset: villageController.text.length,
      );
    notifyListeners();
  }
}
