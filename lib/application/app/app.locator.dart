// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:dio/src/dio.dart';
import 'package:places_service/src/places_service.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';

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
import '../services/connectivity_service.dart';
import '../services/dio_service.dart';
import '../services/local_db_service.dart';
import '../services/location_service.dart';
import '../services/media_service.dart';
import '../services/url_launcher_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => PlacesService());
  locator.registerLazySingleton(() => MaksimaLocationService());
  locator.registerLazySingleton(() => MaksimaMediaService());
  locator.registerLazySingleton(() => URLLauncherService());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerSingleton(LocalDBService());
  locator.registerLazySingleton(() => UserAPI());
  locator.registerSingleton<Dio>(DioService.getInstance());
  locator.registerLazySingleton(() => EmployeesAPI());
  locator.registerLazySingleton(() => GenerateTokenAPI());
  locator.registerLazySingleton(() => MasterAPI());
  locator.registerLazySingleton(() => PrakarsaAPI());
  locator.registerLazySingleton(() => ScreeningAPI());
  locator.registerLazySingleton(() => PerusahaanAPI());
  locator.registerLazySingleton(() => PeroranganAPI());
  locator.registerLazySingleton(() => LKNAPI());
  locator.registerLazySingleton(() => AgunanPokokAPI());
  locator.registerLazySingleton(() => AgunanTambahanAPI());
}
