import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../../shared/custom_textfield.dart';
import '../form_agunan_tanah_bangunan_viewmodel.dart';

class BatasAgunanSection extends HookViewModelWidget<FormAgunanTanahBangunanViewModel> {
  const BatasAgunanSection({super.key});

  @override
  Widget buildViewModelWidget(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return BaseFromLayout(
      title: 'Batas Agunan',
      subtitle: 'Keterangan batas agunan dari debitur',
      rightSection: _buildBatasAgunan(viewModel),
    );
  }

  Widget _buildBatasAgunan(FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'Batas Barat',
            enabled: true,
            hintText: 'Masukkan Batas Barat Agunan',
            textEditingController: viewModel.batasBaratController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Batas Barat',
            ),
          ),
          rightSection: CustomTextField(
            label: 'Batas Utara',
            enabled: true,
            hintText: 'Masukkan Batas Utara Agunan',
            textEditingController: viewModel.batasUtaraController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Batas Utara',
            ),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'Batas Timur',
            enabled: true,
            hintText: 'Masukkan Batas Timur Agunan',
            textEditingController: viewModel.batasTimurController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Batas Timur',
            ),
          ),
          rightSection: CustomTextField(
            label: 'Batas Selatan',
            enabled: true,
            hintText: 'Masukkan Batas Selatan Agunan',
            textEditingController: viewModel.batasSelatanController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Batas Selatan',
            ),
          ),
          isLast: true,
        ),
      ],
    );
  }
}
