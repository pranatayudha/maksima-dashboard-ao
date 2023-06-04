import 'package:dio/dio.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../infrastructure/apis/agunan_pokok_api.dart';
import '../../infrastructure/apis/agunan_tambahan_api.dart';
import '../../infrastructure/apis/employees_api.dart';
import '../../infrastructure/apis/generate_token_api.dart';
import '../../infrastructure/apis/lkn_api.dart';
import '../../infrastructure/apis/master_api.dart';
import '../../infrastructure/apis/perorangan_api.dart';
import '../../infrastructure/apis/perusahaan_api.dart';
import '../../infrastructure/apis/prakarsa_api.dart';
import '../../infrastructure/apis/screening_api.dart';
import '../../infrastructure/apis/user_api.dart';
import '../../ui/shared/no_network.dart';
import '../../ui/shared/server_maintenance.dart';
import '../../ui/views/dashboard/dashboard_view.dart';
import '../../ui/views/login/login_view.dart';
import '../../ui/views/main/main_view.dart';
import '../../ui/views/monitoring/monitoring_view.dart';
import '../../ui/views/pipeline/pipeline_view.dart';
import '../../ui/views/prakarsa/prakarsa_view.dart';
import '../../ui/views/startup/startup_view.dart';
import '../services/connectivity_service.dart';
import '../services/dio_service.dart';
import '../services/local_db_service.dart';
import '../services/location_service.dart';
import '../services/media_service.dart';
import '../services/url_launcher_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: MainView),
    // Dashboard
    MaterialRoute(page: DashboardView),
    // Pipeline
    MaterialRoute(page: PipelineView),
    // Prakarsa
    MaterialRoute(page: PrakarsaView),
    // Monitoring
    MaterialRoute(page: MonitoringView),
    MaterialRoute(page: ServerMaintenance),
    MaterialRoute(page: NoNetwork),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: PlacesService),
    LazySingleton(classType: MaksimaLocationService),
    LazySingleton(classType: MaksimaMediaService),
    LazySingleton(classType: URLLauncherService),
    LazySingleton(classType: ConnectivityService),
    Singleton(classType: LocalDBService),
    LazySingleton(classType: UserAPI),
    Singleton(
      classType: DioService,
      resolveUsing: DioService.getInstance,
      asType: Dio,
    ),
    LazySingleton(classType: EmployeesAPI),
    LazySingleton(classType: GenerateTokenAPI),
    LazySingleton(classType: MasterAPI),
    LazySingleton(classType: PrakarsaAPI),
    LazySingleton(classType: ScreeningAPI),
    LazySingleton(classType: PerusahaanAPI),
    LazySingleton(classType: PeroranganAPI),
    LazySingleton(classType: LKNAPI),
    LazySingleton(classType: AgunanPokokAPI),
    LazySingleton(classType: AgunanTambahanAPI),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it **/
}
