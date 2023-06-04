import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../../shared/custom_dropdown.dart';
import '../../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/divider_form.dart';
import 'form_agunan_tanah_bangunan_viewmodel.dart';
import 'widgets/batas_agunan_section.dart';
import 'widgets/dokumen_agunan_section.dart';
import 'widgets/foto_agunan_section.dart';
import 'widgets/info_umum_agunan_section.dart';
import 'widgets/legalitas_agunan_section.dart';
import 'widgets/lokasi_agunan_section.dart';

class FormAgunanTanahBangunanView extends ViewModelBuilderWidget<FormAgunanTanahBangunanViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double width;
  final Function(dynamic) agunanId;
  final String id;

  const FormAgunanTanahBangunanView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
    required this.agunanId,
    required this.id,
  });

  @override
  FormAgunanTanahBangunanViewModel viewModelBuilder(BuildContext context) => FormAgunanTanahBangunanViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        id: id,
        agunanId: agunanId,
      );

  @override
  Widget builder(BuildContext context, FormAgunanTanahBangunanViewModel viewModel, Widget? child) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: viewModel.autoValidateMode,
      child: ListView(
        shrinkWrap: true,
        children: [
          BaseFromLayout(
            title: 'Penilaian Agunan',
            subtitle: 'Penilaian Internal / KJPP Rekanan / KJPP Non Rekanan',
            rightSection: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Jenis Agunan Tambahan',
                    initialValue: 'Tanah & Bangunan',
                    withSuffixIcon: true,
                    suffixIconImagePath: IconConstants.chevronDown,
                    enabled: false,
                    fillColor: Colors.grey.shade100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Penilaian',
                        style: titleValue,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomDropDown(
                        listData: Common.jenisPenilaianList,
                        hintText: 'Pilih Jenis Penilaian',
                        selectedValue: viewModel.jenisPenilaianController,
                        onChanged: viewModel.onChangedJenisPenilaian,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (viewModel.jenisPenilaianController.text.isNotEmpty) _buildFormPenilaianView(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildFormPenilaianView(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        if (Common.jenisPenilaianKJPPList.contains(viewModel.jenisPenilaianController.text))
          _buildPenilaianKJPP(context, viewModel),
        if (Common.jenisPenilaianKJPPNonList.contains(viewModel.jenisPenilaianController.text))
          _buildPenilaianKJPPNon(context, viewModel),
        const DividerForm(),
        const InfoUmumAgunanSection(),
        const DividerForm(),
        const BatasAgunanSection(),
        const DividerForm(),
        LokasiAgunanSection(width: width),
        const DividerForm(),
        const LegalitasAgunanSection(),
        const DividerForm(),
        const DokumenAgunanSection(),
        const DividerForm(),
        FotoAgunanSection(width: width),
        const DividerForm(),
        BaseFormSection(
          leftSection: const SizedBox.shrink(),
          rightSection: BaseFormSection(
            leftSection: CustomOutlinedButton(
              label: 'Simpan Draft',
              onPressed: viewModel.onPressedSimpanDraft,
            ),
            rightSection: CustomButton(
              label: 'Lanjutkan',
              onPressed: viewModel.onPressedLanjutkan,
              isBusy: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPenilaianKJPP(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return BaseFromLayout(
      rightSection: Column(
        children: [
          BaseFormSection(
            leftSection: (Common.jenisPenilaianKJPPNonList.contains(viewModel.jenisPenilaianController.text))
                ? CustomTextField(
                    label: 'Nama KJPP',
                    hintText: 'Masukkan Nama KJPP',
                    textEditingController: viewModel.nameKJPPController,
                    fillColor: Colors.white,
                    validator: (value) => InputValidators.validateRequiredField(
                      value,
                      fieldType: 'Nama KJPP',
                    ),
                  )
                : PopupMenuButton(
                    tooltip: 'Pilih KJPP Rekanan',
                    offset: const Offset(0, 65.0),
                    itemBuilder: (BuildContext context) {
                      return Common.namaKJJPRekananList.map<PopupMenuItem<String>>((value) {
                        return PopupMenuItem(value: value, child: Text(value));
                      }).toList();
                    },
                    onSelected: viewModel.onSelectedNameKJPP,
                    child: CustomTextField(
                      textEditingController: viewModel.nameKJPPController,
                      label: 'Nama KJPP',
                      hintText: 'Masukkan KJPP Rekanan',
                      withSuffixIcon: true,
                      suffixIconImagePath: IconConstants.chevronDown,
                      enabled: false,
                      fillColor: Colors.white,
                      validator: (value) => InputValidators.validateRequiredField(
                        value,
                        fieldType: 'Nama KJPP Rekanan',
                      ),
                    ),
                  ),
            rightSection: CustomTextField(
              label: 'Nomor Laporan Penilaian',
              hintText: 'Masukkan Nomor Laporan Penilaian',
              textEditingController: viewModel.noLapPenilaianController,
              fillColor: Colors.white,
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Nomor Laporan Penilaian',
              ),
            ),
            isLast: true,
          ),
          BaseFormSection(
            leftSection: CustomTextField(
              label: 'Tanggal Laporan',
              hintText: 'Masukkan Tanggal Laporan',
              textEditingController: viewModel.tglLaporanController,
              fillColor: Colors.white,
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.calendar,
              onTap: () async {
                String date = await DateTimePicker.showingDatePicker(context);
                viewModel.setTanggalLaporan(date);
              },
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Tanggal Laporan',
              ),
            ),
            rightSection: CustomTextField(
              label: 'Tanggal Penilaian',
              hintText: 'Masukkan Tanggal Penilaian',
              textEditingController: viewModel.tglPenilaianController,
              fillColor: Colors.white,
              withSuffixIcon: true,
              suffixIconImagePath: IconConstants.calendar,
              onTap: () async {
                String date = await DateTimePicker.showingDatePicker(context);
                viewModel.setTanggalPenilaian(date);
              },
              validator: (value) => InputValidators.validateRequiredField(
                value,
                fieldType: 'Tanggal Penilaian',
              ),
            ),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPenilaianKJPPNon(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return BaseFromLayout(
      rightSection: BaseFormSection(
        leftSection: CustomTextField(
          label: 'Nomor Persetujuan Izin Prinsip',
          hintText: 'Masukkan Nomor Dokumen',
          textEditingController: viewModel.noPersetujuanIzinController,
          fillColor: Colors.white,
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Nomor Persetujuan Izin Prinsip',
          ),
        ),
        rightSection: CustomTextField(
          label: 'Tanggal Persetjuan Izin Prinsip',
          hintText: 'Masukkan Tanggal Persetujuan',
          textEditingController: viewModel.tglPersetjuanIzinController,
          fillColor: Colors.white,
          withSuffixIcon: true,
          suffixIconImagePath: IconConstants.calendar,
          onTap: () async {
            String date = await DateTimePicker.showingDatePicker(context);
            viewModel.setTglPersetjuanIzin(date);
          },
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Tanggal Persetjuan Izin Prinsip',
          ),
        ),
        isLast: true,
      ),
    );
  }
}
