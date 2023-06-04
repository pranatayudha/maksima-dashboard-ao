import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_identitas_perorangan.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../../infrastructure/apis/perorangan_api.dart';
import '../../../../../../../../shared/location/open_maps.dart';

class DetailIdentitasDiriViewModel extends BaseViewModel with RouteMixin {
  final _masterAPI = locator<MasterAPI>();
  final _peroranganAPI = locator<PeroranganAPI>();

  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double width;

  DetailIdentitasDiriViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.width,
  });

  DetailIdentitasPerorangan? _detailIdentitasPerorangan;
  DetailIdentitasPerorangan? get detailIdentitasPerorangan =>
      _detailIdentitasPerorangan;

  String urlKtpDebitur = '';
  String urlNpwpDebitur = '';
  String urlKtpPasangan = '';
  String urlKkDebitur = '';
  String urlAktaNikah = '';
  String urlSuratCerai = '';
  String urlSuratKematian = '';
  String urlKtpDebiturPublic = '';
  String urlNpwpDebiturPublic = '';
  String urlKtpPasanganPublic = '';
  String urlKkDebiturPublic = '';
  String urlAktaNikahPublic = '';
  String urlSuratCeraiPublic = '';
  String urlSuratKematianPublic = '';
  String urlBelumNikah = '';
  String urlBelumNikahPublic = '';

  final Map<String, double> tagLocLatLng = {};

  Future initialize() async {
    await fetchIdentitasDiriDebitur();
    await _prePopulateDocument();
  }

  Future _prePopulateDocument() async {
    urlKtpDebiturPublic =
        await _getPublicFile(detailIdentitasPerorangan?.ktpPath ?? '');
    urlNpwpDebiturPublic =
        await _getPublicFile(detailIdentitasPerorangan?.npwpPath ?? '');
    urlKkDebiturPublic =
        await _getPublicFile(detailIdentitasPerorangan?.kkPath ?? '');
    if (detailIdentitasPerorangan?.maritalStatus == Common.kawin) {
      urlKtpPasanganPublic =
          await _getPublicFile(detailIdentitasPerorangan?.spouseKtpPath ?? '');
      urlAktaNikahPublic =
          await _getPublicFile(detailIdentitasPerorangan?.marriagePath ?? '');
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiHidup) {
      urlSuratCeraiPublic =
          await _getPublicFile(detailIdentitasPerorangan?.divorcePath ?? '');
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.ceraiMati) {
      urlSuratKematianPublic = await _getPublicFile(
        detailIdentitasPerorangan?.deathCertificatePath ?? '',
      );
    } else if (detailIdentitasPerorangan?.maritalStatus == Common.belumKawin) {
      urlBelumNikahPublic = await _getPublicFile(
        detailIdentitasPerorangan?.notMarriagePath ?? '',
      );
    }
  }

  Future fetchIdentitasDiriDebitur() async {
    final res = await runBusyFuture(
      _peroranganAPI.fetchIdentitasPerorangan(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      ),
    );
    res.fold(
      (l) => null,
      (data) async {
        _detailIdentitasPerorangan = data;
        if (_detailIdentitasPerorangan?.tagLocation?.latLng != null) {
          tagLocLatLng['lat'] = double.parse(
            detailIdentitasPerorangan?.tagLocation?.latLng?.split(', ')[0] ??
                '0',
          );

          tagLocLatLng['lng'] = double.parse(
            detailIdentitasPerorangan?.tagLocation?.latLng?.split(', ')[1] ??
                '0',
          );
        }
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

  void previewLocation(BuildContext context, String title) {
    if (_detailIdentitasPerorangan?.tagLocation?.latLng != null) {
      OpenMaps().openPreview(
        context: context,
        width: width,
        title: title,
        nameTag: (_detailIdentitasPerorangan?.tagLocation?.name ?? ''),
        location: LatLng(
          tagLocLatLng['lat']!,
          tagLocLatLng['lng']!,
        ),
      );
    }
  }
}
