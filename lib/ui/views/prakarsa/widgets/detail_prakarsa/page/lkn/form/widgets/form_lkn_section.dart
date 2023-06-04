import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../shared/custom_textfield.dart';
import '../form_lkn_viewmodel.dart';

class FormLKNSection extends HookViewModelWidget<FormLKNViewModel> {
  const FormLKNSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLKNViewModel viewModel,
  ) {
    return BaseFormSection(
      titleSection: 'Laporan Kunjungan Nasabah',
      leftSection: _leftSection(viewModel),
      rightSection: _rightSection(viewModel, context),
    );
  }

  Widget _leftSection(FormLKNViewModel vm) {
    return Column(
      children: [
        _buildCbTerdekat(vm),
        _buildJenisProdukPinjaman(vm),
        _buildTujuanKunjunganNasabah(vm),
      ],
    );
  }

  CustomTextField _buildCbTerdekat(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.cbTerdekatController,
      label: 'CB Terdekat *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildJenisProdukPinjaman(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.jenisProdukPinjamanController,
      label: 'Jenis Produk Pinjaman *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTujuanKunjunganNasabah(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.tujuanKunjunganNasabahController,
      label: 'Tujuan Kunjungan Nasabah *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  Widget _rightSection(FormLKNViewModel vm, BuildContext ctx) {
    return Column(
      children: [
        _buildWaktuTempuhLokasiNasabah(vm),
        _buildEstimasiNominalPlafond(vm),
        _buildTanggalKunjunganNasabah(vm, ctx),
      ],
    );
  }

  CustomTextField _buildWaktuTempuhLokasiNasabah(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.waktuTempuhLokasiController,
      label: 'Waktu Tempuh Lokasi Usaha dari Community Branch *',
      hintText: 'Masukkan Waktu Tempuh',
      suffixText: 'Menit',
      keyboardType: TextInputType.number,
      onSave: vm.updateWaktuTempuhLokasiController,
      onChanged: vm.updateWaktuTempuhLokasiController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Waktu Tempuh Lokasi Usaha',
      ),
    );
  }

  CustomTextField _buildEstimasiNominalPlafond(
    FormLKNViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.plafondPengajuanController,
      label: 'Plafond Pengajuan Pinjaman *',
      prefixText: 'Rp. ',
      withThousandsSeparator: true,
      keyboardType: TextInputType.number,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  Widget _buildTanggalKunjunganNasabah(
    FormLKNViewModel vm,
    BuildContext ctx,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          textEditingController: vm.tanggalKunjunganNasabahController,
          label: 'Tanggal Kunjungan Nasabah *',
          hintText: 'Masukkan Tgl. Kunjungan Nasabah',
          withSuffixIcon: true,
          suffixIconImagePath: IconConstants.calendar,
          onTap: () => vm.selecttglKunjunganDebitur(ctx),
          // onTap: () async {
          //   String date = await DateTimePicker.showingDatePicker(ctx);
          //   vm.updateTanggalKunjunganNasabah(date);
          // },
          enabled: false,
          fillColor: Colors.white,
          onSave: vm.updateTanggalKunjunganNasabah,
          validator: (value) => InputValidators.validateRequiredField(
            value,
            fieldType: 'Tanggal Kunjungan Nasabah',
          ),
        ),
      ],
    );
  }
}
