import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../../infrastructure/apis/perusahaan_api.dart';

class ListPengurusViewModel extends BaseViewModel with RouteMixin {
  final _perusahaanAPI = locator<PerusahaanAPI>();

  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  ListPengurusViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  List<InformasiPengurusModel>? _ritelInformasiPengurus;

  List<InformasiPengurusModel>? get ritelInformasiPengurus =>
      _ritelInformasiPengurus;

  // String _prakarsaType = '';

  Future initialize() async {
    // _prakarsaType = InitialCodeTableFormatter.getPrakarsaType(codeTable);
    await fetchInformasiPengurus();
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
        notifyListeners();
      },
    );
  }

  Widget getStatus(int status) {
    if (status > 0) {
      return Container(
        decoration: BoxDecoration(
          color:
              status == 2 ? CustomColor.stateSuccess : CustomColor.warningText,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Image.asset(
          status == 2 ? IconConstants.iconChecked : IconConstants.iconWarning,
          height: 16,
        ),
      );
    } else {
      return Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          border: Border.all(color: CustomColor.darkGrey),
        ),
      );
    }
  }
}
