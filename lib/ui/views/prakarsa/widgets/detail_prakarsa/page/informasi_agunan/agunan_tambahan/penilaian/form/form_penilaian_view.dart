import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../../shared/custom_dropdown.dart';
import '../../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/loading_indicator.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../../../../../widgets/base_view.dart';
import 'form_penilaian_viewmodel.dart';

class FormPenilaianView extends ViewModelBuilderWidget<FormPenilaianViewModel> {
  final ListAgunanTambahanModel dataAgunan;
  final String prakarsaId;
  final double height;
  final double width;

  const FormPenilaianView({
    super.key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.height,
    required this.width,
  });

  @override
  void onViewModelReady(FormPenilaianViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormPenilaianViewModel viewModelBuilder(BuildContext context) =>
      FormPenilaianViewModel(
        id: dataAgunan.id ?? '',
        prakarsaId: prakarsaId,
        jenisPenilaian: dataAgunan.jenisPenilaian ?? '',
      );
  @override
  Widget builder(
    BuildContext context,
    FormPenilaianViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height - 40,
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: viewModel.autoValidateMode,
        child: viewModel.isLoadingForm
            ? const Center(
                child: LoadingIndicator(),
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  if (viewModel.detailPenilaian!.jenisPenilaian ==
                      'Penilaian Internal')
                    BaseFromLayout(
                      title: 'Pengikatan',
                      rightSection: RowItemDetail(
                        listWidget: [
                          buildJenisPengikatan(viewModel),
                        ],
                      ),
                    ),
                  if (viewModel.detailPenilaian!.jenisPenilaian ==
                      'Penilaian Internal')
                    const Padding(
                      padding: EdgeInsets.only(bottom: 14.0),
                      child: ThickLightGreyDivider(
                        verticalPadding: 0.0,
                      ),
                    ),
                  BaseFromLayout(
                    title: 'Nilai Pasar Wajar (NPW)',
                    rightSection: buildNpw(viewModel),
                  ),
                  BaseFromLayout(
                    title: 'Nilai Likuidasi (NL)',
                    rightSection: buildNl(viewModel),
                  ),
                  BaseFromLayout(
                    title: 'Proyeksi Nilai Pasar Wajar (PNPW)',
                    rightSection: buildPnpw(viewModel),
                  ),
                  BaseFromLayout(
                    title: 'Proyeksi Nilai Likuidasi (PNL)',
                    rightSection: buildPnl(viewModel),
                  ),
                  BaseFromLayout(
                    title: 'Nilai Pengikatan',
                    rightSection: buildNilaiPengikatan(viewModel),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: ThickLightGreyDivider(
                      verticalPadding: 0.0,
                    ),
                  ),
                  BaseFromLayout(
                    title: 'Hasil Analisa Agunan',
                    subtitle: 'Asumsi agunan untuk Bank Raya',
                    rightSection: buildhasilAnalisaAgunan(viewModel),
                  ),
                  BaseFormSection(
                    leftSection: const SizedBox(),
                    rightSection: BaseFormSection(
                      leftSection: CustomOutlinedButton(
                        label: 'Simpan Draft',
                        onPressed: () =>
                            viewModel.validateInputs(isSavedDrafts: true),
                      ),
                      rightSection: CustomButton(
                        label: 'Lanjutkan',
                        onPressed: () =>
                            viewModel.validateInputs(isSavedDrafts: false),
                        isBusy: false,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildJenisPengikatan(
    FormPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        label: 'Metode Pendekatan',
        enabled: false,
        textEditingController:
            TextEditingController(text: 'Pendekatan data pasar'),
      ),
      rightSection: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Judgement harga aset',
            style: titleValue,
          ),
          const SizedBox(
            height: 4,
          ),
          CustomDropDown(
            listData: const [
              'NJOP',
              'Data Pembanding Tertinggi',
              'Data Pembanding Rata-rata',
              'Data Pembanding Terendah',
            ],
            hintText: 'Pilih jenis judgement harga aset',
            selectedValue: viewModel.jugmentHargaAssetController,
            onChanged: viewModel.updatejugmentHargaAssetController,
          ),
        ],
      ),
      isLast: true,
    );
  }

  Widget buildNpw(
    FormPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        textEditingController: viewModel.nominalNPWController,
        label: 'NPW Piutang',
        hintText: '0.00',
        // enabled: false,
        fillColor: Colors.grey.shade100,
        withPrefixIcon: true,
        prefixIconImagePath: IconConstants.rupiah,
        withThousandsSeparator: true,
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NPW',
        value:
            '${viewModel.coverageNPW == null ? '-' : (viewModel.coverageNPW ?? 0).toStringAsFixed(0)} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildNl(
    FormPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        textEditingController: viewModel.nominalNLController,
        label: 'NL Piutang',
        hintText: '0.00',
        enabled: true,
        fillColor: Colors.white,
        withPrefixIcon: true,
        prefixIconImagePath: IconConstants.rupiah,
        withThousandsSeparator: true,
        onChanged: viewModel.updateCoverageNL,
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse((viewModel.maxValueNL ?? '0').toString()),
        ),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NL',
        value:
            '${viewModel.nominalNLController.text.isEmpty ? '0.00' : (viewModel.coverageNL ?? 0).toStringAsFixed(2)} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildPnpw(
    FormPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        textEditingController: viewModel.nominalPNPWController,
        label: 'PNPW Piutang',
        hintText: '0.00',
        enabled: true,
        fillColor: Colors.white,
        withPrefixIcon: true,
        prefixIconImagePath: IconConstants.rupiah,
        withThousandsSeparator: true,
        onChanged: viewModel.updateCoveragePNPW,
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse((viewModel.maxValuePNPW ?? '0').toString()),
        ),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio PNPW',
        value:
            '${viewModel.nominalPNPWController.text.isEmpty ? '0.00' : (viewModel.coveragePNPW ?? 0).toStringAsFixed(2)} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildPnl(
    FormPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        textEditingController: viewModel.nominalPNLController,
        label: 'PNL Piutang',
        hintText: '0.00',
        enabled: true,
        fillColor: Colors.white,
        withPrefixIcon: true,
        prefixIconImagePath: IconConstants.rupiah,
        withThousandsSeparator: true,
        onChanged: viewModel.updateCoveragePNL,
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse((viewModel.maxValuePNL ?? '0').toString()),
        ),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio PNL',
        value:
            '${viewModel.nominalPNLController.text.isEmpty ? '0.00' : (viewModel.coveragePNL ?? 0).toStringAsFixed(2)} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildNilaiPengikatan(
    FormPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        textEditingController: viewModel.nominalNilaiPengikatanController,
        label: 'Nilai Pengikatan Piutang',
        hintText: '0.00',
        enabled: true,
        fillColor: Colors.white,
        withPrefixIcon: true,
        prefixIconImagePath: IconConstants.rupiah,
        withThousandsSeparator: true,
        onChanged: viewModel.updateNominalPengikat,
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse((viewModel.maxValuePNPW ?? '0').toString()),
        ),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Nilai Pengikatan',
        value:
            '${viewModel.nominalNilaiPengikatanController.text.isEmpty ? '0.00' : (viewModel.coveragePiutang ?? 0).toStringAsFixed(2)} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildhasilAnalisaAgunan(
    FormPenilaianViewModel viewModel,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomTextField(
            textEditingController: viewModel.bankNeedToKnowController,
            label: viewModel.detailPenilaian!.jenisPenilaian ==
                    'Penilaian Internal'
                ? 'Hal - hal yang perlu diketahui Bank'
                : 'Opini KJPP',
            hintText: viewModel.detailPenilaian!.jenisPenilaian ==
                    'Penilaian Internal'
                ? 'Masukkan alasan dan asumsi'
                : 'Masukkan Opini KJPP',
            enabled: true,
            fillColor: Colors.white,
            verticalContentPadding: 16,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Analisa Agunan Pokok',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomTextField(
            textEditingController: viewModel.analisaAgunanTambahan,
            label: 'Analisa Agunan Tambahan',
            hintText: 'Masukkan Analisa Agunan Tambahan',
            enabled: true,
            fillColor: Colors.white,
            verticalContentPadding: 16,
            validator: (value) => InputValidators.validateRequiredField(
              value,
              fieldType: 'Analisa Agunan Pokok',
            ),
          ),
        ),
      ],
    );
  }
}
