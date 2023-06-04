import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/helpers/date_time_picker.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../../../../../../../../../shared/postal_code/widgets/open_postal_code.dart';
import '../form_pengurus_viewmodel.dart';
import 'upload_doc_pengurus.dart';

class FormPengurusSection extends HookViewModelWidget<FormPengurusViewModel> {
  const FormPengurusSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormPengurusViewModel viewModel,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            BaseFormSection(
              leftSection: _buildNamaPengurus(viewModel),
              rightSection: _buildPosisiPengurus(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildNomorKtpPengurus(viewModel),
              rightSection: _buildNomorNPWP(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildJenisKelamin(viewModel),
              rightSection: _buildTempatLahir(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildTanggalLahir(viewModel),
              rightSection: viewModel.codeTable == Common.CodeTable.CV
                  ? _buildStatusPerkawinan(viewModel)
                  : _buildNoHandphone(viewModel),
              isLast: true,
            ),
            if (viewModel.codeTable == Common.CodeTable.CV)
              BaseFormSection(
                leftSection: _buildNomorKK(viewModel),
                rightSection: _buildTanggalKK(viewModel, context),
                isLast: true,
              ),
            if (viewModel.dataPengurus.maritalStatus == Common.kawin)
              BaseFormSection(
                leftSection: _buildNoAktaNikah(viewModel),
                rightSection: _buildTanggalAkta(viewModel, context),
                isLast: true,
              ),
            if (viewModel.dataPengurus.maritalStatus == Common.belumKawin)
              BaseFormSection(
                leftSection: _buildNoBelumNikah(viewModel),
                rightSection: _buildTanggalKetBlmNikah(viewModel, context),
                isLast: true,
              ),
            if (viewModel.dataPengurus.maritalStatus == Common.ceraiHidup)
              BaseFormSection(
                leftSection: _buildNoAktaCerai(viewModel),
                rightSection: _buildTanggalAktaCerai(viewModel, context),
                isLast: true,
              ),
            if (viewModel.dataPengurus.maritalStatus == Common.ceraiMati)
              BaseFormSection(
                leftSection: _buildNoDeathCertificate(viewModel),
                rightSection: _buildTanggalDeathCertf(viewModel, context),
                isLast: true,
              ),
            if (viewModel.codeTable == Common.CodeTable.CV)
              BaseFormSection(
                leftSection: _buildNoHandphone(viewModel),
                rightSection: _buildEmail(viewModel),
                isLast: true,
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildEmail(viewModel),
              ),
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
              leftSection: _buildNominalSaham(viewModel),
              rightSection: _buildLembarSaham(viewModel),
              isLast: true,
            ),
            _buildPresentaseSaham(viewModel),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 14.0),
              child: ThickLightGreyDivider(
                verticalPadding: 0.0,
              ),
            ),
            if (viewModel.dataPengurus.maritalStatus == Common.kawin) ...[
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
            const UploadDocPengurus(),
          ],
        );
      },
    );
  }

  CustomTextField _buildNamaPengurus(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.namaPengurusController,
      label: 'Nama Pengurus Sesuai KTP *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNomorKtpPengurus(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noKtpPengurusController,
      label: 'Nomor KTP Pengurus *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildJenisKelamin(
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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

  CustomTextField _buildPosisiPengurus(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.posisiPengurusController,
      label: 'Posisi Pengurus *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNomorNPWP(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.nomorNPWPController,
      label: 'Nomor NPWP *',
      enabled: viewModel.dataPengurus.index != '1',
      fillColor: viewModel.dataPengurus.index != '1'
          ? Colors.white
          : Colors.grey.shade100,
      validator: (value) => InputValidators.validateNPWP(value),
    );
  }

  CustomTextField _buildTempatLahir(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tempatLahirController,
      label: 'Tempat Lahir *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildStatusPerkawinan(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.statusPerkawinanController,
      label: 'Status Perkawinan *',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTanggalKK(
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.addressController,
        label: 'Alamat KTP *',
        enabled: false,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Widget _buildPostalCode(
    BuildContext context,
    double maxWidth,
    FormPengurusViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.postalCodeController,
        label: 'Kode Pos *',
        enabled: false,
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.searchBlack,
        fillColor: Colors.white,
        onTap: () => OpenPostalCode().openDialog(
          context: context,
          width: maxWidth,
          data: (data) => viewModel.updatePostalCode(data),
        ),
      ),
    );
  }

  CustomTextField _buildProvince(
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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

  CustomTextField _buildNominalSaham(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.nominalSahamController,
      label: 'Nominal Saham *',
      hintText: '0.00',
      enabled: true,
      fillColor: Colors.white,
      withPrefixIcon: true,
      prefixIconImagePath: IconConstants.rupiah,
      withThousandsSeparator: true,
    );
  }

  CustomTextField _buildLembarSaham(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.lembarSahamController,
      label: 'Lembar Saham *',
      hintText: 'Masukan Lembar Saham',
      enabled: true,
      fillColor: Colors.white,
      onSave: viewModel.getTotalLembarSaham,
      onChanged: viewModel.getTotalLembarSaham,
    );
  }

  Widget _buildPresentaseSaham(
    FormPengurusViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomTextField(
        textEditingController: viewModel.presentaseSahamController,
        label: 'Presentase Saham *',
        hintText: 'Masukan Persentase Saham',
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.percentage,
        enabled: false,
        fillColor: Colors.grey.shade100,
        keyboardType: TextInputType.number,
      ),
    );
  }

  CustomTextField _buildNoKtpPasangan(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.noKtpPasanganController,
      label: 'No. KTP Pasangan *',
      hintText: 'Masukan No. KTP Pasangan',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNamaPasangan(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.namaPasanganController,
      label: 'Nama Lengkap Pasangan *',
      hintText: 'Masukan Nama Lengkap Pasangan',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTempatLahirPasangan(
    FormPengurusViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tempatLahirPasanganController,
      label: 'Tempat Lahir Pasangan *',
      hintText: 'Masukan Tempat Lahir Pasangan',
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildTanggalLahirPasangan(
    FormPengurusViewModel viewModel,
    BuildContext context,
  ) {
    return CustomTextField(
      textEditingController: viewModel.tanggalLahirPasanganController,
      label: 'Tanggal Lahir Pasangan *',
      hintText: 'Masukan Tanggal Lahir Pasangan',
      enabled: false,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.calendar,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildNoAktaCerai(
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
        viewModel.tglAktaNikahController.text = date;
      },
      validator: (value) => InputValidators.validateRequiredField(
        value,
        fieldType: 'Tanggal Akta Cerai',
      ),
    );
  }

  CustomTextField _buildNoBelumNikah(
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
    FormPengurusViewModel viewModel,
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
}
