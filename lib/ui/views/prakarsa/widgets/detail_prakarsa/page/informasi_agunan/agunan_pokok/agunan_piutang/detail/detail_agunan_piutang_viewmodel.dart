import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/calculation_agunan_model.dart';
import '../../../../../../../../../../application/models/detail_agunan_pokok_model.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_pokok_api.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';

class DetailAgunanPiutangViewModel extends BaseViewModel with RouteMixin {
  final _agunanPokokAPI = locator<AgunanPokokAPI>();
  final _masterAPI = locator<MasterAPI>();
  final _dialogService = locator<DialogService>();

  final String prakarsaId;
  final int codeTable;
  final String id;

  DetailAgunanPiutangViewModel({
    required this.id,
    required this.prakarsaId,
    required this.codeTable,
  });

  DetailAgunanPokokModel? _detailAgunanPokok;
  DetailAgunanPokokModel? get detailAgunanPokok => _detailAgunanPokok;
  CalculationAgunanModel? _calculationAgunan;
  CalculationAgunanModel? get calculationAgunan => _calculationAgunan;

  String agunanType = '';
  String? agunanPublicUrl;

  void initialize() async {
    await fetchDetailAgunanPokok();
    await getCalculation();
  }

  Future fetchDetailAgunanPokok() async {
    final response = await runBusyFuture(
      _agunanPokokAPI.fetchAgunanPokokDetail(
        id: int.parse(id),
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
      },
    );
    notifyListeners();
  }

  Future validateDelete({
    required int id,
  }) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Hapus Data Agunan',
      description: 'Apakah anda yakin ingin hapus data agunan ini?',
      mainButtonTitle: 'Hapus Data',
      secondaryButtonTitle: 'Kembali',
      data: {
        'main': true,
        'secondary': false,
      },
    );

    if (response != null && response.confirmed) {
      deleteAgunanPokok(id);
    }
  }

  Future deleteAgunanPokok(int id) async {
    final res = await runBusyFuture(
      _agunanPokokAPI.deleteAgunanPokok(
        id: id,
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (l) => null,
      (r) => _showSuccessDialog('Berhasil hapus data Agunan').then(
        (_) => navigateBack(),
      ),
    );
    notifyListeners();
  }

  Future _showSuccessDialog(String successMessage) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.success,
      description: successMessage,
      mainButtonTitle: 'OK',
    );
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
      (calculationResult) => _calculationAgunan = calculationResult,
    );
    notifyListeners();
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
}
