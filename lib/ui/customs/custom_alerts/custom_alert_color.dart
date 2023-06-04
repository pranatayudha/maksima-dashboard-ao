import 'package:flutter/material.dart';

import '../../../application/app/constants/custom_color.dart';

class CustomAlertColor {
  final Color color;
  final Color backgroundColor;
  final Color borderColor;

  const CustomAlertColor({
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  static const CustomAlertColor primary = CustomAlertColor(
    color: CustomColor.primaryBlue,
    backgroundColor: CustomColor.lightBlue20,
    borderColor: CustomColor.primaryBlue,
  );

  static const CustomAlertColor secondary = CustomAlertColor(
    color: CustomColor.darkGrey,
    backgroundColor: CustomColor.lightGrey,
    borderColor: CustomColor.darkGrey,
  );

  static const CustomAlertColor success = CustomAlertColor(
    color: CustomColor.primaryGreen,
    backgroundColor: CustomColor.lightGreen40,
    borderColor: CustomColor.primaryGreen,
  );

  static const CustomAlertColor danger = CustomAlertColor(
    color: CustomColor.primaryRed,
    backgroundColor: CustomColor.secondaryRed20,
    borderColor: CustomColor.primaryRed,
  );

  static const CustomAlertColor warning = CustomAlertColor(
    color: CustomColor.warningBackLabel,
    backgroundColor: CustomColor.warningBackLabel,
    borderColor: CustomColor.warningText,
  );

  static const CustomAlertColor info = CustomAlertColor(
    color: CustomColor.lightBlue40,
    backgroundColor: CustomColor.lightBlue20,
    borderColor: CustomColor.lightBlue40,
  );
}
