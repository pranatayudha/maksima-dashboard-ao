import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../../shared/divider_form.dart';
import '../../../../../../../../../shared/loading_indicator.dart';
import '../../tanah/form/widgets/penilaian_internal/widgets/info_jenis_penilaian.dart';
import 'penilaian_agunan_viewmodel.dart';

class FormPenilaianAgunanaView
    extends ViewModelBuilderWidget<FormPenilaianAgunanViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double width;
  final String jenisPenilaian;
  final Function(dynamic) agunanId;
  final String id;

  const FormPenilaianAgunanaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
    required this.jenisPenilaian,
    required this.agunanId,
    required this.id,
  });

  @override
  void onViewModelReady(FormPenilaianAgunanViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormPenilaianAgunanViewModel viewModelBuilder(BuildContext context) =>
      FormPenilaianAgunanViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        jenisPenilaian: jenisPenilaian,
        id: id,
      );
  @override
  Widget builder(
    BuildContext context,
    FormPenilaianAgunanViewModel viewModel,
    Widget? child,
  ) {
    return Form(
      key: viewModel.formKey,
      child: viewModel.isLoadForm
          ? const LoadingIndicator()
          : Column(
              children: [
                if (jenisPenilaian != 'Penilaian Internal')
                  InfoJenisPenilaian(jenisPenilaian),
                const DividerForm(),
                BaseFormSection(
                  leftSection: const SizedBox(),
                  rightSection: BaseFormSection(
                    leftSection: CustomOutlinedButton(
                      label: 'Simpan Draft',
                      onPressed: () => viewModel
                          .validateInputs(
                        isSavedDrafts: true,
                        tipePeniaian: jenisPenilaian,
                      )
                          .then(
                        (id) {
                          agunanId(
                            ListAgunanTambahanModel(
                              id: id,
                              codeTable: 'tanah',
                            ),
                          );
                          if (id.isNotEmpty) {
                            viewModel.showSuccessDialog(true);
                          }
                        },
                      ),
                    ),
                    rightSection: CustomButton(
                      label: 'Lanjutkan',
                      onPressed: () => viewModel
                          .validateInputs(
                        isSavedDrafts: false,
                        tipePeniaian: jenisPenilaian,
                      )
                          .then(
                        (id) {
                          agunanId(
                            ListAgunanTambahanModel(
                              id: id,
                              codeTable: 'tanah',
                            ),
                          );
                          if (id.isNotEmpty) {
                            viewModel.showSuccessDialog(false);
                          }
                        },
                      ),
                      isBusy: false,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
