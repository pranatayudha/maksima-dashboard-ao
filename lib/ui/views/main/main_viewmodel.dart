// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/enums/dialog_type.dart';
import '../../../application/models/user.dart';
import '../../../application/services/local_db_service.dart';
import '../../../infrastructure/apis/user_api.dart';

class MainViewModel extends BaseViewModel {
  final _localDBService = locator<LocalDBService>();
  final _dialogService = locator<DialogService>();
  final _userAPI = locator<UserAPI>();

  User? _user;
  User? get user => _user;

  int selectedPage = 2; //initial page prakarsa

  Future initialize() async {
    _user = _localDBService.getUser();
  }

  Future logout() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Konfirmasi',
      description: 'Apakah Anda yakin ingin keluar dari aplikasi ini?',
      mainButtonTitle: 'LOG OUT',
    );

    if (response!.confirmed) {
      final logoutResponse = await runBusyFuture(
        _userAPI.logoutSSO(
          userId: user!.userId,
          loginTicket: user!.loginTicket,
        ),
      );

      logoutResponse.fold(
        (errorMessage) => _showLogoutErrorDialog(errorMessage),
        (success) async {
          await removeLocalDB().then(
            (value) => Timer(
              const Duration(seconds: 3),
              () => html.window.location.reload(),
            ),
          );
        },
      );
    }
  }

  Future _showLogoutErrorDialog(String errorMessage) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.error,
      title: 'Logout Gagal',
      description: errorMessage,
      mainButtonTitle: 'COBA LAGI',
    );
  }

  Future<dynamic> removeLocalDB() async {
    await _localDBService.removeUser();
    await _localDBService.removeToken();
    await _localDBService.removeRoutes();
  }

  void updateSelectedPage(int index) {
    selectedPage = index;
    notifyListeners();
  }
}
