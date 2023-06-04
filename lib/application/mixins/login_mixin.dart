import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../infrastructure/apis/user_api.dart';
import '../../flavors.dart';
import '../../infrastructure/apis/generate_token_api.dart';
import '../app/app.router.dart';
import '../models/user.dart';
import '../services/local_db_service.dart';

mixin LoginMixin on BaseViewModel {
  final navigationService = locator<NavigationService>();
  final localDBService = locator<LocalDBService>();
  final _userAPI = locator<UserAPI>();
  final _generateTokenAPI = locator<GenerateTokenAPI>();
  final personalNumberController = TextEditingController();
  final passwordController = TextEditingController();
  String messageError = '';

  Future login() async {
    messageError = '';

    final response = await runBusyFuture(
      _userAPI.loginSSO(
        userId: personalNumberController.text,
        password: passwordController.text,
        ipAddress: F.variables['ipAddress'] as String,
      ),
    );

    response.fold(
      (errorMessage) {
        messageError = errorMessage;
      },
      (user) async {
        if (user.accessLevel != '10') {
          messageError =
              'Mohon maaf, Pinang Maksima hanya dapat diakses oleh RM (Relation Manager) yang sudah dimapping saja.';

          await _logout(user);
        } else {
          final responseMaksimaToken = await runBusyFuture(
            _generateTokenAPI.generateToken(
              user: user,
            ),
          );

          responseMaksimaToken.fold(
            (err) async {
              messageError = err;

              await _logout(user);
            },
            (success) async {
              localDBService.storeUser(user);
              navigationService.clearStackAndShow(Routes.mainView);
            },
          );
        }
      },
    );
  }

  Future _logout(User user) async {
    localDBService.storeUser(user);

    final resLogout = await runBusyFuture(
      _userAPI.logoutSSO(
        userId: user.userId,
        loginTicket: user.loginTicket,
      ),
    );

    resLogout.fold((l) => null, (r) => localDBService.removeUser());
  }
}
