import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../shared/custom_outlined_button.dart';
import '../../../../../../../../shared/dotted_border_button.dart';
import '../../../../widgets/base_view.dart';
import 'form_data_pembanding_viewmodel.dart';
import 'widgets/form_data_pembanding_section.dart';

class FormDataPembandingView
    extends ViewModelBuilderWidget<FormDataPembandingViewModel> {
  final ListAgunanTambahanModel? dataAgunan;
  final int codeTable;
  final String prakarsaId;
  final double height;
  final double width;
  const FormDataPembandingView({
    Key? key,
    this.dataAgunan,
    required this.codeTable,
    required this.prakarsaId,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  void onViewModelReady(FormDataPembandingViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormDataPembandingViewModel viewModelBuilder(BuildContext context) =>
      FormDataPembandingViewModel(
        prakarsaId: prakarsaId,
        id: dataAgunan?.id ?? '',
        width: width,
      );

  @override
  Widget builder(
    BuildContext context,
    FormDataPembandingViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height - 40,
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: viewModel.autoValidateMode,
        child: Column(
          children: [
            Expanded(
              child: viewModel.isLoadingForm
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Text('Memuat data...'),
                      ],
                    )
                  : ListView.separated(
                      itemCount: viewModel.listDataPembanding.length,
                      itemBuilder: (context, index) =>
                          FormDataPembandingSection(index: index),
                      separatorBuilder: (context, index) => const Divider(),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DottedBorderButton(
                label: 'Tambah Data Pembanding',
                onTap: () => viewModel.addDataPembanding(),
              ),
            ),
            BaseFormSection(
              leftSection: CustomOutlinedButton(
                label: 'Simpan Draft',
                onPressed: () => viewModel.validateInputs(isSavedDrafts: true),
              ),
              rightSection: CustomButton(
                label: 'Lanjutkan',
                onPressed: () => viewModel.validateInputs(isSavedDrafts: false),
                isBusy: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
