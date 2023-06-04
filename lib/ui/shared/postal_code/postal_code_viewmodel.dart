import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/models/postal_code_model.dart';
import '../../../infrastructure/apis/master_api.dart';

class PostalCodeViewModel extends BaseViewModel {
  final _masterAPI = locator<MasterAPI>();

  final searchPostalCodeController = TextEditingController();

  List<PostalCodeModel> _listPostalCode = [];
  List<PostalCodeModel> get listPostalCode => _listPostalCode;

  int value = 0;

  Future getPostalCode(
    String postalCode,
  ) async {
    final res =
        await runBusyFuture(_masterAPI.getDetailByPostalCode(postalCode));

    res.fold(
      (error) => debugPrint(error),
      (result) {
        final postalCode = List<PostalCodeModel>.from(
          result.map(
            (i) => PostalCodeModel.fromJson(i as Map<String, dynamic>),
          ),
        );
        _listPostalCode = postalCode;
      },
    );
  }

  void updatePostalCode(String val) async {
    searchPostalCodeController.value.copyWith(
      text: val,
      selection: TextSelection(
        baseOffset: val.length,
        extentOffset: val.length,
      ),
    );
    _listPostalCode.clear();
    getPostalCode(searchPostalCodeController.text);
  }

  void updateValue(int i) {
    value = i;
    notifyListeners();
  }
}
