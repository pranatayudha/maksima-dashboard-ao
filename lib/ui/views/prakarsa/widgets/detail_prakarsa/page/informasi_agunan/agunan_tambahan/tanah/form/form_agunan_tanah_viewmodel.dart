import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/models/detail_agunan_tambahan_model.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';

class FormAgunanTanahViewModel extends BaseViewModel {
  TextEditingController selectedValue = TextEditingController();
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();

  final String id;
  final String prakarsaId;

  FormAgunanTanahViewModel({
    required this.prakarsaId,
    required this.id,
  });

  DetailAgunanTambahanModel? _detailAgunanTambahan;
  DetailAgunanTambahanModel? get detailAgunanTambahan => _detailAgunanTambahan;

  bool isLoading = false;

  void initialize() async {
    if (id.isNotEmpty) {
      setLoading(true);
      await fetchDetailAgunanTambahan();
      setLoading(false);
    }
  }

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future fetchDetailAgunanTambahan() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahDetail(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    response.fold(
      (l) => null,
      (res) {
        _detailAgunanTambahan = res;
        setSelectedValue(_detailAgunanTambahan?.jenisPenilaian ?? '');
      },
    );
    notifyListeners();
  }

  void setSelectedValue(String value) {
    selectedValue.text = value;
    notifyListeners();
  }
}
