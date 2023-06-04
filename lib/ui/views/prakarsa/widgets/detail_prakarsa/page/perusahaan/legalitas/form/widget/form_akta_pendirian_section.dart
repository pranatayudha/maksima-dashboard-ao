import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/div_single_half_section.dart';
import '../../../../../../../../../shared/div_two_section.dart';
import '../form_legalitas_usaha_viewmodel.dart';

class FormAktaPendirianSection
    extends HookViewModelWidget<FormLegalitasUsahaViewModel> {
  const FormAktaPendirianSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLegalitasUsahaViewModel viewModel,
  ) {
    return BaseFormSingleSection(
      titleSection: 'Akta Pendirian',
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DivTwoSection(
            leftSection: _buildNoAktaPendirian(viewModel),
            rightSection: _buildTanggalAktaPendirian(viewModel),
          ),
          DivSingleHalfSection(
            widget: _buildTempatAktaPendirian(viewModel),
          ),
          DivTwoSection(
            leftSection: _buildNamaNotaris(viewModel),
            rightSection: _buildTempatKedudukanNotaris(viewModel),
          ),
          DivTwoSection(
            leftSection: _buildNoSKKumhamPendirian(viewModel),
            rightSection: _buildTanggalSKKumhamPendirian(viewModel, context),
          ),
        ],
      ),
    );
  }

  CustomTextField _buildNoAktaPendirian(
    FormLegalitasUsahaViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.noAktaPendirianController,
      label: 'No. Akta Pendirian *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTanggalAktaPendirian(
    FormLegalitasUsahaViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.tanggalAktaPendirianController,
      label: 'Tanggal Akta Pendirian *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTempatAktaPendirian(
    FormLegalitasUsahaViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.tempatAktaPendirianController,
      label: 'Tempat Akta Pendirian *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNamaNotaris(
    FormLegalitasUsahaViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.namaNotarisController,
      label: 'Nama Notaris *',
      hintText: 'Masukkan Nama Notaris',
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateNamaNotarisController,
      onChanged: vm.updateNamaNotarisController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nama Notaris',
      ),
    );
  }

  CustomTextField _buildTempatKedudukanNotaris(
    FormLegalitasUsahaViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.tempatKedudukanNotarisController,
      label: 'Tempat Kedudukan Notaris *',
      hintText: 'Masukkan Tempat Kedudukan Notaris',
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onSave: vm.updateTempatKedudukanNotarisController,
      onChanged: vm.updateTempatKedudukanNotarisController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tempat Kedudukan Notaris',
      ),
    );
  }

  CustomTextField _buildNoSKKumhamPendirian(
    FormLegalitasUsahaViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.noSKKumhamPendirianController,
      label: 'No. SK Kumham Pendirian *',
      hintText: 'Masukkan No. SK Kumham',
      onSave: vm.updateNoSKKumhamPendirianController,
      onChanged: vm.updateNoSKKumhamPendirianController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'No. SK Kumham',
      ),
    );
  }

  Widget _buildTanggalSKKumhamPendirian(
    FormLegalitasUsahaViewModel vm,
    BuildContext ctx,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          textEditingController: vm.tanggalSKKumhamPendirianController,
          label: 'Tanggal SK Kumham Pendirian *',
          hintText: 'DD/MM/YYYY',
          withSuffixIcon: true,
          suffixIconImagePath: IconConstants.calendar,
          onTap: () async {
            String date = await DateTimePicker.showingDatePicker(ctx);
            vm.updateTanggalSKKumhamPendirianController(date);
          },
          enabled: true,
          fillColor: Colors.white,
          onSave: vm.updateTanggalSKKumhamPendirianController,
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Tanggal SK Kumham Pendirian',
          ),
        ),
      ],
    );
  }
}
