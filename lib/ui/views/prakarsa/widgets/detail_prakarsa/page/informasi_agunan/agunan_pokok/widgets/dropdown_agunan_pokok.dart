import 'package:flutter/material.dart';

import '../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../shared/custom_dropdown.dart';

class DropdownAgunan extends StatefulWidget {
  final Function(String val)? onSelected;
  final TextEditingController selectedValue;
  const DropdownAgunan({
    Key? key,
    this.onSelected,
    required this.selectedValue,
  }) : super(key: key);

  @override
  State<DropdownAgunan> createState() => _DropdownAgunanState();
}

class _DropdownAgunanState extends State<DropdownAgunan> {
  @override
  Widget build(BuildContext context) {
    return BaseFromLayout(
      title: 'Jenis Agunan',
      subtitle: 'Piutang / Persediaan',
      rightSection: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jenis Agunan Pokok',
            style: titleValue,
          ),
          const SizedBox(
            height: 4,
          ),
          CustomDropDown(
            listData: const [
              'Piutang',
              'Persediaan',
            ],
            hintText: 'Pilih Jenis Agunan Pokok',
            selectedValue: widget.selectedValue,
            onChanged: widget.onSelected,
          ),
        ],
      ),
    );
  }
}
