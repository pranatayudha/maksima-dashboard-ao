import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../shared/custom_button.dart';
import '../../../../../../../shared/custom_outlined_button.dart';
import 'form_lkn_viewmodel.dart';
import 'widgets/form_lkn_section.dart';
import 'widgets/form_pejabat_section.dart';
import 'widgets/hasil_kunjungan_section.dart';
import 'widgets/lkn_upload_section.dart';

class FormLKNView extends ViewModelBuilderWidget<FormLKNViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double width;
  const FormLKNView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
  });

  @override
  FormLKNViewModel viewModelBuilder(BuildContext context) => FormLKNViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(FormLKNViewModel viewModel) => viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    FormLKNViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Responsive(
        children: [
          Div(
            divison: const Division(
              colS: 12,
              colM: 12,
              colL: 12,
              colXL: 12,
            ),
            child: Form(
              key: viewModel.formKey,
              autovalidateMode: viewModel.autoValidateMode,
              child: Column(
                children: [
                  const FormLKNSection(),
                  const FormPejabatSection(),
                  LKNUploadSection(
                    width: width,
                  ),
                  const HasilKunjunganSection(),
                  CustomOutlinedButton(
                    label: 'Simpan Draft',
                    onPressed: () =>
                        viewModel.validateInputs(isSavedDrafts: true),
                  ),
                  const SizedBox(height: 10.0),
                  CustomButton(
                    label: 'Lanjutkan',
                    onPressed: () =>
                        viewModel.validateInputs(isSavedDrafts: false),
                    isBusy: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
