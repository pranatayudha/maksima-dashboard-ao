import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../shared/base_form_single_section.dart';
import '../../../../../../../../../shared/div_two_section.dart';
import '../../../../../../../../../shared/upload_item_button_ritel.dart';
import '../form_legalitas_usaha_viewmodel.dart';

class FormAktaPendirianDokumenSection
    extends HookViewModelWidget<FormLegalitasUsahaViewModel> {
  const FormAktaPendirianDokumenSection({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLegalitasUsahaViewModel viewModel,
  ) {
    return BaseFormSingleSection(
      titleSection: 'Dokumen',
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DivTwoSection(
            leftSection: _aktaPendirianDokumen(viewModel, context),
            rightSection: _skKumhamPendirian(viewModel, context),
          ),
        ],
      ),
    );
  }

  UploadItemButtonRitel _aktaPendirianDokumen(
    FormLegalitasUsahaViewModel vm,
    BuildContext context,
  ) {
    return UploadItemButtonRitel(
      imageUrl: vm.aktaPendirianUrlPublic,
      label: 'Akta Pendirian *',
      onPressed: vm.aktaPendirianUrlPublic == ''
          ? () => vm.uploadFilePendirian(context, 0)
          : () => vm.clearFilePendirian(0),
      errorText: null,
    );
  }

  UploadItemButtonRitel _skKumhamPendirian(
    FormLegalitasUsahaViewModel vm,
    BuildContext context,
  ) {
    return UploadItemButtonRitel(
      imageUrl: vm.skKumhamPendirianUrlPublic,
      label: 'SK Kumham Pendirian *',
      onPressed: vm.skKumhamPendirianUrlPublic == ''
          ? () => vm.uploadFilePendirian(context, 1)
          : () => vm.clearFilePendirian(1),
      errorText: null,
    );
  }
}
