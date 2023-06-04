import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../shared/loading_indicator.dart';
import 'detail_debitur_header.dart';
import 'detail_debitur_prescreening.dart';
import 'detail_debitur_stepper.dart';
import 'detail_debitur_viewmodel.dart';

class DetailDebiturView extends ViewModelBuilderWidget<DetailDebiturViewModel> {
  final String prakarsaId;
  final int codeTable;
  final Function(String) setCurrentPage;
  const DetailDebiturView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.setCurrentPage,
  });

  @override
  DetailDebiturViewModel viewModelBuilder(BuildContext context) =>
      DetailDebiturViewModel(prakarsaId: prakarsaId, codeTable: codeTable);

  @override
  void onViewModelReady(DetailDebiturViewModel viewModel) {
    viewModel.initialize();
    setCurrentPage('');
  }

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailDebiturViewModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: viewModel.debiturPerorangan != null ||
                  viewModel.debiturPerusahaan != null
              ? const Responsive(
                  children: [
                    Div(
                      divison: Division(
                        colS: 12,
                        colM: 8,
                        colL: 8,
                        colXL: 8,
                      ),
                      child: Responsive(
                        children: [
                          DetailDebiturHeader(),
                          DetailDebiturStepper(),
                        ],
                      ),
                    ),
                    Div(
                      divison: Division(
                        colS: 12,
                        colM: 4,
                        colL: 4,
                        colXL: 4,
                      ),
                      child: DetailDebiturScreening(),
                    ),
                  ],
                )
              : const LoadingIndicator(),
        ),
      ],
    );
  }
}
