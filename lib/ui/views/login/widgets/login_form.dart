import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../application/app/constants/image_constants.dart';
import '../../../../application/helpers/scroll_behaviour_custom.dart';
import '../login_viewmodel.dart';
import 'login_form_section.dart';

class LoginForm extends HookViewModelWidget<LoginViewModel> {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel viewModel) {
    return Expanded(
      flex: 3,
      child: ScrollConfiguration(
        behavior: ScrollBehaviorCustom(),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        ImageConstants.pinangMaxima,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Dashboard RM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const LoginFormSection(),
                  const SizedBox(height: 60),
                  Row(
                    children: const [
                      Icon(
                        Icons.copyright,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          '2022 Pinang Maksima. All right reserved.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
