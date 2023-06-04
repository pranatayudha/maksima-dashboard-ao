import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../../shared/upload_item_button_ritel.dart';
import '../form_identitas_perusahaan_viewmodel.dart';

class FormDokumenPerusahaanSection
    extends HookViewModelWidget<FormIdentitasPerusahaanViewModel> {
  const FormDokumenPerusahaanSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormIdentitasPerusahaanViewModel viewModel,
  ) {
    return BaseFormSingleSection(
      titleSection: 'Dokumen',
      isLast: true,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UploadItemButtonRitel(
            imageUrl: viewModel.npwpPerusahaanUrlPublic,
            label: 'NPWP Perusahaan *',
            onPressed: viewModel.npwpPerusahaanUrlPublic == null
                ? () => viewModel.captureNpwpPerusahaan(context)
                : viewModel.clearNpwpPerusahaan,
            errorText: viewModel.npwpPerusahaanErrorText,
          ),
        ],
      ),
    );
  }
}
