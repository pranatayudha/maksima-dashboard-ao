import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../shared/breadcrum.dart';
import 'monitoring_viewmodel.dart';

class MonitoringView extends ViewModelBuilderWidget<MonitoringViewModel> {
  const MonitoringView({
    super.key,
  });

  @override
  MonitoringViewModel viewModelBuilder(BuildContext context) =>
      MonitoringViewModel();

  @override
  void onViewModelReady(MonitoringViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    MonitoringViewModel viewModel,
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
              // if (viewModel.localDBService.currentRoutes() == 'Monitoring')
              const Center(
                child: Text(
                  'Coming Soon',
                ),
              ),
              // const DetailPrakarsaView(),
            ],
          ),
        ),
      ),
    );
  }
}
