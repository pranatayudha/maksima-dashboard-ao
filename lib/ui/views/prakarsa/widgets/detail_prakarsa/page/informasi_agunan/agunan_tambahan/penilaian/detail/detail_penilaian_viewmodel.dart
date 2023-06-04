import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_penilaian_model.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';

class DetailPenilaianViewModel extends BaseViewModel with RouteMixin {
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();

  final String id;
  final String prakarsaId;

  DetailPenilaianViewModel({
    required this.id,
    required this.prakarsaId,
  });

  DetailPenilaianModel? _detailPenilaian;
  DetailPenilaianModel? get detailPenilaian => _detailPenilaian;

  void initialize() async {
    await fetchDetailPenilaian();
  }

  Future fetchDetailPenilaian() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchDetailPenilaian(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        _detailPenilaian = res;
      },
    );
    notifyListeners();
  }
}
