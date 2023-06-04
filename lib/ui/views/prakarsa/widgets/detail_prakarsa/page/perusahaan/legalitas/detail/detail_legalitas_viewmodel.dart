import 'dart:developer';

import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_legalitas.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../../infrastructure/apis/perusahaan_api.dart';

class DetailLegalitasViewModel extends BaseViewModel with RouteMixin {
  final _perusahaanAPI = locator<PerusahaanAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;
  DetailLegalitasViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  String _prakarsaType = '';

  Future initialize() async {
    _prakarsaType = InitialCodeTableFormatter.getPrakarsaType(codeTable);

    await _fecthLegalitas();
  }

  DetailLegalitas? _legalitas;
  DetailLegalitas? get legalitas => _legalitas;
  Future _fecthLegalitas() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchLegalitas(
        prakarsaId: prakarsaId,
        prakarsaType: _prakarsaType,
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _legalitas = result;
        notifyListeners();

        await _prepopulateAktaPendirianDoc();
        await _prepopulateAktaPerubahanTerakhirDoc();
      },
    );
  }

  String deedEstPath = '';
  String skKumhamPendirianPath = '';
  Future _prepopulateAktaPendirianDoc() async {
    if (_legalitas!.deedEstPath!.isNotEmpty) {
      deedEstPath = await _getPublicFile(_legalitas!.deedEstPath!);
      notifyListeners();
    }

    if (_legalitas!.skKumhamPath!.isNotEmpty) {
      skKumhamPendirianPath = await _getPublicFile(_legalitas!.skKumhamPath!);
      notifyListeners();
    }
  }

  List<String> deedLastPath = [];
  List<String> skKumhamPerubahanPath = [];
  Future _prepopulateAktaPerubahanTerakhirDoc() async {
    if (_legalitas!.deedOthers != null) {
      for (int i = 0; i < _legalitas!.deedOthers!.length; i++) {
        if (_legalitas!.deedOthers![i].deedEstFilePath!.isNotEmpty) {
          deedLastPath.add(
            await _getPublicFile(_legalitas!.deedOthers![i].deedEstFilePath!),
          );
          notifyListeners();
        }

        if (_legalitas!.deedOthers![i].skKumhamFilePath!.isNotEmpty) {
          skKumhamPerubahanPath.add(
            await _getPublicFile(_legalitas!.deedOthers![i].skKumhamFilePath!),
          );
          notifyListeners();
        }
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
