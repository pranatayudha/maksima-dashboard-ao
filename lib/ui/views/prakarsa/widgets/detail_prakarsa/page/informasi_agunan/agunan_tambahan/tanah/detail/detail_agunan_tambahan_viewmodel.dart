import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_agunan_tambahan_model.dart';
import '../../../../../../../../../../application/models/detail_agunan_tambahan_pembanding_model.dart';
import '../../../../../../../../../../application/models/detail_agunan_tambahan_penilaian_model.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../../application/models/stepper_tab_agunan_model.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';

class DetailAgunanTambahanViewModel extends BaseViewModel with RouteMixin {
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();
  final _masterAPI = locator<MasterAPI>();

  final _dialogService = locator<DialogService>();

  final String prakarsaId;
  final int codeTable;
  final String id;
  final ListAgunanTambahanModel? dataAgunan;

  DetailAgunanTambahanViewModel({
    required this.id,
    required this.prakarsaId,
    required this.codeTable,
    required this.dataAgunan,
  });

  final currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  int index = 0;

  StepperTabAgunanModel? _stepperAgunanTambahan;
  StepperTabAgunanModel? get stepperAgunanTambahan => _stepperAgunanTambahan;

  List<ListAgunanTambahanModel>? _listAgunan;
  List<ListAgunanTambahanModel>? get listAgunan => _listAgunan;
  DetailAgunanTambahanModel? _detailAgunanTambahan;
  DetailAgunanTambahanModel? get detailAgunanTambahan => _detailAgunanTambahan;

  List<String> pathBuktiBayarPBBTerakhir = [];
  String? pathSertifikatKepemilikan;

  String? pathDocKJPP;
  String? pathDocPersetujuanIzinPrinsip;
  String? jenisPenilaian;

  List<String> pathFotoAgunanTambahan = [];

  List<DataPembanding>? _detailAgunanTambahanDataPembanding;

  List<DataPembanding>? get detailAgunanTambahanDataPembanding =>
      _detailAgunanTambahanDataPembanding;

  List<String> pathFotoDataPembanding = [];

  DetailAgunanTambahanPenilaianModel? _detailAgunanTambahanPenilaian;

  DetailAgunanTambahanPenilaianModel? get detailAgunanTambahanPenilaian =>
      _detailAgunanTambahanPenilaian;

  int indexAgunan = 0;

  ListAgunanTambahanModel? selectedDataAgunan;

  void initialize() async {
    await fetchStepperAgunan();
    await fetchAgunanTambahan();
    await fetchDetailAgunanTambahan();
    await fetchDetailAgunanTambahanDataPembanding();
    await fetchDetailAgunanTambahanPenilaian();
  }

  void onChangeIndex(int val) {
    index = val;
    notifyListeners();
  }

  Future fetchDetailAgunanTambahan() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahDetail(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        _detailAgunanTambahan = res;

        pathBuktiBayarPBBTerakhir.clear();
        if (detailAgunanTambahan?.pathBuktiBayarPBBTerakhir != null) {
          for (String element
              in detailAgunanTambahan!.pathBuktiBayarPBBTerakhir!) {
            pathBuktiBayarPBBTerakhir.add(await _getPublicFile(element));
          }
        }

        if (detailAgunanTambahan?.pathSertifikatKepemilikan != null) {
          pathSertifikatKepemilikan = await _getPublicFile(
            detailAgunanTambahan!.pathSertifikatKepemilikan!,
          );
        }
        if (detailAgunanTambahan?.pathDokumenKjpp != null) {
          pathDocKJPP = await _getPublicFile(
            detailAgunanTambahan!.pathDokumenKjpp!,
          );
        }
        if (detailAgunanTambahan?.pathDokumenPersetujuan != null) {
          pathDocPersetujuanIzinPrinsip = await _getPublicFile(
            detailAgunanTambahan!.pathDokumenPersetujuan!,
          );
        }

        pathFotoAgunanTambahan.clear();
        if (detailAgunanTambahan?.pathFotoAgunanTambahan != null) {
          for (PathFotoAgunanTambahan element
              in detailAgunanTambahan!.pathFotoAgunanTambahan!) {
            pathFotoAgunanTambahan.add(
              await _getPublicFile(element.path ?? ''),
            );
          }
        }
      },
    );
    notifyListeners();
  }

  Future fetchStepperAgunan() async {
    final res = await runBusyFuture(
      _agunanTambahanAPI.fetchStepperAgunanTanah(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (l) => null,
      (stepper) {
        _stepperAgunanTambahan = stepper;
        jenisPenilaian = stepper.data?.jenisPenilaian;
        notifyListeners();
      },
    );
  }

  Future fetchDetailAgunanTambahanDataPembanding() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahDataPembanding(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        _detailAgunanTambahanDataPembanding = res?.data;

        pathFotoDataPembanding.clear();
        if (detailAgunanTambahanDataPembanding != null) {
          for (DataPembanding element in detailAgunanTambahanDataPembanding!) {
            pathFotoDataPembanding.add(
              await _getPublicFile(element.pathFoto ?? ''),
            );
          }
        }
      },
    );
    notifyListeners();
  }

  Future fetchDetailAgunanTambahanPenilaian() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahPenilaian(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        _detailAgunanTambahanPenilaian = res;
      },
    );
    notifyListeners();
  }

  Future fetchAgunanTambahan() async {
    final res = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahan(
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (l) => null,
      (response) {
        _listAgunan = response;
        bool isFind = false;
        _listAgunan?.forEach((element) {
          if (!isFind) {
            indexAgunan++;
          }

          if (element.id == id) {
            isFind = true;
            selectedDataAgunan = element;
            selectedDataAgunan?.jenisPenilaian = jenisPenilaian;
          }
        });
      },
    );
    notifyListeners();
  }

  Future deleteAgunanTambahan(int id) async {
    final res = await runBusyFuture(
      _agunanTambahanAPI.deleteAgunanTambahan(
        id: id,
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (l) => null,
      (r) => _showSuccessDialog('Berhasil hapus data Agunan Tambahan').then(
        (_) => navigateBack(),
      ),
    );
    notifyListeners();
  }

  Future _showSuccessDialog(String successMessage) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.success,
      description: successMessage,
      mainButtonTitle: 'OK',
    );
  }

  Future<String> _getPublicFile(String url) async {
    String temp = '';
    final res = await runBusyFuture(
      _masterAPI.getPublicFile(url),
    );

    res.fold(
      (err) => temp = '',
      (success) => temp = success,
    );

    return temp;
  }

  Widget getStatus(int status) {
    if (status > 0) {
      return Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color:
              status == 2 ? CustomColor.stateSuccess : CustomColor.warningText,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Image.asset(
          status == 2 ? IconConstants.iconChecked : IconConstants.iconWarning,
          height: 16,
        ),
      );
    } else {
      return Container(
        height: 16,
        width: 16,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          border: Border.all(color: CustomColor.darkGrey),
        ),
      );
    }
  }
}
