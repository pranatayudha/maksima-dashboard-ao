import 'package:intl/intl.dart';
import 'package:pinang_maksima_dashboard_ao/application/mixins/route_mixin.dart';
import 'package:pinang_maksima_dashboard_ao/application/models/list_agunan_tambahan_model.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/enums/document_name.dart';
import '../../../../../../../../../../application/models/detail_agunan_tambahan_model.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_tanah_bangunan_pembanding_response_model/list_agunan_tambahan_tanah_bangunan_pembanding_response_model.dart';
import '../../../../../../../../../../application/models/stepper_tab_agunan_model.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';

class DetailAgunanTanahBangunanViewModel extends BaseViewModel with RouteMixin {
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();
  final _masterAPI = locator<MasterAPI>();

  StepperTabAgunanModel? _stepperAgunanTambahan;

  StepperTabAgunanModel? get stepperAgunanTambahan => _stepperAgunanTambahan;

  DetailAgunanTambahanModel? _detailAgunanTambahan;
  DetailAgunanTambahanModel? get detailAgunanTambahan => _detailAgunanTambahan;

  final String prakarsaId;
  final int codeTable;
  final String id;

  int index = 0;

  String? _jenisPenilaian;
  String? get jenisPenilaian => _jenisPenilaian;

  Map<Enum, String> urlDoc = {
    DocName.docKepemilikan: '',
    DocName.docIMB: '',
    DocName.docKJPP: '',
    DocName.docIzin: '',
  };

  final currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  List<String> pathBuktiBayarPBBTerakhir = [];
  List<String> pathFotoAgunanTambahan = [];

  List<ListAgunanTambahanTanahBangunanPembandingResponseModel>
      listAgunanTambahanTanahBangunanPembandingResponseModel = [];
  List<String> pathFotoTanahBangunanDataPembanding = [];

  DetailAgunanTanahBangunanViewModel({
    required this.id,
    required this.prakarsaId,
    required this.codeTable,
    ListAgunanTambahanModel? dataAgunan,
  });

  void initialize() async {
    await _fetchStepperAgunan();
    await _fetchDetailAgunanTambahan();
  }

  void onChangeIndex(int val) {
    index = val;
    notifyListeners();
  }

  void onPressedUbahData() {}

  Future<void> _fetchStepperAgunan() async {
    final res = await runBusyFuture(
      _agunanTambahanAPI.fetchStepperAgunanTanah(
        jenisAgunan: 'tanah-bangunan',
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    res.fold(
      (l) => null,
      (stepper) {
        _stepperAgunanTambahan = stepper;
        _jenisPenilaian = stepper.data?.jenisPenilaian;
        notifyListeners();
      },
    );
  }

  Future _fetchDetailAgunanTambahan() async {
    final res = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahDetail(
        id: int.parse(id),
        prakarsaId: prakarsaId,
        codeTable: 'tanah bangunan',
      ),
    );

    res.fold(
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

        if (detailAgunanTambahan?.pathDokumenIMB != null) {
          urlDoc[DocName.docIMB] = await _getPublicFile(
            detailAgunanTambahan!.pathDokumenIMB!,
          );
        }

        if (detailAgunanTambahan?.pathSertifikatKepemilikan != null) {
          urlDoc[DocName.docKepemilikan] = await _getPublicFile(
            detailAgunanTambahan!.pathSertifikatKepemilikan!,
          );
        }

        if (detailAgunanTambahan?.pathDokumenKjpp != null) {
          urlDoc[DocName.docKJPP] = await _getPublicFile(
            detailAgunanTambahan!.pathDokumenKjpp!,
          );
        }

        if (detailAgunanTambahan?.pathDokumenPersetujuan != null) {
          urlDoc[DocName.docIzin] = await _getPublicFile(
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

  Future fetchDetailAgunanTambahanTanahBangunanDataPembanding() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchListAgunanTambahanTanahBangunanDataPembanding(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        listAgunanTambahanTanahBangunanPembandingResponseModel = res.data ?? [];

        pathFotoTanahBangunanDataPembanding.clear();
        if (listAgunanTambahanTanahBangunanPembandingResponseModel.isNotEmpty) {
          for (var element
              in listAgunanTambahanTanahBangunanPembandingResponseModel) {
            element.pathFoto?.forEach((pathImage) async {
              pathFotoTanahBangunanDataPembanding.add(
                await _getPublicFile(pathImage.path ?? ''),
              );
            });
          }
        }
      },
    );
    notifyListeners();
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
}
