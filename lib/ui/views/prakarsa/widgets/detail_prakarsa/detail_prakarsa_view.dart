import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../application/helpers/responsive_helpers.dart';
import 'detail_prakarsa_viewmodel.dart';
import 'widgets/content_detail.dart';
import 'widgets/sidebar_menu_prakarsa.dart';

class DetailPrakarsaView
    extends ViewModelBuilderWidget<DetailPrakarsaViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String initial;
  final String name;
  final String loanAmount;
  final String pipelineId;
  final double height;
  final String? currentPage;
  final Function(dynamic) callBackData;
  final Function(String) setCurrentPage;
  const DetailPrakarsaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.initial,
    required this.name,
    required this.loanAmount,
    required this.pipelineId,
    required this.callBackData,
    required this.height,
    required this.setCurrentPage,
    required this.currentPage,
  });

  @override
  DetailPrakarsaViewModel viewModelBuilder(BuildContext context) =>
      DetailPrakarsaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        currentContent: currentPage ?? '',
      );

  @override
  void onViewModelReady(DetailPrakarsaViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailPrakarsaViewModel viewModel,
    Widget? child,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: height,
          padding: const EdgeInsets.all(8.0),
          child: Responsive(
            children: [
              Div(
                divison: const Division(
                  colS: 12,
                  colM: 4,
                  colL: 4,
                  colXL: 4,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SidebarMenuPrakarsa(
                    selectedPage: viewModel.selectedPage,
                    listSidebar: viewModel.listSidebar,
                    onTap: (val) {
                      setCurrentPage(val['title']);
                      viewModel.setContentPage(val);
                    },
                    dataDebitur: {
                      'initial': initial,
                      'name': name,
                      'loanAmount': loanAmount,
                      'pipelineId': pipelineId,
                    },
                    codeTable: codeTable,
                    height: height,
                  ),
                ),
              ),
              Div(
                divison: const Division(
                  colS: 12,
                  colM: 8,
                  colL: 8,
                  colXL: 8,
                ),
                child: ContentDetailPrakarsa(
                  selectedPage: viewModel.selectedPage,
                  stepperStatus: viewModel.stepperStatus ?? false,
                  prakarsaId: prakarsaId,
                  codeTable: codeTable,
                  pipelineId: pipelineId,
                  width: constraints.maxWidth,
                  height: ResponsiveHelpers.isDesktop(context)
                      ? height
                      : height - 100,
                  callBackData: (data) => callBackData(data),
                  refreshStepper: (val) {
                    if (val) {
                      viewModel.refreshStepper();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
