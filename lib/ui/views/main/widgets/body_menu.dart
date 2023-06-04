import 'package:flutter/material.dart';

import '../../dashboard/dashboard_view.dart';
import '../../monitoring/monitoring_view.dart';
import '../../pipeline/pipeline_view.dart';
import '../../prakarsa/prakarsa_view.dart';

class BodyMenu extends StatelessWidget {
  final int index;
  const BodyMenu({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const Expanded(
          child: DashboardView(),
        );
      case 1:
        return const Expanded(
          child: PipelineView(),
        );
      case 2:
        return const Expanded(
          child: PrakarsaView(),
        );
      case 3:
        return const Expanded(
          child: MonitoringView(),
        );
      default:
        return const Expanded(
          child: DashboardView(),
        );
    }
  }
}
