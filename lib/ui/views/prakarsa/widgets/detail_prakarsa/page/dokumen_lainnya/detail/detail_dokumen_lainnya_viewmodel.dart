import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../application/helpers/change_doc_name.dart';
import '../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../application/models/detail_dokumen_lainnya.dart';
import '../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../infrastructure/apis/perusahaan_api.dart';

class DetailDokumenLainnyaViewModel extends BaseViewModel with RouteMixin {
  final _perusahaanAPI = locator<PerusahaanAPI>();
  final _masterAPI = locator<MasterAPI>();
  final _dialogService = locator<DialogService>();

  final String prakarsaId;
  final int codeTable;
  bool stepperStatus;

  DetailDokumenLainnyaViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.stepperStatus,
  });

  bool stepStatus = false;

  Future initialize() async {
    stepStatus = stepperStatus;
    await fetchDokumenLainnya();
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
      (errorMessage) => stepperStatus = true,
      (result) async {
        _dokumenLainnya = result;
        notifyListeners();

        await _prepopulateDokumenLain();
      },
    );
  }

  List<Map<String, dynamic>> dokumenLainnyaMap = [
    {'label': '', 'path': ''},
  ];
  Future _prepopulateDokumenLain() async {
    for (var i = 0; i <= _dokumenLainnya!.length; i++) {
      DetailDokumenLainnya lainnya = _dokumenLainnya![i];
      dokumenLainnyaMap.removeWhere((v) => v['label'] == '');
      dokumenLainnyaMap.add({
        'label': changeDocName(lainnya.docName!),
        'path': await _getPublicFile(lainnya.path!),
      });
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

  Future validateInputs() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Apakah debitur tidak memiliki dokumen usaha lainnya?',
      description:
          'Pastikan upload file jika debitur memiliki dokumen SKDP, AMDAL, HO, SIUJK',
      mainButtonTitle: 'Tidak ada dokumen lain',
      secondaryButtonTitle: 'Kembali',
      data: {
        'main': true,
        'secondary': false,
      },
    );

    if (response != null && response.confirmed) {
      _postData();
    }
  }

  Future _postData() async {
    final dokumenLainnyaMap = {
      'prakarsaId': prakarsaId,
    };

    final res = await runBusyFuture(
      _perusahaanAPI.saveEmptyDokumenLainnya(
        payload: dokumenLainnyaMap,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (successMap) {
        stepStatus = true;
        notifyListeners();
        _showSuccessDialog();
      },
    );
  }

  Future _showSuccessDialog() async {
    await _dialogService
        .showCustomDialog(
      variant: DialogType.baseImage,
      data: {
        'imageAsset': ImageConstants.successVerification,
      },
      title: 'Data Berhasil Disimpan',
      description: 'Data telah berhasil disimpan disistem',
      mainButtonTitle: 'Sip, mengerti',
    )
        .then(
      (_) {
        stepperStatus = true;
        notifyListeners();
      },
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
