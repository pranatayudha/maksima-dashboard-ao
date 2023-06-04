import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../application/app/constants/custom_color.dart';
import '../../../customs/custom_alerts/custom_alert.dart';
import '../../../customs/custom_alerts/custom_alert_style.dart';
import '../../../shared/custom_button.dart';
import '../login_viewmodel.dart';

class LoginFormSection extends HookViewModelWidget<LoginViewModel> {
  const LoginFormSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: viewModel.autoValidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat Datang!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Masuk dengan PN dan Password Anda',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: viewModel.messageError != '',
            child: Column(
              children: [
                CustomAlert(
                  closeButton: true,
                  onClose: viewModel.clearMessageError,
                  style: CustomAlertStyle.danger,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.remove_circle,
                        color: CustomColor.primaryRed,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          viewModel.messageError,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          personalNumberTextField(viewModel),
          const SizedBox(height: 20),
          passwordTextField(context, viewModel),
          const SizedBox(height: 20),
          CustomButton(
            label: 'MASUK',
            onPressed: viewModel.anyFieldFilled()
                ? () {
                    viewModel.validateInputs();
                  }
                : null,
            isBusy: viewModel.isBusy,
            height: 50,
            radius: 6,
          ),
        ],
      ),
    );
  }

  Column personalNumberTextField(LoginViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Number',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 400,
          child: TextFormField(
            controller: viewModel.personalNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: 'Masukan Personal Number',
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: viewModel.messageError == ''
                      ? Colors.black54
                      : Colors.red,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Masukan Personal Number';
              }

              return null;
            },
            onSaved: (val) => viewModel.savePersonalNumber(val!),
            onChanged: (val) => viewModel.savePersonalNumber(val),
          ),
        ),
      ],
    );
  }

  Column passwordTextField(BuildContext context, LoginViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 400,
          child: TextFormField(
            controller: viewModel.passwordController,
            keyboardType: TextInputType.text,
            obscureText: viewModel.isObscured,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: 'Masukan Password',
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                onPressed: viewModel.toggleShowPassword,
                icon: Icon(
                  viewModel.isObscured
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                iconSize: 16,
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: viewModel.messageError == ''
                      ? Colors.black54
                      : Colors.red,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Masukan Password';
              }

              return null;
            },
            onSaved: (val) => viewModel.savePassword(val!),
            onChanged: (val) => viewModel.savePassword(val),
          ),
        ),
      ],
    );
  }
}
