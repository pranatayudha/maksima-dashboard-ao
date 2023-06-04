import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../infrastructure/apis/perusahaan_api.dart';

class DetailInformasiPengurusViewModel extends BaseViewModel with RouteMixin {
  final _masterAPI = locator<MasterAPI>();
  final _perusahaanAPI = locator<PerusahaanAPI>();

  final InformasiPengurusModel dataPengurus;
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;

  DetailInformasiPengurusViewModel({
    required this.dataPengurus,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  List<InformasiPengurusModel>? _ritelInformasiPengurus;

  List<InformasiPengurusModel>? get ritelInformasiPengurus =>
      _ritelInformasiPengurus;

  InformasiPengurusModel? infoPengurus;

  String urlKtpPengurus = '';
  String urlNpwpPengurus = '';
  String urlKtpPasangan = '';
  String urlKkPengurus = '';
  String urlAktaNikah = '';
  String urlSuratCerai = '';
  String urlSuratKematian = '';
  String urlKtpPengurusPublic = '';
  String urlNpwpPengurusPublic = '';
  String urlKtpPasanganPublic = '';
  String urlKkPengurusPublic = '';
  String urlAktaNikahPublic = '';
  String urlSuratCeraiPublic = '';
  String urlSuratKematianPublic = '';
  String urlBelumNikah = '';
  String urlBelumNikahPublic = '';

  Future initialize() async {
    await fetchInformasiPengurus();
    await _prePopulateDocument();
  }

  Future _prePopulateDocument() async {
    urlKtpPengurusPublic = await _getPublicFile(infoPengurus?.ktpPath ?? '');
    urlNpwpPengurusPublic = await _getPublicFile(infoPengurus?.npwpPath ?? '');
    urlKkPengurusPublic = await _getPublicFile(infoPengurus?.kkPath ?? '');
    if (infoPengurus?.maritalStatus == Common.kawin) {
      urlKtpPasanganPublic =
          await _getPublicFile(infoPengurus?.spouseKtpPath ?? '');
      urlAktaNikahPublic =
          await _getPublicFile(infoPengurus?.marriagePath ?? '');
    } else if (infoPengurus?.maritalStatus == Common.ceraiHidup) {
      urlSuratCeraiPublic =
          await _getPublicFile(infoPengurus?.divorcePath ?? '');
    } else if (infoPengurus?.maritalStatus == Common.ceraiMati) {
      urlSuratKematianPublic =
          await _getPublicFile(infoPengurus?.deathCertificatePath ?? '');
    } else if (infoPengurus?.maritalStatus == Common.belumKawin) {
      urlBelumNikahPublic =
          await _getPublicFile(infoPengurus?.notMarriagePath ?? '');
    }
  }

  Future fetchInformasiPengurus() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchByIdInformasiPengurus(
        codeTable: codeTable,
        prakarsaId: prakarsaId,
        pipelineId: pipelineId,
      ),
    );
    res.fold(
      (l) => null,
      (ritelPrakarsa) async {
        _ritelInformasiPengurus = ritelPrakarsa;
        ritelPrakarsa.forEach((element) {
          if (element.id == dataPengurus.id) {
            infoPengurus = element;
          }
        });
        notifyListeners();
      },
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
}
