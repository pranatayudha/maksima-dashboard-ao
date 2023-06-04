import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../shared/custom_dropdown.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import 'form_agunan_tanah_viewmodel.dart';
import 'widgets/penilaian_internal/form_penilaian_internal_view.dart';

class FormAgunanTanahView
    extends ViewModelBuilderWidget<FormAgunanTanahViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double width;
  final Function(dynamic) agunanId;
  final String id;

  const FormAgunanTanahView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
    required this.agunanId,
    required this.id,
  });

  @override
  void onViewModelReady(FormAgunanTanahViewModel viewModel) =>
      viewModel.initialize();

  @override
  FormAgunanTanahViewModel viewModelBuilder(BuildContext context) =>
      FormAgunanTanahViewModel(
        id: id,
        prakarsaId: prakarsaId,
      );
  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    FormAgunanTanahViewModel viewModel,
    Widget? child,
  ) {
    return ListView(
      shrinkWrap: true,
      children: [
        BaseFromLayout(
          title: 'Penilaian Agunan',
          subtitle: 'Penilaian Internal / KJPP Rekanan / KJPP Non Rekanan',
          rightSection: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomTextField(
                  label: 'Jenis Agunan Tambahan',
                  initialValue: 'Tanah',
                  withSuffixIcon: true,
                  suffixIconImagePath: IconConstants.chevronDown,
                  enabled: false,
                  fillColor: Colors.grey.shade100,
                ),
                if (!viewModel.isLoading)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Penilaian',
                        style: titleValue,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomDropDown(
                        listData: const [
                          'Penilaian Internal',
                          'Penilaian KJPP Rekanan',
                          'Penilaian KJPP Non Rekanan',
                        ],
                        hintText: 'Pilih Status Penilaian',
                        selectedValue: viewModel.selectedValue,
                        onChanged: (val) => viewModel.setSelectedValue(val),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        // const DividerForm(),
        FormPenilaianInternalView(
          codeTable: codeTable,
          prakarsaId: prakarsaId,
          width: width,
          jenisPenilaian: viewModel.selectedValue.text,
          agunanId: (id) => agunanId(id),
          id: id,
        ),
      ],
    );
  }
}
