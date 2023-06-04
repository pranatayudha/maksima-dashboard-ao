// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/app/app.router.dart';
import '../../../application/mixins/login_mixin.dart';
import '../../../application/services/connectivity_service.dart';
import '../../../flavors.dart';

class StartupViewModel extends BaseViewModel with LoginMixin {
  final _placesService = locator<PlacesService>();
  final _connectivityService = locator<ConnectivityService>();

  Future runStartupLogic() async {
    final connectivityResult = await _connectivityService.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      navigationService.replaceWith(Routes.noNetwork);
    } else {
      _placesService.initialize(
        apiKey: Flavor == Flavor.LOCAL
            ? F.sharedMap['googleAPIKeyLocal'] as String
            : F.sharedMap['googleAPIKey'] as String,
      );

      final hasUser = localDBService.userBoxIsNotEmpty();

      if (hasUser) {
        await setTimeout(
          callback: navigationService.clearStackAndShow(Routes.mainView),
        );
      } else {
        await setTimeout(
          callback: navigationService.clearStackAndShow(Routes.loginView),
        );
      }
    }
  }

  Future<void> setTimeout({required callback}) async {
    Timer(
      const Duration(seconds: 5),
      () async => await callback,
    );
  }
}
