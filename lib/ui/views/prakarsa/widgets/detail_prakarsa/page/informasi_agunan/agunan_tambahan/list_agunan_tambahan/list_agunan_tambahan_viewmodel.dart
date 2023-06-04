import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';

class ListAgunanTambahanViewModel extends BaseViewModel with RouteMixin {
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();

  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  ListAgunanTambahanViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  String? selectedAgunanTambahan;
  List<ListAgunanTambahanModel>? _listAgunan;
  List<ListAgunanTambahanModel>? get listAgunan => _listAgunan;

  void initialise() async {
    await fetchAgunanTambahan();
  }

  Future fetchAgunanTambahan() async {
    final res = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahan(
        prakarsaId: prakarsaId,
      ),
    );

    res.fold((l) => null, (response) => _listAgunan = response);
  }

  void navigateToDetail(String val) {
    selectedAgunanTambahan = val;
    navigateTo(ConstantPageRoute.detailAgunanTambahan);
    notifyListeners();
  }

  void setSelectedAgunanTambahan(String val) {
    selectedAgunanTambahan = val;
    navigateTo(ConstantPageRoute.formInfoUmumAgunan);
    notifyListeners();
  }
}
