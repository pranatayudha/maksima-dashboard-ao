import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/info_usaha_debitur_model.dart';
import '../../../../../../../../../../application/models/postal_code_model.dart';
import '../../../../../../../../../../infrastructure/apis/perorangan_api.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';

class FormInfoUsahaViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _peroranganAPI = locator<PeroranganAPI>();
  final _dialogService = locator<DialogService>();

  final String prakarsaId;
  final int codeTable;
  final String pipelineId;

  FormInfoUsahaViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  InfoUsahaDebiturModel? _infoUsahaModel;
  InfoUsahaDebiturModel? get infoUsahaModel => _infoUsahaModel;

  final businessNameController = TextEditingController();
  final economySectorNameController = TextEditingController();
  final subEconomySectorNameController = TextEditingController();
  final tagLocationController = TextEditingController();
  final tagLocationNameController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final districController = TextEditingController();
  final villageController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();

  final Map<String, dynamic> tagAlamatLatLng = {};

  Future initialize() async {
    await _fetchInfoUsahaDebitur();
    _prePopulateInfoUsaha();
  }

  Future _fetchInfoUsahaDebitur() async {
    final res = await runBusyFuture(
      _peroranganAPI.fetchInfoUsahaDebitur(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      ),
    );
    res.fold(
      (l) => null,
      (data) async {
        _infoUsahaModel = data;
        notifyListeners();
      },
    );
  }

  void _prePopulateInfoUsaha() {
    businessNameController
      ..text = infoUsahaModel?.businessName ?? ''
      ..selection = TextSelection.collapsed(
        offset: businessNameController.text.length,
      );

    economySectorNameController
      ..text = infoUsahaModel?.economySectorsName ?? ''
      ..selection = TextSelection.collapsed(
        offset: economySectorNameController.text.length,
      );

    subEconomySectorNameController
      ..text = infoUsahaModel?.businessName ?? ''
      ..selection = TextSelection.collapsed(
        offset: subEconomySectorNameController.text.length,
      );

    addressController
      ..text = infoUsahaModel?.detail ?? ''
      ..selection = TextSelection.collapsed(
        offset: addressController.text.length,
      );

    postalCodeController
      ..text = infoUsahaModel?.postalCode ?? ''
      ..selection = TextSelection.collapsed(
        offset: postalCodeController.text.length,
      );

    provinceController
      ..text = infoUsahaModel?.province ?? ''
      ..selection = TextSelection.collapsed(
        offset: provinceController.text.length,
      );

    cityController
      ..text = infoUsahaModel?.city ?? ''
      ..selection = TextSelection.collapsed(
        offset: cityController.text.length,
      );

    districController
      ..text = infoUsahaModel?.district ?? ''
      ..selection = TextSelection.collapsed(
        offset: districController.text.length,
      );

    villageController
      ..text = infoUsahaModel?.village ?? ''
      ..selection = TextSelection.collapsed(
        offset: villageController.text.length,
      );

    rtController
      ..text = infoUsahaModel?.rt ?? ''
      ..selection = TextSelection.collapsed(
        offset: rtController.text.length,
      );

    rwController
      ..text = infoUsahaModel?.rw ?? ''
      ..selection = TextSelection.collapsed(
        offset: rwController.text.length,
      );

    tagLocationNameController
      ..text = infoUsahaModel?.tagLocation?.name ?? ''
      ..selection = TextSelection.collapsed(
        offset: tagLocationNameController.text.length,
      );

    tagAlamatLatLng['lat'] =
        infoUsahaModel?.tagLocation!.latLng!.split(', ')[0];

    tagAlamatLatLng['lng'] =
        infoUsahaModel?.tagLocation!.latLng!.split(', ')[1];

    tagLocationController
      ..text = '${tagAlamatLatLng['lat']}, ${tagAlamatLatLng['lng']}'
      ..selection = TextSelection.collapsed(
        offset: tagLocationController.text.length,
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
    final map = {
      'prakarsaId': prakarsaId,
      'isDraft': isSavedDrafts,
      'addressIsSame': false,
      'tagLocation': {
        'latLng': tagLocationController.text,
        'name': tagLocationNameController.text,
      },
      'detail': addressController.text.trim(),
      'postalCode': postalCodeController.text.trim(),
      'province': provinceController.text.trim(),
      'city': cityController.text.trim(),
      'district': districController.text.trim(),
      'village': villageController.text.trim(),
      'rt': rtController.text.trim(),
      'rw': rwController.text.trim(),
    };

    return map;
  }

  Future _postData({
    required bool isSavedDrafts,
  }) async {
    final res = await runBusyFuture(
      _peroranganAPI.updateInfoUsahaPerorangan(
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
