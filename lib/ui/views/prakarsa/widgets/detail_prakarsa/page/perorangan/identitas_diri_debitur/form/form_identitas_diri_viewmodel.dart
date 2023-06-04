import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../application/helpers/religion_string_formatter.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_identitas_perorangan.dart';
import '../../../../../../../../../../application/models/postal_code_model.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../../infrastructure/apis/perorangan_api.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';

class FormIdentitasDiriViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _masterAPI = locator<MasterAPI>();
  final _peroranganAPI = locator<PeroranganAPI>();
  final _dialogService = locator<DialogService>();
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;

  FormIdentitasDiriViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  DetailIdentitasPerorangan? _detailIdentitasPerorangan;
  DetailIdentitasPerorangan? get detailIdentitasPerorangan =>
      _detailIdentitasPerorangan;

  final decimalFormatter = NumberFormat.decimalPattern();

  final jenisKreditController = TextEditingController();
  final bentukUsahaController = TextEditingController();
  final namaDebiturController = TextEditingController();
  final posisiDebiturController = TextEditingController();
  final noKtpDebiturController = TextEditingController();
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
  final tglTerbitKtpController = TextEditingController();
  final religionController = TextEditingController();
  final lasatEducationController = TextEditingController();
  final motherMaidController = TextEditingController();
  final numberOfDependentsController = TextEditingController();
  final tagLocationController = TextEditingController();
  final tagLocationNameController = TextEditingController();

  String urlKtpDebitur = '';
  String urlNpwpDebitur = '';
  String urlKtpPasangan = '';
  String urlKkDebitur = '';
  String urlAktaNikah = '';
  String urlSuratCerai = '';
  String urlSuratKematian = '';
  String urlKtpDebiturPublic = '';
  String urlNpwpDebiturPublic = '';
  String urlKtpPasanganPublic = '';
  String urlKkDebiturPublic = '';
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

  Future initialize() async {
    isLoadingData = true;
    await _fetchIdentitasDiriDebitur();
    await _prePopulateDocument();
    _prePopulateDebitur();
    if (detailIdentitasPerorangan?.maritalStatus == Common.kawin) {
      _prePopulatePasangan();
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.belumKawin) {
      _prepopulateStatusBelumNikah();
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiHidup) {
      _prepopulateStatusCeraiHidup();
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiMati) {
      _prepopulateStatusCeraiMati();
    }
    isLoadingData = false;
    notifyListeners();
  }

  Future _prePopulateDocument() async {
    urlKtpDebiturPublic =
        await _getPublicFile(detailIdentitasPerorangan?.ktpPath ?? '');
    urlKtpDebitur = detailIdentitasPerorangan?.ktpPath ?? '';
    urlNpwpDebiturPublic =
        await _getPublicFile(detailIdentitasPerorangan?.npwpPath ?? '');
    urlNpwpDebitur = detailIdentitasPerorangan?.npwpPath ?? '';
    urlKkDebiturPublic =
        await _getPublicFile(detailIdentitasPerorangan?.kkPath ?? '');
    urlKkDebitur = detailIdentitasPerorangan?.kkPath ?? '';
    if (detailIdentitasPerorangan?.maritalStatus == Common.kawin) {
      urlKtpPasanganPublic =
          await _getPublicFile(detailIdentitasPerorangan?.spouseKtpPath ?? '');
      urlKtpPasangan = detailIdentitasPerorangan?.spouseKtpPath ?? '';
      urlAktaNikahPublic =
          await _getPublicFile(detailIdentitasPerorangan?.marriagePath ?? '');
      urlAktaNikah = detailIdentitasPerorangan?.marriagePath ?? '';
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiHidup) {
      urlSuratCeraiPublic =
          await _getPublicFile(detailIdentitasPerorangan?.divorcePath ?? '');
      urlSuratCerai = detailIdentitasPerorangan?.divorcePath ?? '';
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiMati) {
      urlSuratKematianPublic = await _getPublicFile(
        detailIdentitasPerorangan?.deathCertificatePath ?? '',
      );
      urlSuratKematian = detailIdentitasPerorangan?.deathCertificatePath ?? '';
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.belumKawin) {
      urlBelumNikahPublic = await _getPublicFile(
        detailIdentitasPerorangan?.notMarriagePath ?? '',
      );
      urlBelumNikah = detailIdentitasPerorangan?.notMarriagePath ?? '';
    }
  }

  Future _fetchIdentitasDiriDebitur() async {
    final res = await runBusyFuture(
      _peroranganAPI.fetchIdentitasPerorangan(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      ),
    );
    res.fold(
      (l) => null,
      (data) async {
        _detailIdentitasPerorangan = data;
        if (_detailIdentitasPerorangan?.tagLocation?.latLng != null) {
          tagAlamatLatLng['lat'] = double.parse(
            detailIdentitasPerorangan?.tagLocation?.latLng?.split(', ')[0] ??
                '0',
          );

          tagAlamatLatLng['lng'] = double.parse(
            detailIdentitasPerorangan?.tagLocation?.latLng?.split(', ')[1] ??
                '0',
          );
        }
        notifyListeners();
      },
    );
  }

  // ignore: long-method
  void _prePopulateDebitur() {
    tagLocationNameController
      ..text = detailIdentitasPerorangan?.tagLocation?.name ?? ''
      ..selection = TextSelection.collapsed(
        offset: tagLocationNameController.text.length,
      );

    tagAlamatLatLng['lat'] =
        detailIdentitasPerorangan?.tagLocation!.latLng!.split(', ')[0];

    tagAlamatLatLng['lng'] =
        detailIdentitasPerorangan?.tagLocation!.latLng!.split(', ')[1];

    namaDebiturController
      ..text = detailIdentitasPerorangan?.fullName ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaDebiturController.text.length,
      );

    noKtpDebiturController
      ..text = detailIdentitasPerorangan?.ktpNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: noKtpDebiturController.text.length,
      );

    nomorNPWPController
      ..text = detailIdentitasPerorangan?.npwpNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: nomorNPWPController.text.length,
      );

    jenisKelaminController
      ..text = detailIdentitasPerorangan?.gender ?? ''
      ..selection = TextSelection.collapsed(
        offset: jenisKelaminController.text.length,
      );

    tempatLahirController
      ..text = detailIdentitasPerorangan?.placeOfBirth ?? ''
      ..selection = TextSelection.collapsed(
        offset: tempatLahirController.text.length,
      );

    tanggalLahirController
      ..text =
          (detailIdentitasPerorangan?.dateOfBirth?.date?.isNotEmpty ?? false)
              ? DateStringFormatter.forDetailPrakarsaDate(
                  detailIdentitasPerorangan?.dateOfBirth?.date ?? '',
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalLahirController.text.length,
      );

    statusPerkawinanController
      ..text = detailIdentitasPerorangan?.maritalStatus ?? ''
      ..selection = TextSelection.collapsed(
        offset: statusPerkawinanController.text.length,
      );

    nomorKKController
      ..text = detailIdentitasPerorangan?.kkNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: nomorKKController.text.length,
      );

    tanggalKKController
      ..text = (detailIdentitasPerorangan?.kkDate ?? '').toString().isNotEmpty
          ? DateStringFormatter.forDetailPrakarsaDate(
              detailIdentitasPerorangan?.kkDate ?? '',
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalKKController.text.length,
      );

    noAktaNikahController
      ..text = detailIdentitasPerorangan?.marriageNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: noAktaNikahController.text.length,
      );

    tglAktaNikahController
      ..text =
          (detailIdentitasPerorangan?.marriageDate ?? '').toString().isNotEmpty
              ? DateStringFormatter.forDetailPrakarsaDate(
                  detailIdentitasPerorangan?.marriageDate ?? '',
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: tglAktaNikahController.text.length,
      );

    phoneNumController
      ..text = (detailIdentitasPerorangan?.phoneNum ?? '').replaceAll('+62', '')
      ..selection = TextSelection.collapsed(
        offset: phoneNumController.text.length,
      );

    emailController
      ..text = detailIdentitasPerorangan?.email ?? ''
      ..selection = TextSelection.collapsed(
        offset: emailController.text.length,
      );

    addressController
      ..text = detailIdentitasPerorangan?.detail ?? ''
      ..selection = TextSelection.collapsed(
        offset: addressController.text.length,
      );

    postalCodeController
      ..text = detailIdentitasPerorangan?.postalCode ?? ''
      ..selection = TextSelection.collapsed(
        offset: postalCodeController.text.length,
      );

    provinceController
      ..text = detailIdentitasPerorangan?.province ?? ''
      ..selection = TextSelection.collapsed(
        offset: provinceController.text.length,
      );

    cityController
      ..text = detailIdentitasPerorangan?.city ?? ''
      ..selection = TextSelection.collapsed(
        offset: cityController.text.length,
      );

    districController
      ..text = detailIdentitasPerorangan?.district ?? ''
      ..selection = TextSelection.collapsed(
        offset: districController.text.length,
      );

    villageController
      ..text = detailIdentitasPerorangan?.village ?? ''
      ..selection = TextSelection.collapsed(
        offset: villageController.text.length,
      );

    rtController
      ..text = detailIdentitasPerorangan?.rt ?? ''
      ..selection = TextSelection.collapsed(
        offset: rtController.text.length,
      );

    rwController
      ..text = detailIdentitasPerorangan?.rw ?? ''
      ..selection = TextSelection.collapsed(
        offset: rwController.text.length,
      );

    jenisKreditController
      ..text = 'Pinang Maksima - PTR'
      ..selection = TextSelection.collapsed(
        offset: jenisKreditController.text.length,
      );

    bentukUsahaController
      ..text = detailIdentitasPerorangan?.typePipeline ?? '-'
      ..selection = TextSelection.collapsed(
        offset: bentukUsahaController.text.length,
      );

    tglTerbitKtpController
      ..text = (detailIdentitasPerorangan?.dateOfIssuedKTP ?? '')
              .toString()
              .isNotEmpty
          ? DateStringFormatter.forDetailPrakarsaDate(
              detailIdentitasPerorangan?.dateOfIssuedKTP ?? '',
            )
          : '-'
      ..selection = TextSelection.collapsed(
        offset: tglTerbitKtpController.text.length,
      );

    religionController
      ..text =
          '${detailIdentitasPerorangan?.religion ?? ''} - ${ReligionStringFormatter.forOutput(detailIdentitasPerorangan?.religion ?? '')}'
      ..selection = TextSelection.collapsed(
        offset: religionController.text.length,
      );

    lasatEducationController
      ..text = detailIdentitasPerorangan?.lastEducation ?? ''
      ..selection = TextSelection.collapsed(
        offset: lasatEducationController.text.length,
      );

    motherMaidController
      ..text = detailIdentitasPerorangan?.motherMaiden ?? ''
      ..selection = TextSelection.collapsed(
        offset: motherMaidController.text.length,
      );

    numberOfDependentsController
      ..text = (detailIdentitasPerorangan?.numberOfDependents ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: numberOfDependentsController.text.length,
      );

    tagAlamatLatLng['lat'] =
        detailIdentitasPerorangan?.tagLocation!.latLng!.split(', ')[0];

    tagAlamatLatLng['lng'] =
        detailIdentitasPerorangan?.tagLocation!.latLng!.split(', ')[1];

    tagLocationController
      ..text = '${tagAlamatLatLng['lat']}, ${tagAlamatLatLng['lng']}'
      ..selection = TextSelection.collapsed(
        offset: tagLocationController.text.length,
      );
  }

  void _prepopulateStatusBelumNikah() {
    noSuratBelumNikahController
      ..text = (detailIdentitasPerorangan?.notMarriageNum ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: noSuratBelumNikahController.text.length,
      );
    tanggalSuratBelumNikahController
      ..text = (detailIdentitasPerorangan?.notMarriageDate ?? '')
              .toString()
              .isNotEmpty
          ? DateStringFormatter.forDetailPrakarsaDate(
              detailIdentitasPerorangan?.notMarriageDate ?? '',
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalSuratBelumNikahController.text.length,
      );
  }

  void _prepopulateStatusCeraiHidup() {
    noAktaCeraiController
      ..text = (detailIdentitasPerorangan?.divorceNum ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: noAktaCeraiController.text.length,
      );
    tglAktaCeraiController
      ..text =
          (detailIdentitasPerorangan?.divorceDate ?? '').toString().isNotEmpty
              ? DateStringFormatter.forDetailPrakarsaDate(
                  detailIdentitasPerorangan?.divorceDate ?? '',
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: tglAktaCeraiController.text.length,
      );
  }

  void _prepopulateStatusCeraiMati() {
    noSuratKematianController
      ..text = (detailIdentitasPerorangan?.deathCertificateNum ?? '').toString()
      ..selection = TextSelection.collapsed(
        offset: noSuratKematianController.text.length,
      );
    tglSuratKematianController
      ..text = (detailIdentitasPerorangan?.deathCertificateDate ?? '')
              .toString()
              .isNotEmpty
          ? DateStringFormatter.forDetailPrakarsaDate(
              detailIdentitasPerorangan?.deathCertificateDate ?? '',
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tglSuratKematianController.text.length,
      );
  }

  void _prePopulatePasangan() {
    namaPasanganController
      ..text = detailIdentitasPerorangan?.spouseFullname ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaPasanganController.text.length,
      );

    noKtpPasanganController
      ..text = detailIdentitasPerorangan?.spouseKtpNum ?? ''
      ..selection = TextSelection.collapsed(
        offset: noKtpPasanganController.text.length,
      );

    tempatLahirPasanganController
      ..text = detailIdentitasPerorangan?.spousePlaceOfBirth ?? ''
      ..selection = TextSelection.collapsed(
        offset: tempatLahirPasanganController.text.length,
      );

    tanggalLahirPasanganController
      ..text =
          (detailIdentitasPerorangan?.dateOfBirth?.date?.isNotEmpty ?? false)
              ? DateStringFormatter.forDetailPrakarsaDate(
                  detailIdentitasPerorangan?.spouseDateOfBirth?.date ?? '',
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalLahirPasanganController.text.length,
      );
  }

  void clearFile(int index) {
    switch (index) {
      case 0:
        urlKtpDebitur = '';
        urlKtpDebiturPublic = '';
        break;
      case 1:
        urlNpwpDebitur = '';
        urlNpwpDebiturPublic = '';
        break;
      case 2:
        urlKtpPasangan = '';

        urlKtpPasanganPublic = '';
        break;
      case 3:
        urlKkDebitur = '';
        urlKkDebiturPublic = '';
        break;
      case 4:
        urlAktaNikah = '';
        urlAktaNikahPublic = '';
        break;
      case 5:
        urlSuratCerai = '';
        urlSuratCeraiPublic = '';
        break;
      case 6:
        urlSuratKematian = '';
        urlSuratKematianPublic = '';
        break;
      case 7:
        urlBelumNikah = '';
        urlBelumNikahPublic = '';
        break;
      default:
    }
    notifyListeners();
  }

  void _setUrlFile(int index, String url) async {
    switch (index) {
      case 0:
        urlKtpDebiturPublic = await _getPublicFile(url);
        urlKtpDebitur = url;
        break;
      case 1:
        urlNpwpDebiturPublic = await _getPublicFile(url);
        urlNpwpDebitur = url;
        break;
      case 2:
        urlKtpPasanganPublic = await _getPublicFile(url);
        urlKtpPasangan = url;
        break;
      case 3:
        urlKkDebiturPublic = await _getPublicFile(url);
        urlKkDebitur = url;
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

  Map<String, dynamic> _generatePayload(bool isSavedDrafts) {
    phoneNumController.text.replaceAll('+62', '');

    final map = {
      'prakarsaId': prakarsaId,
      'fullName': detailIdentitasPerorangan?.fullName.toString(),
      'ktpNum': detailIdentitasPerorangan?.ktpNum.toString(),
      'dateOfIssuedKTP': DateStringFormatter.forInput(
        detailIdentitasPerorangan?.dateOfIssuedKTP ?? '',
      ),
      'religion': detailIdentitasPerorangan?.religion ?? '',
      'phoneNum': phoneNumController.text.trim().isNotEmpty
          ? '+62${phoneNumController.text.trim()}'
          : '',
      'lastEducation': detailIdentitasPerorangan?.lastEducation.toString(),
      'placeOfBirth': detailIdentitasPerorangan?.placeOfBirth.toString(),
      'dateOfBirth': DateStringFormatter.forInput(
        detailIdentitasPerorangan?.dateOfBirth?.date ?? '',
      ),
      'gender': detailIdentitasPerorangan?.gender.toString(),
      'maritalStatus': detailIdentitasPerorangan?.maritalStatus.toString(),
      'motherMaiden': motherMaidController.text.trim(),
      'numberOfDependents': int.parse(
        numberOfDependentsController.text.isNotEmpty
            ? numberOfDependentsController.text
            : '0',
      ),
      'postalCode': detailIdentitasPerorangan?.postalCode?.trim(),
      'email': emailController.text.trim(),
      'npwpPath': urlNpwpDebitur,
      'kkPath': urlKkDebitur,
      'ktpPath': detailIdentitasPerorangan!.ktpPath,
      'npwpNum': nomorNPWPController.text.trim(),
      'isDraft': isSavedDrafts,
      'rt': rtController.text.trim(),
      'rw': rwController.text.trim(),
      'kkNum': nomorKKController.text.trim(),
      'dateOfKK': tanggalKKController.text.trim().isNotEmpty
          ? DateStringFormatter.forInputDate(tanggalKKController.text.trim())
          : '',
      'detail': addressController.text,
    };

    if (detailIdentitasPerorangan?.maritalStatus == Common.kawin) {
      map['marriagePath'] = urlAktaNikah;
      map['spouseFullname'] = namaPasanganController.text.trim();
      map['spouseKtpNum'] = noKtpPasanganController.text.trim();
      map['spouseDateOfBirth'] = tanggalLahirPasanganController.text.trim();
      map['spousePlaceOfBirth'] = tempatLahirPasanganController.text.trim();
      map['marriageNum'] = noAktaNikahController.text.trim().isEmpty
          ? (detailIdentitasPerorangan?.marriageNum ?? '')
          : noAktaNikahController.text.trim();
      map['marriageDate'] = tglAktaNikahController.text.trim().isEmpty
          ? (detailIdentitasPerorangan?.marriageDate ?? '')
          : DateStringFormatter.forInputDate(
              tglAktaNikahController.text.trim(),
            );
    }

    if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiMati) {
      map['deathCertificatePath'] = urlSuratKematian;
      map['deathCertificateNum'] = noSuratKematianController.text.trim();
      map['deathCertificateDate'] =
          tglSuratKematianController.text.trim().isEmpty
              ? (detailIdentitasPerorangan?.deathCertificateDate ?? '')
              : DateStringFormatter.forInputDate(
                  tglSuratKematianController.text.trim(),
                );
    }

    if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiHidup) {
      map['divorcePath'] = urlSuratCerai;
      map['divorceNum'] = noAktaCeraiController.text.trim();
      map['divorceDate'] = tglAktaCeraiController.text.trim().isEmpty
          ? (detailIdentitasPerorangan?.divorceDate ?? '')
          : DateStringFormatter.forInputDate(
              tglAktaCeraiController.text.trim(),
            );
    }

    if (detailIdentitasPerorangan?.maritalStatus == Common.belumKawin) {
      map['notMarriageNum'] = noSuratBelumNikahController.text.trim();
      map['notMarriageDate'] =
          tanggalSuratBelumNikahController.text.trim().isEmpty
              ? (detailIdentitasPerorangan?.notMarriageDate ?? '')
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
    final res = await runBusyFuture(
      _peroranganAPI.updateIdentitasPerorangan(
        payload: _generatePayload(isSavedDrafts),
      ),
    );

    res.fold(
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
}
