// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:flutter/material.dart';
import 'package:pinang_maksima_dashboard_ao/ui/shared/no_network.dart' as _i10;
import 'package:pinang_maksima_dashboard_ao/ui/shared/server_maintenance.dart'
    as _i9;
import 'package:pinang_maksima_dashboard_ao/ui/views/dashboard/dashboard_view.dart'
    as _i5;
import 'package:pinang_maksima_dashboard_ao/ui/views/login/login_view.dart'
    as _i3;
import 'package:pinang_maksima_dashboard_ao/ui/views/main/main_view.dart'
    as _i4;
import 'package:pinang_maksima_dashboard_ao/ui/views/monitoring/monitoring_view.dart'
    as _i8;
import 'package:pinang_maksima_dashboard_ao/ui/views/pipeline/pipeline_view.dart'
    as _i6;
import 'package:pinang_maksima_dashboard_ao/ui/views/prakarsa/prakarsa_view.dart'
    as _i7;
import 'package:pinang_maksima_dashboard_ao/ui/views/startup/startup_view.dart'
    as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i12;

class Routes {
  static const startupView = '/';

  static const loginView = '/login-view';

  static const mainView = '/main-view';

  static const dashboardView = '/dashboard-view';

  static const pipelineView = '/pipeline-view';

  static const prakarsaView = '/prakarsa-view';

  static const monitoringView = '/monitoring-view';

  static const serverMaintenance = '/server-maintenance';

  static const noNetwork = '/no-network';

  static const all = <String>{
    startupView,
    loginView,
    mainView,
    dashboardView,
    pipelineView,
    prakarsaView,
    monitoringView,
    serverMaintenance,
    noNetwork,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i4.MainView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i5.DashboardView,
    ),
    _i1.RouteDef(
      Routes.pipelineView,
      page: _i6.PipelineView,
    ),
    _i1.RouteDef(
      Routes.prakarsaView,
      page: _i7.PrakarsaView,
    ),
    _i1.RouteDef(
      Routes.monitoringView,
      page: _i8.MonitoringView,
    ),
    _i1.RouteDef(
      Routes.serverMaintenance,
      page: _i9.ServerMaintenance,
    ),
    _i1.RouteDef(
      Routes.noNetwork,
      page: _i10.NoNetwork,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.MainView: (data) {
      final args = data.getArgs<MainViewArguments>(
        orElse: () => const MainViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i4.MainView(
            key: args.key,
            isDetailDebt: args.isDetailDebt,
            isDetailPrakarsa: args.isDetailPrakarsa),
        settings: data,
      );
    },
    _i5.DashboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.DashboardView(),
        settings: data,
      );
    },
    _i6.PipelineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.PipelineView(),
        settings: data,
      );
    },
    _i7.PrakarsaView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.PrakarsaView(),
        settings: data,
      );
    },
    _i8.MonitoringView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.MonitoringView(),
        settings: data,
      );
    },
    _i9.ServerMaintenance: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ServerMaintenance(),
        settings: data,
      );
    },
    _i10.NoNetwork: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.NoNetwork(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MainViewArguments {
  const MainViewArguments({
    this.key,
    this.isDetailDebt = false,
    this.isDetailPrakarsa = false,
  });

  final _i11.Key? key;

  final bool? isDetailDebt;

  final bool? isDetailPrakarsa;
}

extension NavigatorStateExtension on _i12.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView({
    _i11.Key? key,
    bool? isDetailDebt = false,
    bool? isDetailPrakarsa = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.mainView,
        arguments: MainViewArguments(
            key: key,
            isDetailDebt: isDetailDebt,
            isDetailPrakarsa: isDetailPrakarsa),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPipelineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.pipelineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrakarsaView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.prakarsaView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMonitoringView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.monitoringView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToServerMaintenance([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.serverMaintenance,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNoNetwork([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.noNetwork,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
