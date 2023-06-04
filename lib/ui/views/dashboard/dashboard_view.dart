import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../shared/breadcrum.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends ViewModelBuilderWidget<DashboardViewModel> {
  const DashboardView({
    super.key,
  });

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();

  @override
  void onViewModelReady(DashboardViewModel viewModel) => viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: ValueListenableBuilder(
        valueListenable: viewModel.localDBService.routesBox.listenable(),
        builder: (context, value, child) => LayoutBuilder(
          builder: (context, constraints) => ListView(
            children: [
              BreadCrum(
                width: constraints.maxWidth - 50,
                breadCrum: viewModel.localDBService.getRoutes() ?? [],
                onTapBack: () => viewModel.navigateBack(),
                onTapBreadCrum: (val) => viewModel.navigateBackByKey(val),
              ),
              // if (viewModel.localDBService.currentRoutes() == 'Pipeline')
              const Center(
                child: Text(
                  'Coming Soon',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
