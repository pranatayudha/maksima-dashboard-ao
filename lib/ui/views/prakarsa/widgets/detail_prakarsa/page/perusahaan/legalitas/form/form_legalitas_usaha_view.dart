import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../shared/dotted_border_button.dart';
import 'form_legalitas_usaha_viewmodel.dart';
import 'widget/form_akta_pendirian_dokumen_section.dart';
import 'widget/form_akta_pendirian_section.dart';
import 'widget/form_akta_perubahan_terakhir_section.dart';

class FormLegalitasUsahaView
    extends ViewModelBuilderWidget<FormLegalitasUsahaViewModel> {
  final String prakarsaId;
  final int codeTable;
  const FormLegalitasUsahaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
  });

  @override
  FormLegalitasUsahaViewModel viewModelBuilder(BuildContext context) =>
      FormLegalitasUsahaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(FormLegalitasUsahaViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    FormLegalitasUsahaViewModel viewModel,
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
                  const FormAktaPendirianSection(),
                  const FormAktaPendirianDokumenSection(),
                  const FormAktaPerubahanTerakhirSection(),
                  DottedBorderButton(
                    label: 'Tambah Akta Perubahan Lain',
                    onTap: viewModel.addAktaPerubahanLain,
                  ),
                  const SizedBox(height: 20.0),
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
