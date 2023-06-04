import 'package:hive/hive.dart';

import '../../application/models/user.dart';

class HiveDB {
  static Future init() async {
    Hive.registerAdapter(UserAdapter());

    await Hive.openBox<User>('userBox');
    await Hive.openBox<String>('tokenBox');
    await Hive.openBox<String>('routesBox');
  }
}
