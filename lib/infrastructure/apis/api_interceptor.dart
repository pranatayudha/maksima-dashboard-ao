import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../flavors.dart';
import '../../application/app/app.locator.dart';
import '../../application/app/app.router.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/enums/dialog_type.dart';
import '../../application/services/local_db_service.dart';
import 'user_api.dart';

class ApiInterceptor extends InterceptorsWrapper {
  final _navigationService = locator<NavigationService>();
  final _localDBService = locator<LocalDBService>();
  final _userAPI = locator<UserAPI>();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final bool isServerMaintenance = await _checkTime();

    if (!isServerMaintenance) {
      if (options.path == Endpoint.generateToken) {
        options.headers['Authorization'] = F.variables['maksimaBasicAuth'];
      } else {
        final token = locator<LocalDBService>().getToken();
        options.headers['Authorization'] = 'Bearer $token';
        options.headers['keyid'] = _localDBService.getUser()?.userId;
      }
      super.onRequest(options, handler);
    } else {
      _navigationService.clearStackAndShow(Routes.serverMaintenance);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response!.statusCode == 401 || err.response!.statusCode == 403) {
      _showUnauthorizedDialog();
    }

    super.onError(err, handler);
  }

  Future _showUnauthorizedDialog() async {
    await locator<DialogService>().showCustomDialog(
      variant: DialogType.base,
      title: 'Unauthorized',
      description:
          'Mohon maaf, permintaan Anda tidak bisa dipenuhi saat ini, silahkan login ulang.',
      mainButtonTitle: 'OK',
    );

    _navigationService.back();

    await _userAPI.logoutSSO(
      userId: _localDBService.getUser()?.userId,
      loginTicket: _localDBService.getUser()?.loginTicket,
    );

    _removeUserAndTokenInLocalDB();
    locator<NavigationService>().clearStackAndShow(Routes.loginView);
  }

  void _removeUserAndTokenInLocalDB() {
    _localDBService.removeUser();
    _localDBService.removeToken();
  }

  Future<bool> _checkTime() async {
    final now = DateTime.now();
    final nameOfDay = DateFormat('EEEE').format(now);

    if (F.appFlavor == Flavor.PROD) {
      if (nameOfDay == 'Monday' ||
          nameOfDay == 'Tuesday' ||
          nameOfDay == 'Wednesday' ||
          nameOfDay == 'Thursday') {
        if (now.hour >= 23 || now.hour < 5) {
          return true;
        }
      } else if (nameOfDay == 'Friday' ||
          nameOfDay == 'Saturday' ||
          nameOfDay == 'Sunday') {
        if (now.hour >= 21 || now.hour < 5) {
          return true;
        }
      }
    }

    return false;
  }
}
