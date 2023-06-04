import 'package:flutter/material.dart';

import '../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../widgets/base_view.dart';
import 'tanah/form/form_agunan_tanah_view.dart';
import 'tanah_bangunan/form/form_agunan_tanah_bangunan_view.dart';

class BaseFormAgunanTambahanView extends StatelessWidget {
  final ListAgunanTambahanModel? dataAgunan;
  final int codeTable;
  final String prakarsaId;
  final double height;
  final double width;
  final Function(dynamic) agunanId;
  const BaseFormAgunanTambahanView({
    Key? key,
    this.dataAgunan,
    required this.codeTable,
    required this.prakarsaId,
    required this.height,
    required this.width,
    required this.agunanId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      height: height,
      child: _buildFormAgunan(
        dataAgunan?.codeTable ?? '-',
        dataAgunan?.id ?? '',
      ),
    );
  }

  Widget _buildFormAgunan(
    String agunanType,
    String id,
  ) {
    switch (agunanType.toLowerCase()) {
      case 'tanah':
        return FormAgunanTanahView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          width: width,
          agunanId: (id) => agunanId(id),
          id: id,
        );
      case 'tanah dan bangunan':
        return FormAgunanTanahBangunanView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          width: width,
          agunanId: (id) => agunanId(id),
          id: id,
        );
      default:
        return Container();
    }
  }
}
