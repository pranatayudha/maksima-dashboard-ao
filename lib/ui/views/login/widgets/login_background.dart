import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../application/app/constants/image_constants.dart';
import '../../../../application/helpers/responsive_helpers.dart';
import '../login_viewmodel.dart';

class LoginBackground extends HookViewModelWidget<LoginViewModel> {
  const LoginBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel viewModel) {
    return Visibility(
      visible: !ResponsiveHelpers.isMobile(context) &&
          !ResponsiveHelpers.isTablet(context),
      child: Expanded(
        flex: 6,
        child: Image.asset(
          ImageConstants.backgroundLogin,
          fit: BoxFit.fitWidth,
          height: double.infinity,
        ),
      ),
    );
  }
}
