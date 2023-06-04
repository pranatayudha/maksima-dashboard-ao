import 'package:flutter/material.dart';

import '../../../../../../../../application/models/list_agunan_pokok_model.dart';
import 'agunan_persediaan/detail/detail_agunan_persediaan_view.dart';
import 'agunan_piutang/detail/detail_agunan_piutang_view.dart';

class BaseDetailAgunanView extends StatelessWidget {
  final ListAgunanModel? dataAgunan;
  final String prakarsaId;
  final int codeTable;
  final Function(dynamic) selectedAgunan;
  final double width;
  const BaseDetailAgunanView({
    Key? key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.codeTable,
    required this.selectedAgunan,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataAgunan?.jenisAgunanPokok != 250) {
      return DetailAgunanPersediaanView(
        dataAgunan: dataAgunan,
        codeTable: codeTable,
        prakarsaId: prakarsaId,
        selectedAgunan: selectedAgunan,
        width: width,
      );
    } else {
      return DetailAgunanPiutangView(
        dataAgunan: dataAgunan,
        codeTable: codeTable,
        prakarsaId: prakarsaId,
        selectedAgunan: selectedAgunan,
      );
    }
  }
}
