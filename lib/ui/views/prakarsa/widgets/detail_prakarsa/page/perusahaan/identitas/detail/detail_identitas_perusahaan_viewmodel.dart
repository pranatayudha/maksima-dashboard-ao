import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/detail_identitas_perusahaan.dart';
import '../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../infrastructure/apis/perusahaan_api.dart';
import '../../../../../../../../shared/location/open_maps.dart';

class DetailIdentitasPerusahaanViewModel extends BaseViewModel with RouteMixin {
  final _perusahaanAPI = locator<PerusahaanAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;
  final double width;

  DetailIdentitasPerusahaanViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
  });

  String _prakarsaType = '';

  final Map<String, double> tagLocLatLng = {};

  Future initialize() async {
    _prakarsaType = InitialCodeTableFormatter.getPrakarsaType(codeTable);

    await _fetchIdentitasPerusahaan();
  }

  DetailIdentitasPerusahaan? _identitasPerusahaan;
  DetailIdentitasPerusahaan? get identitasPerusahaan => _identitasPerusahaan;
  Future _fetchIdentitasPerusahaan() async {
    final res = await runBusyFuture(
      _perusahaanAPI.fetchIdentitasPerusahaan(
        prakarsaId: prakarsaId,
        prakarsaType: _prakarsaType,
      ),
    );

    res.fold(
      (errorMessage) => log(errorMessage),
      (result) async {
        _identitasPerusahaan = result;
        notifyListeners();

        await _prepopulateNpwpPath();
      },
    );
  }

  String npwpPath = '';
  Future _prepopulateNpwpPath() async {
    if (_identitasPerusahaan!.companyNpwpPath!.isNotEmpty) {
      npwpPath = await _getPublicFile(_identitasPerusahaan!.companyNpwpPath!);
      if (_identitasPerusahaan?.tagLocation?.latLng != null) {
        tagLocLatLng['lat'] = double.parse(
          _identitasPerusahaan?.tagLocation?.latLng?.split(', ')[0] ?? '0',
        );

        tagLocLatLng['lng'] = double.parse(
          _identitasPerusahaan?.tagLocation?.latLng?.split(', ')[1] ?? '0',
        );
      }
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

  void previewLocation(BuildContext context, String title) {
    if (_identitasPerusahaan?.tagLocation?.latLng != null) {
      OpenMaps().openPreview(
        context: context,
        width: width,
        title: title,
        nameTag: (_identitasPerusahaan?.tagLocation?.name ?? ''),
        location: LatLng(
          tagLocLatLng['lat']!,
          tagLocLatLng['lng']!,
        ),
      );
    }
  }
}
