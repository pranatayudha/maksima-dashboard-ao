import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/div_single_half_section.dart';
import '../../../../../../../../../shared/div_two_section.dart';
import '../../../../../../../../../shared/upload_item_button_ritel.dart';
import '../form_legalitas_usaha_viewmodel.dart';

class FormAktaPerubahanTerakhirSection
    extends HookViewModelWidget<FormLegalitasUsahaViewModel> {
  const FormAktaPerubahanTerakhirSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLegalitasUsahaViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < viewModel.aktaPerubahanLength; i++) ...[
          BaseFormSingleSection(
            titleSection: 'Akta Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
            haveAction: i != 0 ? true : false,
            actionText: 'Hapus',
            onPressed: () => viewModel.removeAktaPerubahanLain(i),
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DivTwoSection(
                  leftSection: _buildNoAktaPerubahanTerakhir(viewModel, i),
                  rightSection:
                      _buildTanggalAktaPerubahanTerakhir(viewModel, context, i),
                ),
                DivSingleHalfSection(
                  widget: _buildTempatAktaPerubahanTerakhir(viewModel, i),
                ),
                DivTwoSection(
                  leftSection: _buildNamaNotarisKedua(viewModel, i),
                  rightSection: _buildTempatKedudukanNotarisKedua(viewModel, i),
                ),
                DivTwoSection(
                  leftSection: _buildNoSKKumhamPerubahanTerakhir(viewModel, i),
                  rightSection: _buildTanggalSKKumhamPerubahanTerakhir(
                    viewModel,
                    context,
                    i,
                  ),
                ),
              ],
            ),
          ),
          BaseFormSingleSection(
            titleSection: 'Dokumen',
            isLast: true,
            widget: DivTwoSection(
              leftSection: _aktaPerubahanTerakhirDokumen(
                viewModel,
                context,
                i,
              ),
              rightSection: _skKumhamPerubahanTerakhir(
                viewModel,
                context,
                i,
              ),
            ),
          ),
        ],
      ],
    );
  }

  CustomTextField _buildNoAktaPerubahanTerakhir(
    FormLegalitasUsahaViewModel vm,
    int i,
  ) {
    if (i == 0) {
      return CustomTextField(
        textEditingController: vm.noAktaPerubahanTerakhirController[i],
        label: 'No. Akta Perubahan Terakhir *',
        enabled: false,
        fillColor: Colors.grey.shade100,
      );
    } else {
      return CustomTextField(
        textEditingController: vm.noAktaPerubahanTerakhirController[i],
        label: 'No. Akta Perubahan Lain *',
        hintText: 'Masukkan No. Akta Perubahan Lain',
        keyboardType: TextInputType.number,
        onSave: (val) => vm.updateNoAktaPerubahanTerakhirController(val, i),
        onChanged: (val) => vm.updateNoAktaPerubahanTerakhirController(val, i),
      );
    }
  }

  CustomTextField _buildTanggalAktaPerubahanTerakhir(
    FormLegalitasUsahaViewModel vm,
    BuildContext ctx,
    int i,
  ) {
    if (i == 0) {
      return CustomTextField(
        textEditingController: vm.tanggalAktaPerubahanTerakhirController[i],
        label: 'Tanggal Akta Perubahan Terakhir *',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.calendar,
        enabled: false,
        fillColor: Colors.grey.shade100,
      );
    } else {
      return CustomTextField(
        textEditingController: vm.tanggalAktaPerubahanTerakhirController[i],
        label: 'Tanggal Akta Perubahan Lain *',
        hintText: 'DD/MM/YYYY',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.calendar,
        onTap: () async {
          String date = await DateTimePicker.showingDatePicker(ctx);
          vm.updateTanggalAktaPerubahanTerakhirController(date, i);
        },
        enabled: true,
        fillColor: Colors.white,
        onSave: (val) =>
            vm.updateTanggalAktaPerubahanTerakhirController(val, i),
        validator: (value) => InputValidators.validateRequiredField(
          value,
          fieldType: 'Tanggal Akta Perubahan Lain',
        ),
      );
    }
  }

  CustomTextField _buildTempatAktaPerubahanTerakhir(
    FormLegalitasUsahaViewModel vm,
    int i,
  ) {
    if (i == 0) {
      return CustomTextField(
        textEditingController: vm.tempatAktaPerubahanTerakhirController[i],
        label: 'Tempat Akta Perubahan Terakhir *',
        enabled: false,
        fillColor: Colors.grey.shade100,
      );
    } else {
      return CustomTextField(
        textEditingController: vm.tempatAktaPerubahanTerakhirController[i],
        label: 'Tempat Akta Perubahan Lain *',
        hintText: 'Masukkan Tempat Akta Perubahan Lain',
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        onSave: (val) => vm.updateTempatAktaPerubahanTerakhirController(val, i),
        onChanged: (val) =>
            vm.updateTempatAktaPerubahanTerakhirController(val, i),
      );
    }
  }

  CustomTextField _buildNamaNotarisKedua(
    FormLegalitasUsahaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.namaNotarisKeduaController[i],
      label: 'Nama Notaris *',
      hintText: 'Masukkan Nama Notaris',
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onSave: (val) => vm.updateNamaNotarisKeduaController(val, i),
      onChanged: (val) => vm.updateNamaNotarisKeduaController(val, i),
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nama Notaris',
      ),
    );
  }

  CustomTextField _buildTempatKedudukanNotarisKedua(
    FormLegalitasUsahaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.tempatKedudukanNotarisKeduaController[i],
      label: 'Tempat Kedudukan Notaris *',
      hintText: 'Masukkan Tempat Kedudukan Notaris',
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onSave: (val) => vm.updateTempatKedudukanNotarisKeduaController(val, i),
      onChanged: (val) =>
          vm.updateTempatKedudukanNotarisKeduaController(val, i),
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tempat Kedudukan Notaris',
      ),
    );
  }

  CustomTextField _buildNoSKKumhamPerubahanTerakhir(
    FormLegalitasUsahaViewModel vm,
    int i,
  ) {
    return CustomTextField(
      textEditingController: vm.noSKKumhamPerubahanTerakhirController[i],
      label: 'No. SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'} *',
      hintText:
          'Masukkan No. SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
      onSave: (val) => vm.updateNoSKKumhamPerubahanTerakhirController(val, i),
      onChanged: (val) =>
          vm.updateNoSKKumhamPerubahanTerakhirController(val, i),
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'No. SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
      ),
    );
  }

  Widget _buildTanggalSKKumhamPerubahanTerakhir(
    FormLegalitasUsahaViewModel vm,
    BuildContext ctx,
    int i,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          textEditingController:
              vm.tanggalSKKumhamPerubahanTerakhirController[i],
          label:
              'Tanggal SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'} *',
          hintText: 'DD/MM/YYYY',
          withSuffixIcon: true,
          suffixIconImagePath: IconConstants.calendar,
          onTap: () async {
            String date = await DateTimePicker.showingDatePicker(ctx);
            vm.updateTanggalSKKumhamPerubahanTerakhirController(date, i);
          },
          enabled: true,
          fillColor: Colors.white,
          onSave: (val) =>
              vm.updateTanggalSKKumhamPerubahanTerakhirController(val, i),
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType:
                'Tanggal SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
          ),
        ),
      ],
    );
  }

  UploadItemButtonRitel _aktaPerubahanTerakhirDokumen(
    FormLegalitasUsahaViewModel vm,
    BuildContext context,
    int i,
  ) {
    return UploadItemButtonRitel(
      imageUrl: vm.aktaPerubahanTerakhirUrlPublic[i],
      label: 'Akta Perubahan ${i == 0 ? 'Terakhir' : 'Lain'} *',
      onPressed: vm.aktaPerubahanTerakhirUrlPublic[i] == '' ||
              vm.aktaPerubahanTerakhirUrlPublic[i] == null
          ? () => vm.uploadFilePerubahan(context, i, 0)
          : () => vm.clearFilePerubahan(i, 0),
      errorText: null,
    );
  }

  UploadItemButtonRitel _skKumhamPerubahanTerakhir(
    FormLegalitasUsahaViewModel vm,
    BuildContext context,
    int i,
  ) {
    return UploadItemButtonRitel(
      imageUrl: vm.skKumhamPerubahanTerakhirUrlPublic[i],
      label: 'SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'} *',
      onPressed: vm.skKumhamPerubahanTerakhirUrlPublic[i] == '' ||
              vm.skKumhamPerubahanTerakhirUrlPublic[i] == null
          ? () => vm.uploadFilePerubahan(context, i, 1)
          : () => vm.clearFilePerubahan(i, 1),
      errorText: null,
    );
  }
}
