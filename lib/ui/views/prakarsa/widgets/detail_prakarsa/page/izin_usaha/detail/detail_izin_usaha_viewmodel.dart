import 'dart:developer';

import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/detail_izin_usaha.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../infrastructure/apis/perusahaan_api.dart';

class DetailIzinUsahaViewModel extends BaseViewModel with RouteMixin {
  final _perusahaanAPI = locator<PerusahaanAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;
  DetailIzinUsahaViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  Future initialize() async {
    await fetchIzinUsaha();
  }

  List<DetailIzinUsaha>? _izinUsaha;
  List<DetailIzinUsaha>? get izinUsaha => _izinUsaha;
  Future fetchIzinUsaha() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchIzinUsaha(
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _izinUsaha = result;
        notifyListeners();

        await _prepopulateIzinUsahaDoc();
      },
    );
  }

  List<String> docPath = [];
  Future _prepopulateIzinUsahaDoc() async {
    for (var i = 0; i <= _izinUsaha!.length; i++) {
      docPath.add(await _getPublicFile(_izinUsaha![i].pathDokumen!));
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
}
