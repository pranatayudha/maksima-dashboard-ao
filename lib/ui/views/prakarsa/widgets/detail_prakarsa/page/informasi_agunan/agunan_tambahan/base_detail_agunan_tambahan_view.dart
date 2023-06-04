import 'package:flutter/material.dart';

import '../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../widgets/base_view.dart';
import 'tanah/detail/detail_agunan_tambahan_view.dart';
import 'tanah_bangunan/detail/detail_agunan_tanah_bangunan_view.dart';

class BaseDetailAgunanTambahanView extends StatelessWidget {
  final ListAgunanTambahanModel? dataAgunan;
  final int codeTable;
  final String prakarsaId;
  final Function(dynamic) selectedAgunan;

  const BaseDetailAgunanTambahanView({
    Key? key,
    this.dataAgunan,
    required this.codeTable,
    required this.prakarsaId,
    required this.selectedAgunan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: _buildDetailAgunan(
        prakarsaId,
        codeTable,
        dataAgunan,
        selectedAgunan,
      ),
    );
  }
}

Widget _buildDetailAgunan(prakarsaId, codeTable, dataAgunan, selectedAgunan) {
  String agunanType = dataAgunan?.codeTable ?? '-';

  switch (agunanType.toLowerCase()) {
    case 'tanah':
      return DetailAgunanTambahanView(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        dataAgunan: dataAgunan,
        selectedAgunan: selectedAgunan,
      );
    case 'tanah bangunan':
      return DetailAgunanTanahBangunanView(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        dataAgunan: dataAgunan,
        selectedAgunan: selectedAgunan,
      );
    default:
      return Container();
  }
}
