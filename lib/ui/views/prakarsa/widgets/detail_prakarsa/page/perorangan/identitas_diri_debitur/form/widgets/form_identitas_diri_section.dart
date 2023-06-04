import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
// import '../../../../../../../../../shared/location/open_maps.dart';
import '../../../../../../../../../shared/location/open_maps.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../form_identitas_diri_viewmodel.dart';
import 'upload_doc_debitur.dart';

class FormIdentitasDiriSection
    extends HookViewModelWidget<FormIdentitasDiriViewModel> {
  final double width;
  const FormIdentitasDiriSection({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  // ignore: long-method
  Widget buildViewModelWidget(
    BuildContext context,
    FormIdentitasDiriViewModel viewModel,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            BaseFormSection(
              leftSection: _buildJenisKredit(viewModel),
              rightSection: _buildBentukUsaha(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildNamaDebitur(viewModel),
              rightSection: _buildNomorKtpDebitur(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildTanggalID(viewModel),
              rightSection: _buildReligion(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildLastEducation(viewModel),
              rightSection: _buildNomorNPWP(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildTempatLahir(viewModel),
              rightSection: _buildTanggalLahir(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildJenisKelamin(viewModel),
              rightSection: _buildMotherMaiden(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildStatusPerkawinan(viewModel),
              rightSection: _buildJmlTanggungan(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildNomorKK(viewModel),
              rightSection: _buildTanggalKK(viewModel, context),
              isLast: true,
            ),
            if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
                Common.kawin)
              BaseFormSection(
                leftSection: _buildNoAktaNikah(viewModel),
                rightSection: _buildTanggalAkta(viewModel, context),
                isLast: true,
              ),
            if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
                Common.belumKawin)
              BaseFormSection(
                leftSection: _buildNoBelumNikah(viewModel),
                rightSection: _buildTanggalKetBlmNikah(viewModel, context),
                isLast: true,
              ),
            if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
                Common.ceraiHidup)
              BaseFormSection(
                leftSection: _buildNoAktaCerai(viewModel),
                rightSection: _buildTanggalAktaCerai(viewModel, context),
                isLast: true,
              ),
            if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
                Common.ceraiMati)
              BaseFormSection(
                leftSection: _buildNoDeathCertificate(viewModel),
                rightSection: _buildTanggalDeathCertf(viewModel, context),
                isLast: true,
              ),
            _buildTagLocation(width, context, viewModel),
            _buildAlamatKtp(viewModel),
            _buildPostalCode(context, constraints.maxWidth, viewModel),
            BaseFormSection(
              leftSection: _buildProvince(viewModel),
              rightSection: _buildCity(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildDistrict(viewModel),
              rightSection: _buildVillage(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildRT(viewModel),
              rightSection: _buildRW(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildNoHandphone(viewModel),
              rightSection: _buildEmail(viewModel),
              isLast: true,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 14.0),
              child: ThickLightGreyDivider(
                verticalPadding: 0.0,
              ),
            ),
            if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
                Common.kawin) ...[
              BaseFormSection(
                titleSection: 'Identitas Pasangan',
                leftSection: _buildNoKtpPasangan(viewModel),
                rightSection: _buildNamaPasangan(viewModel),
                isLast: true,
              ),
              BaseFormSection(
                leftSection: _buildTempatLahirPasangan(viewModel),
                rightSection: _buildTanggalLahirPasangan(viewModel, context),
                isLast: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 14.0),
                child: ThickLightGreyDivider(
                  verticalPadding: 0.0,
                ),
              ),
            ],
            const UploadDocDebitur(),
          ],
        );
      },
    );
  }

  CustomTextField _buildJenisKredit(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.jenisKreditController,
      label: 'Jenis Kredit *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildBentukUsaha(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.bentukUsahaController,
      label: 'Bentuk Usaha *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNamaDebitur(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.namaDebiturController,
      label: 'Nama Debitur Sesuai KTP *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNomorKtpDebitur(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noKtpDebiturController,
      label: 'Nomor KTP Debitur *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildJenisKelamin(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.jenisKelaminController,
      label: 'Jenis Kelamin *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTanggalLahir(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tanggalLahirController,
      label: 'Tanggal Lahir *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNomorKK(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.nomorKKController,
      label: 'Nomor KK *',
      hintText: 'Masukkan Nomor KK',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateKTPNumber(
        value,
        fieldType: 'Nomor KK',
      ),
    );
  }

  CustomTextField _buildNoAktaNikah(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noAktaNikahController,
      label: 'No. Akta Nikah *',
      hintText: 'Masukkan No. Akta Nikah',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nomor Akta Nikah',
      ),
    );
  }

  CustomTextField _buildNoHandphone(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.phoneNumController,
      label: 'No. Handphone  *',
      hintText: 'Masukkan No. Handphone',
      enabled: true,
      prefixText: '+62',
      fillColor: Colors.white,
      keyboardType: TextInputType.number,
      validator: (value) => InputValidators.validateMobileNumber(value),
    );
  }

  CustomTextField _buildNomorNPWP(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.nomorNPWPController,
      label: 'Nomor NPWP *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTempatLahir(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tempatLahirController,
      label: 'Tempat Lahir *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildStatusPerkawinan(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.statusPerkawinanController,
      label: 'Status Perkawinan *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTanggalKK(
    FormIdentitasDiriViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tanggalKKController,
      label: 'Tanggal KK *',
      hintText: 'Masukkan Tanggal Terbit KK',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      onTap: () async {
        String date = await DateTimePicker.showingDatePicker(context);
        viewModel.tanggalKKController.text = date;
      },
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Terbit KK',
      ),
    );
  }

  CustomTextField _buildTanggalAkta(
    FormIdentitasDiriViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tglAktaNikahController,
      label: 'Tanggal Akta Nikah *',
      hintText: 'Masukan Tanggal Akta Nikah',
      enabled: true,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      fillColor: Colors.white,
      onTap: () async {
        String date = await DateTimePicker.showingDatePicker(context);
        viewModel.tglAktaNikahController.text = date;
      },
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Akta Nikah',
      ),
    );
  }

  CustomTextField _buildEmail(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.emailController,
      label: 'Email *',
      hintText: 'Masukan Alamat Email',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateEmail(value),
    );
  }

  Widget _buildAlamatKtp(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.addressController,
        label: 'Detail Alamat Tempat Tinggal  *',
        enabled: false,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Widget _buildPostalCode(
    BuildContext context,
    double maxWidth,
    FormIdentitasDiriViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.postalCodeController,
        label: 'Kode Pos *',
        enabled: false,
        fillColor: Colors.grey.shade100,
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.searchBlack,
        // fillColor: Colors.white,
        // onTap: () => OpenPostalCode().openDialog(
        //   context: context,
        //   width: maxWidth,
        //   data: (data) => viewModel.updatePostalCode(data),
        // ),
      ),
    );
  }

  CustomTextField _buildProvince(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.provinceController,
      label: 'Provinsi *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildCity(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.cityController,
      label: 'Kota *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildDistrict(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.districController,
      label: 'Kecamatan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildVillage(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.villageController,
      label: 'Kelurahan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildRT(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.rtController,
      label: 'RT *',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) =>
          InputValidators.validateRTRW(value, fieldType: 'RT'),
    );
  }

  CustomTextField _buildRW(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.rwController,
      label: 'RW *',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) =>
          InputValidators.validateRTRW(value, fieldType: 'RW'),
    );
  }

  CustomTextField _buildNoKtpPasangan(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noKtpPasanganController,
      label: 'No. KTP Pasangan *',
      hintText: 'Masukan No. KTP Pasangan',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) =>
          InputValidators.validateKTPNumber(value, fieldType: 'KTP Pasangan'),
    );
  }

  CustomTextField _buildNamaPasangan(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.namaPasanganController,
      label: 'Nama Lengkap Pasangan *',
      hintText: 'Masukan Nama Lengkap Pasangan',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateName(
        value,
        fieldType: 'Nama Pasangan',
      ),
    );
  }

  CustomTextField _buildTempatLahirPasangan(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tempatLahirPasanganController,
      label: 'Tempat Lahir Pasangan *',
      hintText: 'Masukan Tempat Lahir Pasangan',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateRequiredField(value),
    );
  }

  CustomTextField _buildTanggalLahirPasangan(
    FormIdentitasDiriViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tanggalLahirPasanganController,
      label: 'Tanggal Lahir Pasangan *',
      hintText: 'Masukan Tanggal Lahir Pasangan',
      enabled: true,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      fillColor: Colors.white,
      onTap: () async {
        String date = await DateTimePicker.showingDatePicker(context);
        viewModel.tanggalLahirPasanganController.text = date;
      },
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Lahir Pasangan',
      ),
    );
  }

  CustomTextField _buildNoAktaCerai(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noAktaCeraiController,
      label: 'No. Akta Cerai *',
      hintText: 'Masukkan No. Akta Cerai',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nomor Akta Cerai',
      ),
    );
  }

  CustomTextField _buildTanggalAktaCerai(
    FormIdentitasDiriViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tglAktaCeraiController,
      label: 'Tanggal Akta Cerai *',
      hintText: 'Masukan Tanggal Akta Cerai',
      enabled: true,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      fillColor: Colors.white,
      onTap: () async {
        String date = await DateTimePicker.showingDatePicker(context);
        viewModel.tglAktaCeraiController.text = date;
      },
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Akta Cerai',
      ),
    );
  }

  CustomTextField _buildNoBelumNikah(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noSuratBelumNikahController,
      label: 'No. Surat Keterangan Belum Menikah *',
      hintText: 'Masukkan No. Surat Keterangan Belum Menikah',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nomor Surat Keterangan Belum Menikah',
      ),
    );
  }

  CustomTextField _buildTanggalKetBlmNikah(
    FormIdentitasDiriViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tanggalSuratBelumNikahController,
      label: 'Tanggal Surat Keterangan Belum Menikah *',
      hintText: 'Masukan Tanggal Surat Keterangan Belum Menikah',
      enabled: true,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      fillColor: Colors.white,
      onTap: () async {
        String date = await DateTimePicker.showingDatePicker(context);
        viewModel.tanggalSuratBelumNikahController.text = date;
      },
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Surat Keterangan Belum Menikah',
      ),
    );
  }

  CustomTextField _buildNoDeathCertificate(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noSuratKematianController,
      label: 'No. Sertifikat Kematian *',
      hintText: 'Masukkan No. Sertifikat Kematian',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Nomor Sertifikat Kematian',
      ),
    );
  }

  CustomTextField _buildTanggalDeathCertf(
    FormIdentitasDiriViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tglSuratKematianController,
      label: 'Tanggal Sertifikat Kematian *',
      hintText: 'Masukan Tanggal Sertifikat Kematian',
      enabled: true,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      fillColor: Colors.white,
      onTap: () async {
        String date = await DateTimePicker.showingDatePicker(context);
        viewModel.tglSuratKematianController.text = date;
      },
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Sertifikat Kematian',
      ),
    );
  }

  CustomTextField _buildTanggalID(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tglTerbitKtpController,
      label: 'Tanggal ID Terbit *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildReligion(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.religionController,
      label: 'Agama *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildLastEducation(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.lasatEducationController,
      label: 'Pendidikan Terakhir *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildMotherMaiden(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.motherMaidController,
      label: 'Nama Gadis Ibu Kandung Debitur *',
      hintText: 'Masukkan Nama Lengkap Ibu Kandung',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) => InputValidators.validateName(
        value,
        fieldType: 'Nama Lengkap Ibu Kandung',
      ),
    );
  }

  CustomTextField _buildJmlTanggungan(
    FormIdentitasDiriViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.numberOfDependentsController,
      label: 'Jumlah Tanggungan *',
      hintText: 'Masukkan Jumlah Tanggungan',
      enabled: true,
      fillColor: Colors.white,
      keyboardType: TextInputType.number,
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Jumlah Tanggungan',
      ),
    );
  }

  Widget _buildTagLocation(
    double width,
    BuildContext context,
    FormIdentitasDiriViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.tagLocationNameController,
        label: 'Tag Location Alamat *',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.location,
        enabled: false,
        fillColor: Colors.grey.shade100,
        onTap: () => OpenMaps().openGetTagLoc(
          context: context,
          width: width,
          addressInfo: (data) => viewModel.updateTagloc(data),
        ),
      ),
    );
  }
}
