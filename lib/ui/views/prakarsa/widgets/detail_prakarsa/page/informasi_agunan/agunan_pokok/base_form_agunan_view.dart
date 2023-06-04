import 'package:flutter/material.dart';

import '../../../../../../../../application/models/list_agunan_pokok_model.dart';
import '../../../../../../../shared/loading_indicator.dart';
import '../../../widgets/base_view.dart';
import 'agunan_persediaan/form/form_agunan_persediaan_view.dart';
import 'agunan_piutang/form/form_agunan_piutang_view.dart';
import 'widgets/dropdown_agunan_pokok.dart';

class BaseFormAgunanView extends StatefulWidget {
  final ListAgunanModel? dataAgunan;
  final int codeTable;
  final String prakarsaId;
  final String pipelineId;
  final double width;
  const BaseFormAgunanView({
    Key? key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.width,
  }) : super(key: key);

  @override
  State<BaseFormAgunanView> createState() => _BaseFormAgunanViewState();
}

class _BaseFormAgunanViewState extends State<BaseFormAgunanView> {
  String selectedValue = '';
  bool isLoadForm = false;

  @override
  void initState() {
    isLoadForm = true;
    if (widget.dataAgunan?.jenisAgunanPokok != null) {
      selectedValue =
          widget.dataAgunan?.jenisAgunanPokok == 250 ? 'Piutang' : 'Persediaan';
    } else {
      selectedValue = '';
    }
    isLoadForm = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: isLoadForm
          ? const LoadingIndicator()
          : Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownAgunan(
                  selectedValue: TextEditingController(text: selectedValue),
                  onSelected: (val) => setState(
                    () => selectedValue = val,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (selectedValue == 'Piutang')
                  FormAgunanPiutangView(
                    id: widget.dataAgunan?.id ?? '',
                    codeTable: widget.codeTable,
                    prakarsaId: widget.prakarsaId,
                    pipelineId: widget.pipelineId,
                  )
                else if (selectedValue == 'Persediaan')
                  FormAgunanPersediaanView(
                    id: widget.dataAgunan?.id ?? '',
                    codeTable: widget.codeTable,
                    prakarsaId: widget.prakarsaId,
                    pipelineId: widget.pipelineId,
                    width: widget.width,
                  )
                else
                  SizedBox(
                    height: 200,
                    child: Text(selectedValue),
                  ),
              ],
            ),
    );
  }
}
