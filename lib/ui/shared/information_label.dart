import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/text_style_constants.dart';

class InformationLabel extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subTitle;
  final Color borderColor;
  final Color backgroundColor;
  const InformationLabel({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.borderColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: titleStyle14,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                subTitle,
                style: normalStyle.copyWith(
                  color: CustomColor.darkGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
