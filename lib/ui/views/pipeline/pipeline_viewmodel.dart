import 'package:stacked/stacked.dart';

import '../../../application/mixins/route_mixin.dart';

class PipelineViewModel extends BaseViewModel with RouteMixin {
  void initialize() {
    initialPage('Pipeline');
  }
}
