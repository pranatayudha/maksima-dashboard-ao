import 'package:flutter/material.dart';

import '../../application/app/constants/text_style_constants.dart';

class CustomDetailPrakarsa extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueTextStyle;
  final String? suffixPath;
  final String? prefixPath;
  const CustomDetailPrakarsa({
    Key? key,
    required this.title,
    required this.value,
    this.valueTextStyle,
    this.suffixPath,
    this.prefixPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleValue,
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (prefixPath != null)
                Image.asset(
                  prefixPath!,
                  scale: 3,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    _getValue(value),
                    style: valueTextStyle ?? valueStyle,
                  ),
                ),
              ),
              if (suffixPath != null)
                Image.asset(
                  suffixPath!,
                  scale: 3,
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _getValue(String value) {
    if (value.isNotEmpty && value != '-') {
      return value;
    } else {
      return '-';
    }
  }
}
