import 'package:stacked/stacked.dart';

import '../../../application/app/constants/icon_constants.dart';
import '../../../application/app/constants/page_route.dart';
import '../../../application/mixins/route_mixin.dart';
import '../../../application/models/info_card_model.dart';

class PrakarsaViewModel extends BaseViewModel with RouteMixin {
  List<InfoCardModel> listInfoCardPrakarsa = [
    InfoCardModel(
      title: 'Belum Lengkap',
      icon: IconConstants.time,
      value: '50',
    ),
    InfoCardModel(
      title: 'Verifikasi OPK',
      icon: IconConstants.fileColor,
      value: '50',
    ),
    InfoCardModel(
      title: 'Putusan',
      icon: IconConstants.check,
      value: '50',
    ),
    InfoCardModel(
      title: 'Tolak',
      icon: IconConstants.ignore,
      value: '50',
    ),
  ];

  void initialize() {
    initialPage(ConstantPageRoute.prakarsaPage);
    setCurrentPrakarsaPage('');
  }

  String generateBreadCrum() {
    String route = '';
    for (int i = 0; i < (breadCrum?.length ?? 0); i++) {
      route =
          route + (i == 0 ? (breadCrum?[i] ?? '') : '/${breadCrum?[i] ?? ''}');
    }

    return route;
  }

  String prakarsaId = '';
  int codeTable = 0;
  String initial = '';
  String name = '';
  String loanAmount = '';
  String pipelineId = '';
  String? currentPrakarsaPage = '';

  void setValuePrakarsa(Map<String, dynamic> data) {
    prakarsaId = data['prakarsaId'];
    codeTable = data['codeTable'];
    initial = data['initial'];
    name = data['name'];
    loanAmount = data['loanAmount'];
    pipelineId = data['pipelineId'];
    notifyListeners();
  }

  dynamic temporary;
  void setTemporaryValue(dynamic temp) {
    temporary = temp;
    notifyListeners();
  }

  void setCurrentPrakarsaPage(String val) {
    currentPrakarsaPage = val;
    notifyListeners();
  }
}
