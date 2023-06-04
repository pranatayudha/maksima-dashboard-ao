import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/info_usaha_debitur_model.dart';
import '../../../../../../../../../../infrastructure/apis/perorangan_api.dart';
import '../../../../../../../../shared/location/open_maps.dart';

class DetailInfoUsahaViewModel extends BaseViewModel with RouteMixin {
  final _peroranganAPI = locator<PeroranganAPI>();

  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double width;

  DetailInfoUsahaViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.width,
  });

  InfoUsahaDebiturModel? _infoUsahaModel;
  InfoUsahaDebiturModel? get infoUsahaModel => _infoUsahaModel;

  final Map<String, double> tagLocLatLng = {};

  Future initialize() async {
    await fetchInfoUsahaDebitur();
  }

  Future fetchInfoUsahaDebitur() async {
    final res = await runBusyFuture(
      _peroranganAPI.fetchInfoUsahaDebitur(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      ),
    );
    res.fold(
      (l) => null,
      (data) async {
        _infoUsahaModel = data;
        if (_infoUsahaModel?.tagLocation?.latLng != null) {
          tagLocLatLng['lat'] = double.parse(
            _infoUsahaModel?.tagLocation?.latLng?.split(', ')[0] ?? '0',
          );

          tagLocLatLng['lng'] = double.parse(
            _infoUsahaModel?.tagLocation?.latLng?.split(', ')[1] ?? '0',
          );
        }
        notifyListeners();
      },
    );
  }

  void previewLocation(BuildContext context, String title) {
    if (_infoUsahaModel?.tagLocation?.latLng != null) {
      OpenMaps().openPreview(
        context: context,
        width: width,
        title: title,
        nameTag: (_infoUsahaModel?.tagLocation?.name ?? ''),
        location: LatLng(
          tagLocLatLng['lat']!,
          tagLocLatLng['lng']!,
        ),
      );
    }
  }
}
