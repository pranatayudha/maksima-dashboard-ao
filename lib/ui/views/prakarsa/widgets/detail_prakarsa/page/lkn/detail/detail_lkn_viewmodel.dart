import 'dart:developer';

import 'package:stacked/stacked.dart';

import '../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../application/models/detail_lkn.dart';
import '../../../../../../../../infrastructure/apis/lkn_api.dart';
import '../../../../../../../../infrastructure/apis/master_api.dart';

class DetailLKNViewModel extends BaseViewModel with RouteMixin {
  final _lknAPI = locator<LKNAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;
  DetailLKNViewModel({
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

        await _prepopulateVisitPath();
      },
    );
  }

  List<String> fotoKunjunganURL = [];
  List<String> fotoKunjunganPublicURL = [];
  Future _prepopulateVisitPath() async {
    if (_detailLKN?.dataLkn?.visitPath?.isNotEmpty ?? false) {
      for (var i = 0; i <= (_detailLKN?.dataLkn?.visitPath?.length ?? 0); i++) {
        fotoKunjunganURL.add(_detailLKN?.dataLkn?.visitPath?[i].path ?? '');
        fotoKunjunganPublicURL.add(
          await _getPublicFile(_detailLKN?.dataLkn?.visitPath?[i].path ?? ''),
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
}
