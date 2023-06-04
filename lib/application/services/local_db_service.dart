import 'package:hive/hive.dart';

import '../models/user.dart';

class LocalDBService {
  final userBox = Hive.box<User>('userBox');
  final tokenBox = Hive.box<String>('tokenBox');
  final routesBox = Hive.box<String>('routesBox');

  List<String>? breadCrum = [];

  // User related
  void storeUser(User user) => userBox.add(user);

  void replaceUser(User user) => userBox.putAt(0, user);

  User? getUser() => userBox.getAt(0);

  Future removeUser() async => await userBox.clear();

  bool userBoxIsNotEmpty() => userBox.isNotEmpty;

  // Token related
  void storeToken(String token) => tokenBox.add(token);

  String? getToken() => tokenBox.getAt(0);

  Future removeToken() async => await tokenBox.clear();

  // Routes related
  void storeRoutes(String route) => routesBox.add(route);

  Future removeRoutes() async => await routesBox.clear();

  void backRoutes() => routesBox.deleteAt(routesBox.length - 1);

  String? currentRoutes() {
    if (routesBox.isNotEmpty) {
      return routesBox.getAt(routesBox.length - 1);
    } else {
      return '';
    }
  }

  List<String>? getRoutes() =>
      List.generate(routesBox.length, (index) => routesBox.getAt(index) ?? '');

  String generateBreadCrum() {
    breadCrum = getRoutes();
    String route = '';
    for (int i = 0; i < (breadCrum?.length ?? 0); i++) {
      route = route +
          (i == 0 ? (breadCrum?[i] ?? '') : ' / ${breadCrum?[i] ?? ''}');
    }

    return route;
  }

  bool routesIsNotEmpty() => routesBox.isNotEmpty;

  void navigateWithKey(String route) {
    bool routeIsFound = false;

    breadCrum = getRoutes();

    for (int i = (breadCrum?.length ?? 0); i >= 1; i--) {
      if (!routeIsFound && (breadCrum?[i - 1] ?? '') == route) {
        routeIsFound = true;
      }
      if (!routeIsFound) {
        routesBox.deleteAt(i - 1);
      }
    }
  }

  void deleteRoute() {
    breadCrum = getRoutes();
    for (int i = 0; i < (breadCrum?.length ?? 0); i++) {
      routesBox.deleteAt(0);
    }
  }
}
