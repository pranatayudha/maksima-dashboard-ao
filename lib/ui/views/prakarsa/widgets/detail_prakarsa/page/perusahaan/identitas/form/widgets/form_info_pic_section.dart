import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../form_identitas_perusahaan_viewmodel.dart';

class FormInfoPICSection
    extends HookViewModelWidget<FormIdentitasPerusahaanViewModel> {
  const FormInfoPICSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormIdentitasPerusahaanViewModel viewModel,
  ) {
    return BaseFormSection(
      titleSection: 'Info PIC',
      leftSection: _leftSection(viewModel),
      rightSection: _rightSection(viewModel),
    );
  }

  Widget _leftSection(FormIdentitasPerusahaanViewModel vm) {
    return Column(
      children: [
        _buildNamaPICTerdekat(vm),
        _buildNoHandphone(vm),
      ],
    );
  }

  CustomTextField _buildNamaPICTerdekat(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.namaPICController,
      label: 'Nama PIC *',
      hintText: 'Nama PIC',
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateNamaPICController,
      onChanged: vm.updateNamaPICController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nama PIC',
      ),
    );
  }

  CustomTextField _buildNoHandphone(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.noHandphoneController,
      label: 'Nomor Handphone *',
      prefixText: '+62',
      keyboardType: TextInputType.number,
      onSave: vm.updateNoHandphonePICController,
      onChanged: vm.updateNoHandphonePICController,
      validator: (value) => InputValidators.validateMobileNumber(
        value,
      ),
    );
  }

  Widget _rightSection(FormIdentitasPerusahaanViewModel vm) {
    return Column(
      children: [
        _buildPosisiPIC(vm),
        _buildEmail(vm),
      ],
    );
  }

  PopupMenuButton _buildPosisiPIC(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return PopupMenuButton(
      tooltip: 'Pilih Posisi',
      offset: const Offset(0, 65.0),
      itemBuilder: (BuildContext context) {
        return Common.posisiPIC.map<PopupMenuItem<String>>((value) {
          return PopupMenuItem(value: value, child: Text(value));
        }).toList();
      },
      onSelected: (val) => vm.updatePosisiPIC(val),
      child: CustomTextField(
        textEditingController: vm.posisiPICController,
        label: 'Posisi PIC *',
        hintText: 'Pilih Posisi',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.chevronDown,
        enabled: false,
        fillColor: Colors.white,
      ),
    );
  }

  CustomTextField _buildEmail(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.emailController,
      label: 'Email *',
      hintText: 'Masukkan Email',
      keyboardType: TextInputType.emailAddress,
      onSave: vm.updateEmailController,
      onChanged: vm.updateEmailController,
      validator: (value) => InputValidators.validateEmail(
        value,
      ),
    );
  }
}
