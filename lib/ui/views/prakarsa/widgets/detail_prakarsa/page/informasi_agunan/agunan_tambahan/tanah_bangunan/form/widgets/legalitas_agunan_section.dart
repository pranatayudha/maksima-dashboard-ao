import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../../shared/custom_textfield.dart';
import '../form_agunan_tanah_bangunan_viewmodel.dart';

class LegalitasAgunanSection
    extends HookViewModelWidget<FormAgunanTanahBangunanViewModel> {
  const LegalitasAgunanSection({super.key});

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormAgunanTanahBangunanViewModel viewModel,
  ) {
    return BaseFromLayout(
      title: 'Legalitas Agunan',
      subtitle: 'Informasi bukti kepemilikan dan nilai jual objek pajak',
      rightSection: _buildLegalitasAgunan(context, viewModel),
    );
  }

  // ignore: long-method
  Widget _buildLegalitasAgunan(
    BuildContext context,
    FormAgunanTanahBangunanViewModel viewModel,
  ) {
    return Column(
      children: [
        BaseFormSection(
          leftSection: PopupMenuButton(
            tooltip: 'Pilih Jenis Sertifikat',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.jenisSertifikatList
                  .map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedjenisSertifikat,
            child: CustomTextField(
              textEditingController: viewModel.jenisSertifikatController,
              label: 'Jenis Setifikat',
              hintText: 'Pilih Jenis Sertifikat',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Jenis Setifikat',
              ),
            ),
          ),
          rightSection: CustomTextField(
            label: 'No. SHM/SHGB/SHGU',
            enabled: true,
            hintText: 'Masukkan No. SHM/SHGB/SHGU',
            textEditingController: viewModel.noJenisSertifikatController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'No. SHM/SHGB/SHGU',
            ),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'Nama Pemilik',
            enabled: true,
            hintText: 'Masukkan Nama Pemilik',
            textEditingController: viewModel.namaPemilikController,
            validator: (value) => InputValidators.validateName(
              value,
              fieldType: 'Nama Pemilik',
            ),
          ),
          rightSection: CustomTextField(
            label: 'Jatuh tempo (apabila SHGB/SHGU/SHMSRS)',
            enabled: true,
            hintText: 'Pilih Jatuh Tempo',
            withSuffixIcon: true,
            suffixIconImagePath: IconConstants.calendar,
            withThousandsSeparator: true,
            textEditingController: viewModel.tglJatuhTempoController,
            onTap: () async {
              String date = await DateTimePicker.showingDatePicker(context);
              viewModel.setTglJatuhTempo(date);
            },
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'No. SPPT (NOP - Nomor Objek Pajak)',
            enabled: true,
            hintText: 'Masukkan No. SPPT (NOP)',
            textEditingController: viewModel.noSPPTNOPController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Nomor Objek Pajak',
            ),
          ),
          rightSection: CustomTextField(
            label: 'NJOP (Nilai Jual Objek Pajak)',
            enabled: true,
            hintText: 'Masukkan Nilai Jual Objek Pajak',
            withPrefixIcon: true,
            prefixIconImagePath: IconConstants.rupiah,
            withThousandsSeparator: true,
            textEditingController: viewModel.njopController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Nilai Jual Objek Pajak',
            ),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'NJOP Tanah / m2',
            enabled: true,
            hintText: 'Masukkan NJOP Tanah / m2',
            withPrefixIcon: true,
            prefixIconImagePath: IconConstants.rupiah,
            withThousandsSeparator: true,
            textEditingController: viewModel.njopTanahPerMeterController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'NJOP Tanah / m2',
            ),
          ),
          rightSection: CustomTextField(
            label: 'NJOP Bangunan / m2',
            enabled: true,
            hintText: 'Masukkan NJOP Bangunan / m2',
            withPrefixIcon: true,
            prefixIconImagePath: IconConstants.rupiah,
            withThousandsSeparator: true,
            textEditingController: viewModel.njopBangunanPerMeterController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'NJOP Bangunan / m2',
            ),
          ),
          isLast: true,
        ),
      ],
    );
  }
}
