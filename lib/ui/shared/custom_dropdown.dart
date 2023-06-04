import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/icon_constants.dart';
import '../../application/app/constants/text_style_constants.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> listData;
  final String hintText;
  final TextEditingController selectedValue;
  final Function? onChanged;
  const CustomDropDown({
    Key? key,
    required this.listData,
    required this.hintText,
    required this.selectedValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? onSelected;

  @override
  void initState() {
    if (widget.selectedValue.text.isNotEmpty) {
      onSelected = widget.selectedValue.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      focusColor: Colors.white,
      value: onSelected,
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      icon: Image.asset(
        IconConstants.chevronDown,
        scale: 3,
      ),
      isExpanded: true,
      items: widget.listData.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: FittedBox(
            child: Text(
              value,
              style: normalStyle,
            ),
          ),
        );
      }).toList(),
      hint: FittedBox(
        child: Text(
          widget.hintText,
          style: normalStyle.copyWith(color: CustomColor.darkGrey),
        ),
      ),
      onChanged: (value) {
        onSelected = value;
        widget.selectedValue.text = value ?? '';
        widget.onChanged!(value);
      },
    );
  }
}
