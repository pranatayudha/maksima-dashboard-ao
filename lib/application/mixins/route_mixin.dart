import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/constants/page_route.dart';
import '../enums/dialog_type.dart';
import '../models/prakarsa_list_model.dart';
import '../services/local_db_service.dart';

mixin RouteMixin on BaseViewModel {
  final localDBService = locator<LocalDBService>();
  final _dialogService = locator<DialogService>();

  PrakarsaListModel? selectedPrakarsa;
  List<String>? breadCrum = [];
  String selectedPage = '';

  void initialPage(String route) {
    localDBService.deleteRoute();
    if (!localDBService.routesIsNotEmpty()) {
      navigateTo(route);
    }
  }

  void navigateTo(String route) {
    localDBService.storeRoutes(route);
    updateBreadCrum();
  }

  void backAction() {
    localDBService.backRoutes();
    updateBreadCrum();
  }

  void backWithKey(String route) {
    localDBService.navigateWithKey(route);
    updateBreadCrum();
  }

  void updateBreadCrum() {
    breadCrum = localDBService.getRoutes();
    notifyListeners();
  }

  void navigateBack({bool isPassed = false}) {
    if (isEditableForm() && !isPassed) {
      _showConfirmDialog(false, '');
    } else {
      backAction();
    }
  }

  void navigateBackByKey(String route) {
    if (isEditableForm()) {
      _showConfirmDialog(true, route);
    } else {
      backWithKey(route);
    }
  }

  Future _showConfirmDialog(bool isWithKey, String route) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Data yang diisi akan hilang',
      description: 'Apakah anda yakin akan meninggalkan halaman ini?',
      mainButtonTitle: 'Tinggalkan Halaman',
      secondaryButtonTitle: 'Kembali',
      data: {
        'secondary': false,
        'main': true,
      },
    );

    if (response?.confirmed ?? false) {
      isWithKey ? backWithKey(route) : backAction();
    }
  }

  bool isEditableForm() {
    return ConstantPageRoute.editableForm
        .contains(localDBService.currentRoutes());
  }
}
