import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../shared/div_single_half_section.dart';
import '../../../../../../../../shared/div_two_section.dart';
import '../../../../../../../../shared/upload_file.dart';
import '../form_izin_usaha_viewmodel.dart';

class FormIzinUsahaSection extends HookViewModelWidget<FormIzinUsahaViewModel> {
  const FormIzinUsahaSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormIzinUsahaViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < viewModel.izinUsahaLength; i++) ...[
          BaseFormSingleSection(
            titleSection: 'Izin Usaha ${i + 1}',
            haveAction: i != 0 ? true : false,
            actionText: 'Hapus',
            onPressed: () => viewModel.removeIzinUsaha(i),
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DivTwoSection(
                  leftSection: _buildJenisDokumen(viewModel, i),
                  rightSection: _buildNoDokumen(viewModel, i),
                ),
                DivTwoSection(
                  leftSection: _buildTanggalTerbit(
                    viewModel,
                    context,
                    i,
                  ),
                  rightSection: _buildTempatTerbit(viewModel, i),
                ),
                DivSingleHalfSection(
                  widget: _buildDokumenIzinUsaha(
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

  PopupMenuButton _buildJenisDokumen(
    FormIzinUsahaViewModel vm,
    int i,
  ) {
    return PopupMenuButton(
      tooltip: 'Pilih Jenis Dokumen',
      offset: const Offset(0, 65.0),
      itemBuilder: (BuildContext context) {
        return Common.jenisDokumenIzinUsaha.map<PopupMenuItem<String>>((value) {
          return PopupMenuItem(value: value, child: Text(value));
        }).toList();
      },
      onSelected: (val) => vm.updateJenisDokumenController(
        val,
        i,
      ),
      child: CustomTextField(
        textEditingController: vm.jenisDokumenController[i],
        label: 'Jenis Dokumen *',
        hintText: 'Pilih Jenis Dokumen',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.chevronDown,
        enabled: false,
        fillColor: Colors.white,
        validator: (value) => InputValidators.validateRequiredField(
          value,
          fieldType: 'Jenis Dokumen',
        ),
      ),
    );
  }

  UploadFile _buildDokumenIzinUsaha(
    FormIzinUsahaViewModel vm,
    BuildContext context,
    int i,
  ) {
    return UploadFile(
      label: 'Dokumen Izin Usaha *',
      imageUrl: vm.docUrlPublic[i],
      onTap: () => vm.docUrlPublic[i] == '' || vm.docUrlPublic[i] == null
          ? vm.uploadFileIzinUsaha(context, i, 0)
          : vm.clearFileIzinUsaha(i, 0),
      isLoading: false,
    );
  }

  CustomTextField _buildNoDokumen(
    FormIzinUsahaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.noDokumenController[i],
      label: 'No. Dokumen *',
      hintText: 'Masukkan No. Dokumen',
      maxLength: 30,
      withMaxLength: true,
      onSave: (val) => vm.updateNoDokumenController(val, i),
      onChanged: (val) => vm.updateNoDokumenController(val, i),
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'No. Dokumen',
      ),
    );
  }

  Widget _buildTanggalTerbit(
    FormIzinUsahaViewModel vm,
    BuildContext ctx,
    int i,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          textEditingController: vm.tanggalTerbitController[i],
          label: 'Tanggal Terbit *',
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
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Tanggal Terbit',
          ),
        ),
      ],
    );
  }

  CustomTextField _buildTempatTerbit(
    FormIzinUsahaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.tempatTerbitController[i],
      label: 'Tempat Terbit *',
      hintText: 'Masukkan Tempat Terbit',
      onSave: (val) => vm.updateTempatTerbitController(val, i),
      onChanged: (val) => vm.updateTempatTerbitController(val, i),
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tempat Terbit',
      ),
    );
  }
}
