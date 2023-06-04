import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../application/models/list_agunan_pokok_model.dart';
import '../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import 'list_agunan_pokok_viewmodel.dart';
import 'widgets/agunan_pokok_card.dart';

class ListAgunanPokokView
    extends ViewModelBuilderWidget<ListAgunanPokokViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double height;
  final Function(dynamic) selectedAgunan;
  const ListAgunanPokokView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.height,
    required this.selectedAgunan,
  });

  @override
  void onViewModelReady(ListAgunanPokokViewModel viewModel) =>
      viewModel.initialise();

  @override
  ListAgunanPokokViewModel viewModelBuilder(BuildContext context) =>
      ListAgunanPokokViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      );
  @override
  Widget builder(
    BuildContext context,
    ListAgunanPokokViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const HeaderContent(title: 'Agunan Pokok'),
              const WarningAlert(
                title: 'Lengkapi Agunan Pokok Debitur',
                subtitle:
                    'Lengkapi informasi agunan pokok dan persediaan debitur',
              ),
              if (viewModel.isBusy && viewModel.listAgunanModel == null)
                SizedBox(
                  height: height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Memuat data...'),
                    ],
                  ),
                )
              else if (viewModel.listAgunanModel?.isEmpty ?? true) ...[
                CustomEmptyState(
                  height: height / 4,
                  title: 'Belum Ada Agunan pokok',
                  subTitle: 'Tambah agunan pokok dan persediaan debitur',
                  imageAsset: ImageConstants.emptyList,
                ),
              ] else
                ...List.generate(
                  viewModel.listAgunanModel?.length ?? 0,
                  (index) => AgunanPokokCard(
                    index: index,
                    dataAgunan: viewModel.listAgunanModel![index],
                    onTap: () {
                      viewModel.listAgunanModel![index].index = index + 1;
                      selectedAgunan(
                        viewModel.listAgunanModel![index],
                      );
                      viewModel.navigateTo(ConstantPageRoute.detailAgunanPokok);
                    },
                  ),
                ),
            ],
          ),
          if (!viewModel.isBusy && (viewModel.listAgunanModel?.length ?? 0) < 1)
            CustomButton(
              label: 'Tambah Agunan Pokok',
              onPressed: () {
                selectedAgunan(ListAgunanModel());
                viewModel.navigateTo(ConstantPageRoute.formAgunanPokok);
              },
              isBusy: false,
            ),
        ],
      ),
    );
  }
}
