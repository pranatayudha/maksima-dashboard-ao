import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/image_constants.dart';
import '../../application/app/constants/text_style_constants.dart';
import '../../application/models/header_table_model.dart';
import 'custom_empty_state.dart';

class CustomTable extends StatefulWidget {
  final List<HeaderTableModel> listHeader;
  final List<Widget> listContent;
  final Function(int index) onTap;
  const CustomTable({
    Key? key,
    required this.listHeader,
    required this.listContent,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      // height: MediaQuery.of(context).size.height - 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: CustomColor.lightGrey,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleTableDisburse(widget.listHeader),
          const Divider(
            height: 0,
            thickness: 1,
            color: CustomColor.darkGrey,
          ),
          if (widget.listContent.isEmpty)
            const CustomEmptyState(
              height: 200,
              title: 'Belum Ada Data Prakarsa',
              subTitle: 'Belum ada data debitur yang diprakarsai',
              imageAsset: ImageConstants.emptyList,
            )
          else
            ...List.generate(
              widget.listContent.length,
              (index) => InkWell(
                onTap: () => widget.onTap(index),
                child: widget.listContent[index],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTitleTableDisburse(List<HeaderTableModel> list) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: CustomColor.backGroundTableHeader,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          list.length,
          (index) => _headerTitle(
            list[index].title,
            list[index].onTap,
          ),
        ),
      ),
    );
  }

  Widget _headerTitle(String title, Function()? onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: titleStyle14,
              ),
            ),
            if (onTap != null)
              InkWell(
                onTap: onTap,
                child: const Icon(
                  Icons.sort,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
