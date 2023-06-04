import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../shared/custom_textfield.dart';
import '../form_lkn_viewmodel.dart';

class HasilKunjunganSection extends HookViewModelWidget<FormLKNViewModel> {
  const HasilKunjunganSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLKNViewModel viewModel,
  ) {
    return Column(
      children: [
        CustomTextField(
          textEditingController: viewModel.hasilKunjunganNasabahController,
          label: 'Hasil Kunjungan Nasabah *',
          hintText: 'Ceritakan Hasil Kunjungan Nasabah',
          minLines: 4,
          maxLines: 8,
          verticalContentPadding: 16.0,
          keyboardType: TextInputType.multiline,
          onSave: viewModel.updateHasilKunjunganNasabah,
          onChanged: viewModel.updateHasilKunjunganNasabah,
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Hasil Kunjungan Nasabah',
          ),
        ),
        CustomTextField(
          textEditingController: viewModel.rencanaTindakLanjutController,
          label: 'Rencana Tindak Lanjut *',
          hintText:
              'Masukkan Rencana Tindak Lanjut dari Hasil Kunjungan Nasabah',
          minLines: 4,
          maxLines: 8,
          verticalContentPadding: 16.0,
          keyboardType: TextInputType.multiline,
          onSave: viewModel.updateRencanaTindakLanjut,
          onChanged: viewModel.updateRencanaTindakLanjut,
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Rencana Tindak Lanjut',
          ),
        ),
      ],
    );
  }
}
