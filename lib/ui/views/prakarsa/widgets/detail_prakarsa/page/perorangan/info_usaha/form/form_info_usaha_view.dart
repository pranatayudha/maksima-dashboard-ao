import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import 'form_info_usaha_viewmodel.dart';
import 'widgets/form_info_usaha_section.dart';

class FormInfoUsahaView extends ViewModelBuilderWidget<FormInfoUsahaViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  const FormInfoUsahaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  @override
  void onViewModelReady(FormInfoUsahaViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormInfoUsahaViewModel viewModelBuilder(BuildContext context) =>
      FormInfoUsahaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      );

  @override
  Widget builder(
    BuildContext context,
    FormInfoUsahaViewModel viewModel,
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
      child: viewModel.isBusy
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
                            FormInfoUsahaSection(
                              width: size.maxWidth,
                            ),
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
