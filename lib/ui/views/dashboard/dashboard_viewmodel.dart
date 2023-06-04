import 'package:stacked/stacked.dart';

import '../../../application/mixins/route_mixin.dart';

class DashboardViewModel extends BaseViewModel with RouteMixin {
  Future initialize() async {
    initialPage('Dashboard');
  }
}
