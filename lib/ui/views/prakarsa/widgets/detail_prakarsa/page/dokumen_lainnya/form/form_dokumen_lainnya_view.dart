import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../shared/custom_button.dart';
import '../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../shared/div_two_section.dart';
import '../../../../../../../shared/dotted_border_button.dart';
import 'form_dokumen_lainnya_viewmodel.dart';
import 'widget/form_dokumen_lainnya_section.dart';

class FormDokumenLainnyaView
    extends ViewModelBuilderWidget<FormDokumenLainnyaViewModel> {
  final String prakarsaId;
  final int codeTable;
  const FormDokumenLainnyaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
  });

  @override
  FormDokumenLainnyaViewModel viewModelBuilder(BuildContext context) =>
      FormDokumenLainnyaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(FormDokumenLainnyaViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    FormDokumenLainnyaViewModel viewModel,
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
                  const FormDokumenLainnyaSection(),
                  DottedBorderButton(
                    label: 'Tambah Dokumen',
                    onTap: viewModel.addDokumenLainnya,
                  ),
                  const SizedBox(height: 20.0),
                  DivTwoSection(
                    leftSection: CustomOutlinedButton(
                      label: 'Simpan Draft',
                      onPressed: () =>
                          viewModel.validateInputs(isSavedDrafts: true),
                    ),
                    rightSection: CustomButton(
                      label: 'Lanjutkan',
                      onPressed: () => viewModel.validateInputs(
                        isSavedDrafts: false,
                      ),
                      isBusy: false,
                    ),
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
