import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../application/app/constants/page_route.dart';
import '../../../../../../application/models/prakarsa_list_model.dart';
import '../../../../../shared/custom_table.dart';
import '../../../../../shared/paging_table.dart';
import '../prakarsa_list_viewmodel.dart';
import 'search_bar_prakarsa.dart';

class PrakarsaListBody extends ViewModelBuilderWidget<PrakarsaListViewModel> {
  final Function(Map<String, dynamic>)? selectedPrakarasa;
  const PrakarsaListBody({super.key, required this.selectedPrakarasa});

  @override
  PrakarsaListViewModel viewModelBuilder(BuildContext context) =>
      PrakarsaListViewModel();

  @override
  Widget builder(
    BuildContext context,
    PrakarsaListViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<PrakarsaListViewModel>.reactive(
      viewModelBuilder: () => PrakarsaListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarPrakarsa(
                width: constraints.maxWidth,
                hintText: 'Cari Nama Debitur',
                onSearch: (val) => viewModel.onSearchName(val),
                onChangedLoanType: (val) => viewModel.onFilterLoanType(val),
                onChangedStatus: (val) => viewModel.onFilterStatus(val),
              ),
              CustomTable(
                listHeader: viewModel.listHeader,
                listContent: viewModel.content,
                onTap: (index) {
                  viewModel.getIdByIndex(index);
                  selectedPrakarasa!({
                    'prakarsaId': viewModel.prakarsaId,
                    'codeTable': viewModel.codeTable,
                    'initial': viewModel.initial,
                    'name': viewModel.name,
                    'loanAmount': viewModel.loanAmount,
                    'pipelineId': viewModel.pipelineId,
                  });
                  viewModel.navigateTo(ConstantPageRoute.detailDebiturPage);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              PagingTable(
                metaData: Meta(
                  currentPage: viewModel.currentPage,
                  lastPage: viewModel.lastPage,
                  totalData: viewModel.totalData,
                  size: viewModel.limit,
                ),
                onTap: (val) => viewModel.pagingNavigation(val),
                length: viewModel.content.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
