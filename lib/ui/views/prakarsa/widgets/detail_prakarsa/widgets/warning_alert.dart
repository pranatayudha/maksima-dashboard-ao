import 'package:flutter/material.dart';

import '../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../customs/custom_alerts/custom_alert.dart';
import '../../../../../customs/custom_alerts/custom_alert_style.dart';

class WarningAlert extends StatelessWidget {
  final String title;
  final String subtitle;
  const WarningAlert({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: CustomAlert(
        style: CustomAlertStyle.warning,
        child: Row(
          children: [
            const Icon(
              Icons.info_rounded,
              color: CustomColor.warningText,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle14.copyWith(fontFamily: 'Nunito'),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subtitle,
                    style: normalStyle.copyWith(
                      color: CustomColor.darkGrey,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
