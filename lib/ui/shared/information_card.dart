import 'package:flutter/material.dart';

import '../../application/app/constants/text_style_constants.dart';
import '../../application/helpers/responsive_helpers.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final String icon;
  final String value;
  final double width;
  const InformationCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.value,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context, width),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle16,
          ),
          const Divider(),
          Row(
            children: [
              Image.asset(
                icon,
                scale: 3,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: titleStyle16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  double getWidth(BuildContext context, double width) {
    if (ResponsiveHelpers.isDesktop(context)) {
      return (width - 68) / 4;
    } else {
      return (width - 60) / 2;
    }
  }
}
