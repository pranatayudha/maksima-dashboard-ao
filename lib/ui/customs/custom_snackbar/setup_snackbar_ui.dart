import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/app/constants/custom_color.dart';
import '../../../application/app/constants/icon_constants.dart';
import '../../../application/enums/snackbar_type.dart';

// ignore: long-method
void setupSnackbarUI() {
  final snackbarService = locator<SnackbarService>();

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackBarType.success,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      backgroundColor: CustomColor.stateSuccess,
      borderRadius: 6.0,
      icon: SvgPicture.asset(IconConstants.circleChecklist),
      isDismissible: false,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackBarType.error,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      backgroundColor: Colors.red,
      borderRadius: 6.0,
      icon: SvgPicture.asset(
        IconConstants.closeCircle,
        color: Colors.white,
      ),
      isDismissible: false,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackBarType.info,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      backgroundColor: CustomColor.primaryOrange,
      borderRadius: 6.0,
      icon: SvgPicture.asset(
        IconConstants.closeCircle,
        color: Colors.white,
      ),
      isDismissible: false,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackBarType.warning,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      backgroundColor: Colors.yellow,
      borderRadius: 6.0,
      icon: SvgPicture.asset(
        IconConstants.infoWarning,
        color: Colors.white,
      ),
      isDismissible: false,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackBarType.errorBottom,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      backgroundColor: Colors.red,
      borderRadius: 6.0,
      icon: SvgPicture.asset(
        IconConstants.infoWarning,
        color: Colors.white,
      ),
      isDismissible: false,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackBarType.successBottom,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      backgroundColor: CustomColor.stateSuccess,
      borderRadius: 6.0,
      icon: SvgPicture.asset(
        IconConstants.icChecklistConfirmation,
        color: Colors.white,
      ),
      isDismissible: false,
    ),
  );
}
