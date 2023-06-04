import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../../shared/custom_textfield.dart';
import '../form_agunan_tanah_bangunan_viewmodel.dart';

class InfoUmumAgunanSection
    extends HookViewModelWidget<FormAgunanTanahBangunanViewModel> {
  const InfoUmumAgunanSection({super.key});

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormAgunanTanahBangunanViewModel viewModel,
  ) {
    return BaseFromLayout(
      title: 'Informasi Umum Agunan',
      subtitle: 'Informasi umum dan status kepemilikan Agunan',
      rightSection: _buildInfoAgunanUmum(viewModel),
    );
  }

  // ignore: long-method
  Widget _buildInfoAgunanUmum(FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        BaseFormSection(
          leftSection: PopupMenuButton(
            tooltip: 'Pilih Status Kepemilikan',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.statusKepemilikanList
                  .map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedStatusKepemilikan,
            child: CustomTextField(
              textEditingController: viewModel.statusKepemilikanController,
              label: 'Status Kepemilikan',
              hintText: 'Pilih Status Kepemilikan',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Status Kepemilikan',
              ),
            ),
          ),
          rightSection: PopupMenuButton(
            tooltip: 'Pilih Jenis Pengikatan',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.jenisPengikatanList
                  .map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedJenisPengikatan,
            child: CustomTextField(
              textEditingController: viewModel.jenisPengikatanController,
              label: 'Jenis Pengikatan',
              hintText: 'Pilih Jenis Pengikatan',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Jenis Pengikatan',
              ),
            ),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'Luas Tanah',
            enabled: true,
            hintText: '000',
            withSuffixIcon: true,
            suffixIconImagePath: IconConstants.meter,
            textEditingController: viewModel.luasTanahController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Luas Tanah',
            ),
          ),
          rightSection: CustomTextField(
            label: 'Luas Bangunan',
            enabled: true,
            hintText: '000',
            withSuffixIcon: true,
            suffixIconImagePath: IconConstants.meter,
            textEditingController: viewModel.luasBangunanController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Luas Bangunan',
            ),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: PopupMenuButton(
            tooltip: 'Pilih Permukaan Tanah',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.permukaanTanahList
                  .map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedPermukaanTanah,
            child: CustomTextField(
              textEditingController: viewModel.permukaanTanahController,
              label: 'Permukaan Tanah',
              hintText: 'Pilih Permukaan Tanah',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Permukaan Tanah',
              ),
            ),
          ),
          rightSection: PopupMenuButton(
            tooltip: 'Pilih Bentuk Tanah',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.bentukTanahList.map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedBentukTanah,
            child: CustomTextField(
              textEditingController: viewModel.bentukTanahController,
              label: 'Bentuk Tanah',
              hintText: 'Pilih Bentuk Tanah',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Bentuk Tanah',
              ),
            ),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: PopupMenuButton(
            tooltip: 'Pilih Bentuk Bangunan',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.bentukBangunanList
                  .map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedBentukBangunan,
            child: CustomTextField(
              textEditingController: viewModel.bentukBangunanController,
              label: 'Bentuk Bangunan',
              hintText: 'Pilih Bentuk Bangunan',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Bentuk Bangunan',
              ),
            ),
          ),
          rightSection: PopupMenuButton(
            tooltip: 'Pilih Peruntukkan Tanah & Bangunan',
            offset: const Offset(0, 65.0),
            itemBuilder: (BuildContext context) {
              return Common.peruntukkanZoningList
                  .map<PopupMenuItem<String>>((value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
            onSelected: viewModel.onChangedPeruntukkanZoning,
            child: CustomTextField(
              textEditingController: viewModel.peruntukkanZoningController,
              label: 'Peruntukkan (Zoning)',
              hintText: 'Pilih Peruntukkan Tanah & Bangunan',
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.chevronDown,
              enabled: false,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Peruntukkan (Zoning)',
              ),
            ),
          ),
          isLast: true,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomTextField(
            label: 'Spesifikasi Bangunan',
            enabled: true,
            minLines: 2,
            verticalContentPadding: 16,
            hintText: 'Masukkan Uraian Bangunan',
            textEditingController: viewModel.spesifikasiBangunanController,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Spesifikasi Bangunan',
            ),
          ),
        ),
      ],
    );
  }
}
