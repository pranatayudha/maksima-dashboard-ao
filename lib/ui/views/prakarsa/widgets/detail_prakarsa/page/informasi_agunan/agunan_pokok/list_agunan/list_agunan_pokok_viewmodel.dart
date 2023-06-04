import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/list_agunan_pokok_model.dart';
import '../../../../../../../../../infrastructure/apis/agunan_pokok_api.dart';

class ListAgunanPokokViewModel extends BaseViewModel with RouteMixin {
  final _agunanPokokAPI = locator<AgunanPokokAPI>();

  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  ListAgunanPokokViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  List<ListAgunanModel>? _listAgunanModel;

  List<ListAgunanModel>? get listAgunanModel => _listAgunanModel;

  void initialise() async {
    await fetchAgunanPokokList();
  }

  Future fetchAgunanPokokList() async {
    final response = await runBusyFuture(
      _agunanPokokAPI.fetchAgunanPokok(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      ),
    );

    response.fold(
      (l) => null,
      (res) => _listAgunanModel = res,
    );
    notifyListeners();
  }
}
