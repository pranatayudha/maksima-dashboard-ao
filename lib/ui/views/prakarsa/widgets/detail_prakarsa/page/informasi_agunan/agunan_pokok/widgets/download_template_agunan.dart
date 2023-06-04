import 'package:flutter/material.dart';

import '../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../shared/styles.dart';

class DownloadTemplateAgunan extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  const DownloadTemplateAgunan({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tsHeading10,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    subtitle,
                    style: tsHeading11.copyWith(
                      color: CustomColor.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 120,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                border: Border.all(color: CustomColor.primaryBlue),
              ),
              child: Center(
                child: Image.asset(
                  IconConstants.download,
                  scale: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
