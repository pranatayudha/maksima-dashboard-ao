import 'package:flutter/material.dart';

import 'custom_alert_color.dart';

class CustomAlertStyle {
  final CustomAlertColor? color;
  final BorderRadiusGeometry? borderRadius;

  const CustomAlertStyle({
    this.color,
    this.borderRadius,
  });

  static const CustomAlertStyle primary = CustomAlertStyle(
    color: CustomAlertColor.primary,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  static const CustomAlertStyle secondary = CustomAlertStyle(
    color: CustomAlertColor.secondary,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  static const CustomAlertStyle success = CustomAlertStyle(
    color: CustomAlertColor.success,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  static const CustomAlertStyle danger = CustomAlertStyle(
    color: CustomAlertColor.danger,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  static const CustomAlertStyle warning = CustomAlertStyle(
    color: CustomAlertColor.warning,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  static const CustomAlertStyle info = CustomAlertStyle(
    color: CustomAlertColor.info,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );
}
