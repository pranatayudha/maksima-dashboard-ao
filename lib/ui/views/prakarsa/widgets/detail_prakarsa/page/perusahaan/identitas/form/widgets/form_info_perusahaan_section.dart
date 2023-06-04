import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/div_single_section.dart';
import '../../../../../../../../../shared/div_two_section.dart';
import '../../../../../../../../../shared/location/open_maps.dart';
import '../form_identitas_perusahaan_viewmodel.dart';

class FormInfoPerusahaanSection
    extends HookViewModelWidget<FormIdentitasPerusahaanViewModel> {
  final double width;
  const FormInfoPerusahaanSection({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormIdentitasPerusahaanViewModel viewModel,
  ) {
    return BaseFormSingleSection(
      titleSection: 'Informasi Perusahaan',
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DivTwoSection(
            leftSection: _buildJenisKredit(viewModel),
            rightSection: _buildBentukUsaha(viewModel),
          ),
          DivSingleSection(widget: _buildBadanUsaha(viewModel)),
          DivTwoSection(
            leftSection: _buildNamaPerusahaan(viewModel),
            rightSection: _buildNpwpPerusahaan(viewModel),
          ),
          DivTwoSection(
            leftSection: _buildSektorEkonomi(viewModel),
            rightSection: _buildSubSektorEkonomi(viewModel),
          ),
          DivSingleSection(
            widget: _buildTagLocation(context, width, viewModel),
          ),
          DivSingleSection(
            widget: _buildAlamatUsaha(viewModel),
          ),
          DivSingleSection(
            widget: _buildKodePos(context, width, viewModel),
          ),
          DivTwoSection(
            leftSection: _buildProvinsi(viewModel),
            rightSection: _buildKota(viewModel),
          ),
          DivTwoSection(
            leftSection: _buildKecamatan(viewModel),
            rightSection: _buildKelurahan(viewModel),
          ),
          DivTwoSection(
            leftSection: _buildRT(viewModel),
            rightSection: _buildRW(viewModel),
          ),
          DivTwoSection(
            leftSection: _buildTotalNominalSaham(viewModel),
            rightSection: _buildTotalLembarSaham(viewModel),
          ),
        ],
      ),
    );
  }

  CustomTextField _buildJenisKredit(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.jenisKreditController,
      label: 'Jenis Kredit *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildBentukUsaha(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.bentukUsahaController,
      label: 'Bentuk Usaha *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildBadanUsaha(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.badanUsahaController,
      label: 'Badan Usaha Berbadan Hukum *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNamaPerusahaan(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.namaPerusahaanController,
      label: 'Nama Perusahaan *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNpwpPerusahaan(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.npwpPerusahaanController,
      label: 'NPWP Perusahaan *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildSektorEkonomi(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.sektorEkonomiController,
      label: 'Sektor Ekonomi *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildSubSektorEkonomi(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.subSektorEkonomiController,
      label: 'Sub Sektor Ekonomi *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTagLocation(
    BuildContext context,
    double width,
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.tagLocationController,
      label: 'Tag Location Alamat Perusahaan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.location,
      enabled: false,
      fillColor: Colors.grey.shade100,
      onTap: () => OpenMaps().openGetTagLoc(
        context: context,
        width: width,
        addressInfo: (data) => vm.updateTagloc(data),
      ),
    );
  }

  CustomTextField _buildAlamatUsaha(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.alamatUsahaController,
      label: 'Alamat Usaha *',
      minLines: 4,
      maxLines: 8,
      verticalContentPadding: 16.0,
      keyboardType: TextInputType.multiline,
      onSave: vm.updateAlamatUsahaController,
      onChanged: vm.updateAlamatUsahaController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Alamat Usaha',
      ),
    );
  }

  CustomTextField _buildKodePos(
    BuildContext context,
    double maxWidth,
    FormIdentitasPerusahaanViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.kodePosController,
      label: 'Kode Pos *',
      enabled: false,
      fillColor: Colors.grey.shade100,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.searchBlack,
      // onTap: () => OpenPostalCode().openDialog(
      //   context: context,
      //   width: maxWidth,
      //   data: (data) => viewModel.updatePostalCode(data),
      // ),
    );
  }

  CustomTextField _buildProvinsi(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.provinsiController,
      label: 'Provinsi *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildKota(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.kotaController,
      label: 'Kota *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildKecamatan(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.kecamatanController,
      label: 'Kecamatan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildKelurahan(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.kelurahanController,
      label: 'Kelurahan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildRT(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.rtController,
      label: 'RT *',
      hintText: 'Masukkan RT',
      keyboardType: TextInputType.number,
      onSave: vm.updateRTController,
      onChanged: vm.updateRTController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'RT',
      ),
    );
  }

  CustomTextField _buildRW(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.rwController,
      label: 'RW *',
      hintText: 'Masukkan RW',
      keyboardType: TextInputType.number,
      onSave: vm.updateRWController,
      onChanged: vm.updateRWController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'RW',
      ),
    );
  }

  CustomTextField _buildTotalNominalSaham(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.totalNominalSahamController,
      label: 'Total Nominal Saham Perusahaan *',
      hintText: 'Masukkan Jumlah Nominal Saham',
      prefixText: 'Rp. ',
      withThousandsSeparator: true,
      keyboardType: TextInputType.number,
      onSave: vm.updateTotalNominalSahamController,
      onChanged: vm.updateTotalNominalSahamController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Jumlah Nominal Saham',
      ),
    );
  }

  CustomTextField _buildTotalLembarSaham(
    FormIdentitasPerusahaanViewModel vm,
  ) {
    return CustomTextField(
      textEditingController: vm.totalLembarSahamController,
      label: 'Total Lembar Saham Perusahaan *',
      hintText: 'Masukkan Total Lembar Saham',
      keyboardType: TextInputType.number,
      onSave: vm.updateTotalLembarSahamController,
      onChanged: vm.updateTotalLembarSahamController,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Total Lembar Saham',
      ),
    );
  }
}
