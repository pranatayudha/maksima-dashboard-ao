import 'package:flutter/material.dart';

import '../../application/app/constants/text_style_constants.dart';

class DetailPrakarsaItem extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueTextStyle;
  const DetailPrakarsaItem({
    Key? key,
    required this.title,
    required this.value,
    this.valueTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleValue,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          getValue(value),
          style: valueTextStyle ?? valueStyle,
        ),
      ],
    );
  }

  String getValue(String value) {
    if (value.isNotEmpty && value != '-') {
      return value;
    } else {
      return '-';
    }
  }
}
