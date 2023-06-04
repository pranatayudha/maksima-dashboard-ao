import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../shared/custom_textfield.dart';
import '../form_lkn_viewmodel.dart';

class FormPejabatSection extends HookViewModelWidget<FormLKNViewModel> {
  const FormPejabatSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLKNViewModel viewModel,
  ) {
    return Column(
      children: [
        BaseFormSection(
          titleSection: 'Pejabat Yang Mendampingi',
          leftSection: _leftSection(viewModel),
          rightSection: _rightSection(viewModel),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: _leftSectionOther(viewModel),
          rightSection: _rightSectionOther(viewModel),
        ),
      ],
    );
  }

  Widget _leftSection(FormLKNViewModel vm) {
    return Column(
      children: [
        _buildNamaPejabat(vm),
        if (vm.jabatanController.text == 'Kadiv Bisnis' ||
            vm.jabatanController.text == 'Wakadiv Bisnis' ||
            vm.jabatanController.text == 'Kabag Bisnis' ||
            vm.jabatanController.text == 'RM Pusat')
          _buildNamaDivisi(vm),
      ],
    );
  }

  Widget _leftSectionOther(FormLKNViewModel vm) {
    return Column(
      children: [
        _buildNamaPejabatLain(vm),
        if (vm.jabatanLainController.text == 'Kadiv Bisnis' ||
            vm.jabatanLainController.text == 'Wakadiv Bisnis' ||
            vm.jabatanLainController.text == 'Kabag Bisnis' ||
            vm.jabatanLainController.text == 'RM Pusat')
          _buildNamaDivisiLain(vm),
      ],
    );
  }

  CustomTextField _buildNamaPejabat(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.namaPejabatController,
      label: 'Nama Pejabat *',
      hintText: 'Masukkan Nama Pejabat',
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateNamaPejabat,
      onChanged: vm.updateNamaPejabat,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nama Pejabat',
      ),
    );
  }

  CustomTextField _buildNamaDivisi(FormLKNViewModel vm) {
    return CustomTextField(
      textEditingController: vm.namaDivisiController,
      label: 'Nama Divisi *',
      hintText: 'Masukkan Nama Divisi',
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateNamaDivisi,
      onChanged: vm.updateNamaDivisi,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nama Divisi',
      ),
    );
  }

  CustomTextField _buildNamaPejabatLain(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.namaPejabatLainController,
      label: 'Nama Pejabat Lain',
      hintText: 'Masukkan Nama Pejabat',
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateNamaPejabatLain,
      onChanged: vm.updateNamaPejabatLain,
    );
  }

  CustomTextField _buildNamaDivisiLain(FormLKNViewModel vm) {
    return CustomTextField(
      textEditingController: vm.namaDivisiLainController,
      label: 'Nama Divisi',
      hintText: 'Masukkan Nama Divisi',
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateNamaDivisiLain,
      onChanged: vm.updateNamaDivisiLain,
    );
  }

  Widget _rightSection(FormLKNViewModel vm) {
    return Column(
      children: [
        _buildJabatan(vm),
      ],
    );
  }

  Widget _rightSectionOther(FormLKNViewModel vm) {
    return Column(
      children: [
        _buildJabatanLain(vm),
      ],
    );
  }

  PopupMenuButton _buildJabatan(
    FormLKNViewModel vm,
  ) {
    return PopupMenuButton(
      tooltip: 'Pilih Jabatan',
      offset: const Offset(0, 65.0),
      itemBuilder: (BuildContext context) {
        return Common.jabatan.map<PopupMenuItem<String>>((value) {
          return PopupMenuItem(value: value, child: Text(value));
        }).toList();
      },
      onSelected: (val) => vm.updateJabatan(val),
      child: CustomTextField(
        textEditingController: vm.jabatanController,
        label: 'Jabatan *',
        hintText: 'Pilih Jabatan',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.chevronDown,
        enabled: false,
        fillColor: Colors.white,
        validator: (value) => InputValidators.validateRequiredField(
          value,
          fieldType: 'Jabatan',
        ),
      ),
    );
  }

  PopupMenuButton _buildJabatanLain(
    FormLKNViewModel vm,
  ) {
    return PopupMenuButton(
      tooltip: 'Pilih Jabatan',
      offset: const Offset(0, 65.0),
      itemBuilder: (BuildContext context) {
        return Common.jabatan.map<PopupMenuItem<String>>((value) {
          return PopupMenuItem(value: value, child: Text(value));
        }).toList();
      },
      onSelected: (val) => vm.updateJabatanLain(val),
      child: CustomTextField(
        textEditingController: vm.jabatanLainController,
        label: 'Jabatan',
        hintText: 'Pilih Jabatan',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.chevronDown,
        enabled: false,
        fillColor: Colors.white,
      ),
    );
  }
}
