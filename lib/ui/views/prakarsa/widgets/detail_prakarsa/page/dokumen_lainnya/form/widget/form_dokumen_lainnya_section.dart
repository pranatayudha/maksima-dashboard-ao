import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../shared/div_single_section.dart';
import '../../../../../../../../shared/div_two_section.dart';
import '../../../../../../../../shared/upload_file.dart';
import '../form_dokumen_lainnya_viewmodel.dart';

class FormDokumenLainnyaSection
    extends HookViewModelWidget<FormDokumenLainnyaViewModel> {
  const FormDokumenLainnyaSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormDokumenLainnyaViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < viewModel.dokumenLainnyaLength; i++) ...[
          BaseFormSingleSection(
            titleSection: 'Dokumen ${i + 1}',
            haveAction: i != 0 ? true : false,
            actionText: 'Hapus',
            onPressed: () => viewModel.removeDokumenLainnya(i),
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DivSingleSection(
                  widget: _buildNamaDokumen(viewModel, i),
                ),
                DivSingleSection(
                  widget: _buildDokumenLainnya(
                    viewModel,
                    context,
                    i,
                  ),
                ),
                DivTwoSection(
                  leftSection: _buildNoDokumen(viewModel, i),
                  rightSection: _buildTanggalTerbit(
                    viewModel,
                    context,
                    i,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  CustomTextField _buildNamaDokumen(
    FormDokumenLainnyaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.namaDokumenController[i],
      label: 'Nama Dokumen *',
      hintText: 'Masukkan Nama Dokumen',
      onSave: (val) => vm.updateNamaDokumenController(val, i),
      onChanged: (val) => vm.updateNamaDokumenController(val, i),
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nama Dokumen',
      ),
    );
  }

  UploadFile _buildDokumenLainnya(
    FormDokumenLainnyaViewModel vm,
    BuildContext context,
    int i,
  ) {
    return UploadFile(
      label: 'Dokumen Usaha Lainnya *',
      imageUrl: vm.docUrlPublic[i],
      onTap: () => vm.docUrlPublic[i] == '' || vm.docUrlPublic[i] == null
          ? vm.uploadFileDokumenLainnya(context, i, 0)
          : vm.clearFileDokumenLainnya(i, 0),
      isLoading: false,
    );
  }

  CustomTextField _buildNoDokumen(
    FormDokumenLainnyaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.noDokumenController[i],
      label: 'No. Dokumen',
      hintText: 'Masukkan No. Dokumen',
      maxLength: 30,
      withMaxLength: true,
      onSave: (val) => vm.updateNoDokumenController(val, i),
      onChanged: (val) => vm.updateNoDokumenController(val, i),
    );
  }

  Widget _buildTanggalTerbit(
    FormDokumenLainnyaViewModel vm,
    BuildContext ctx,
    int i,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          textEditingController: vm.tanggalTerbitController[i],
          label: 'Tanggal Terbit',
          hintText: 'Masukkan Tanggal Terbit',
          withSuffixIcon: true,
          suffixIconImagePath: IconConstants.calendar,
          onTap: () async {
            String date = await DateTimePicker.showingDatePicker(ctx);
            vm.updateTanggalTerbitController(
              date,
              i,
            );
          },
          enabled: true,
          fillColor: Colors.white,
          onSave: (val) => vm.updateTanggalTerbitController(
            val,
            i,
          ),
        ),
      ],
    );
  }
}
