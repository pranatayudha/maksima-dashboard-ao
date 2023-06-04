import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/services/url_launcher_service.dart';
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
import '../../widgets/download_template_agunan.dart';
import '../../widgets/upload_document_agunan.dart';
import 'form_agunan_piutang_viewmodel.dart';

class FormAgunanPiutangView
    extends ViewModelBuilderWidget<FormAgunanPiutangViewModel> {
  final String id;
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  const FormAgunanPiutangView({
    super.key,
    required this.id,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  @override
  void onViewModelReady(FormAgunanPiutangViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormAgunanPiutangViewModel viewModelBuilder(BuildContext context) =>
      FormAgunanPiutangViewModel(
        id: id,
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );
  @override
  Widget builder(
    BuildContext context,
    FormAgunanPiutangViewModel viewModel,
    Widget? child,
  ) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: viewModel.autoValidateMode,
      child: viewModel.isLoadingForm
          ? const Center(
              child: LoadingIndicator(),
            )
          : Column(
              children: [
                BaseFromLayout(
                  rightSection: RowItemDetail(
                    listWidget: [
                      DetailPrakarsaItem(
                        title: 'Nominal Piutang',
                        value: (viewModel.calculationAgunan?.npw?.isNotEmpty ??
                                false)
                            ? RupiahFormatter.format(
                                viewModel.calculationAgunan?.npw,
                              )
                            : '-',
                        valueTextStyle: titleStyle16,
                      ),
                      DetailPrakarsaItem(
                        title: 'Posisi Periode Laporan Keuangan',
                        value: viewModel.calculationAgunan?.period ?? '0.00',
                        valueTextStyle: titleStyle16,
                      ),
                    ],
                  ),
                ),
                BaseFromLayout(
                  rightSection: DownloadTemplateAgunan(
                    title: 'Download Template Piutang',
                    subtitle:
                        'Lengkapi template piutang debitur dan upload pada kolom dibawah',
                    onTap: () => viewModel.downloadTemplate(),
                  ),
                ),
                BaseFromLayout(
                  rightSection: UploadDocumentAgunan(
                    docUrl: viewModel.agunanPublicUrl,
                    label: 'Upload Rincian Piutang a.n Debitur',
                    onTap: () =>
                        (viewModel.agunanPublicUrl?.isNotEmpty ?? false)
                            ? viewModel.deleteExcelPath()
                            : viewModel.pickFile(),
                    isLoading: viewModel.isLoadingUpload,
                    onTapLihat: () => locator<URLLauncherService>().browse(
                      viewModel.agunanPublicUrl!,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 14.0),
                  child: ThickLightGreyDivider(
                    verticalPadding: 0.0,
                  ),
                ),
                BaseFromLayout(
                  title: 'Pengikatan',
                  rightSection: RowItemDetail(
                    listWidget: [
                      buildJenisPengikatan(viewModel),
                    ],
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
    );
  }

  Widget buildJenisPengikatan(
    FormAgunanPiutangViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jenis Pengikatan',
            style: titleValue,
          ),
          const SizedBox(
            height: 4,
          ),
          CustomDropDown(
            listData: const [
              'Fidusia Sesuai UU',
            ],
            hintText: 'Pilih jenis pengikat',
            selectedValue: TextEditingController(
              text: viewModel.jenisPengikatanController.text.isNotEmpty
                  ? viewModel.jenisPengikatanController.text
                  : 'Fidusia Sesuai UU',
            ),
            onChanged: viewModel.updateJenisPengikatanController,
          ),
        ],
      ),
    );
  }

  Widget buildNpw(
    FormAgunanPiutangViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: CustomTextField(
        textEditingController: viewModel.nominalNPWController,
        label: 'NPW Piutang',
        hintText: '0.00',
        enabled: false,
        fillColor: Colors.grey.shade100,
        withPrefixIcon: true,
        prefixIconImagePath: IconConstants.rupiah,
        withThousandsSeparator: true,
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NPW',
        value: '${viewModel.calculationAgunan?.coverageNpw ?? '0.00'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildNl(
    FormAgunanPiutangViewModel viewModel,
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
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse(viewModel.calculationAgunan?.nl ?? '0'),
        ),
        onChanged: viewModel.updateCoverageNL,
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
    FormAgunanPiutangViewModel viewModel,
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
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse(viewModel.calculationAgunan?.pnpw ?? '0'),
        ),
        onChanged: viewModel.updateCoveragePNPW,
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
    FormAgunanPiutangViewModel viewModel,
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
        validator: (value) => InputValidators.validateNominal(
          value,
          (viewModel.maxValuePNL ?? 0).round(),
        ),
        onChanged: viewModel.updateCoveragePNL,
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
    FormAgunanPiutangViewModel viewModel,
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
        validator: (value) => InputValidators.validateNominal(
          value,
          int.parse(
            double.parse(viewModel.calculationAgunan?.npw ?? '0').toString(),
          ),
        ),
        onChanged: viewModel.updateNominalPengikat,
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Nilai Pengikatan',
        value: '${(viewModel.coveragePiutang ?? 0).toStringAsFixed(2)} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildhasilAnalisaAgunan(
    FormAgunanPiutangViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: CustomTextField(
        textEditingController: viewModel.analisaAgunanPokokController,
        label: 'Analisa Agunan Pokok',
        hintText: 'Masukan Analisa Agunan Pokok',
        enabled: true,
        verticalContentPadding: 16,
        fillColor: Colors.white,
        validator: (value) => InputValidators.validateRequiredField(
          value,
          fieldType: 'Analisa Agunan Pokok',
        ),
      ),
    );
  }
}
