import 'package:flutter/material.dart';

import '../../application/app/constants/text_style_constants.dart';
import 'thick_light_grey_divider.dart';

class BaseDetailSection extends StatelessWidget {
  final String title;
  final Widget content;
  final bool? isLast;
  const BaseDetailSection({
    super.key,
    required this.title,
    required this.content,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle16,
        ),
        content,
        if (!isLast!)
          const Padding(
            padding: EdgeInsets.only(bottom: 14.0),
            child: ThickLightGreyDivider(
              verticalPadding: 0.0,
            ),
          ),
      ],
    );
  }
}
