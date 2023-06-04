import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import 'form_identitas_diri_viewmodel.dart';
import 'widgets/form_identitas_diri_section.dart';

class FormIdentitasDiriView
    extends ViewModelBuilderWidget<FormIdentitasDiriViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  const FormIdentitasDiriView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  @override
  void onViewModelReady(FormIdentitasDiriViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormIdentitasDiriViewModel viewModelBuilder(BuildContext context) =>
      FormIdentitasDiriViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      );

  @override
  Widget builder(
    BuildContext context,
    FormIdentitasDiriViewModel viewModel,
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
      child: viewModel.isLoadingData
          ? const LoadingIndicator()
          : LayoutBuilder(
              builder: (context, size) {
                return Responsive(
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
                            FormIdentitasDiriSection(width: size.maxWidth),
                            CustomOutlinedButton(
                              label: 'Simpan Draft',
                              onPressed: () =>
                                  viewModel.validateInputs(isSavedDrafts: true),
                            ),
                            const SizedBox(height: 10.0),
                            CustomButton(
                              label: 'Lanjutkan',
                              onPressed: () => viewModel.validateInputs(
                                isSavedDrafts: false,
                              ),
                              isBusy: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
