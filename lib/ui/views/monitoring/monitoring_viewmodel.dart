import 'package:stacked/stacked.dart';

import '../../../application/mixins/route_mixin.dart';

class MonitoringViewModel extends BaseViewModel with RouteMixin {
  void initialize() {
    initialPage('Monitoring');
  }
}
