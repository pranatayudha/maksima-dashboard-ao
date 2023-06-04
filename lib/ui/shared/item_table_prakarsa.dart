import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/text_style_constants.dart';
import '../../application/helpers/date_string_formatter.dart';
import '../../application/helpers/initial_code_table_formatter.dart';
import '../../application/helpers/rupiah_formatter.dart';
import '../../application/helpers/status_pengajuan_formatter.dart';
import '../../application/models/prakarsa_list_model.dart';

class ItemTablePrakarsa extends StatefulWidget {
  final bool isLast;
  final PrakarsaListModel prakarsaData;
  const ItemTablePrakarsa({
    Key? key,
    required this.prakarsaData,
    required this.isLast,
  }) : super(key: key);

  @override
  State<ItemTablePrakarsa> createState() => _ItemTablePrakarsaState();
}

class _ItemTablePrakarsaState extends State<ItemTablePrakarsa> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    var data = widget.prakarsaData;

    return MouseRegion(
      onEnter: (event) => setState(() => isHovering = true),
      onExit: (event) => setState(() => isHovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isHovering ? CustomColor.lightGrey : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: widget.isLast ? Colors.white : CustomColor.darkGrey,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            item(data.titlePipeline ?? '-', false),
            item(RupiahFormatter.format(data.loanAmount ?? '-'), true),
            item(
              DateStringFormatter.forPrakarsaDate(data.submissionDate ?? '-'),
              false,
            ),
            item(
              InitialCodeTableFormatter.getJenisKredit(data.codeTable ?? 0),
              false,
            ),
            item(data.typePipeline ?? '-', false),
            itemStatus(data.statusPrakarsa ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget item(String value, bool isNominal) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          value,
          style: isNominal ? valueNominalStyle : normalStyle,
          textAlign: isNominal ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }

  Widget itemStatus(String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: StatusPengajuanFormatter.getLabelColor(value),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Center(
          child: Text(
            StatusPengajuanFormatter.convertStatus(value),
            style: valueStatusStyle.copyWith(
              color: StatusPengajuanFormatter.getTextColor(value),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
