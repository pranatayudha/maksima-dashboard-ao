import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../application/app/app.locator.dart';
import '../../../../../application/app/constants/icon_constants.dart';
import '../../../../../application/helpers/status_prakarsa_int_formatter.dart';
import '../../../../../application/mixins/route_mixin.dart';
import '../../../../../application/models/header_table_model.dart';
import '../../../../../application/models/info_card_model.dart';
import '../../../../../application/models/prakarsa_list_model.dart';
import '../../../../../application/models/search_parameters_model.dart';
import '../../../../../infrastructure/apis/prakarsa_api.dart';
import '../../../../shared/item_table_prakarsa.dart';

class PrakarsaListViewModel extends BaseViewModel with RouteMixin {
  final PrakarsaAPI _ritelPrakarsaAPI = locator<PrakarsaAPI>();

  TextEditingController searchController = TextEditingController();
  TextEditingController loanTypeFileterController = TextEditingController();
  TextEditingController submissionStatusFilterController =
      TextEditingController();

  bool isSearch = false;
  bool isAscNameDebitur = false;
  bool isAscLoanAmount = false;
  bool isAscDateSub = false;

  List<PrakarsaListModel> _ritelPrakarsa = [];

  List<PrakarsaListModel> get ritelPrakarsa => _ritelPrakarsa;

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

  List<HeaderTableModel> listHeader = [];

  void getHeaderTable() {
    listHeader = [
      HeaderTableModel(
        title: 'Nama Debitur',
        onTap: sortingDebiturName,
      ),
      HeaderTableModel(
        title: 'Nominal Pengajuan',
        onTap: sortingLoanAmount,
      ),
      HeaderTableModel(
        title: 'Tgl Pengajuan',
        onTap: sortingDateSub,
      ),
      HeaderTableModel(
        title: 'Jenis Kredit',
      ),
      HeaderTableModel(
        title: 'Bentuk Usaha',
      ),
      HeaderTableModel(
        title: 'Status Pengajuan',
      ),
    ];
  }

  List<Widget> content = [];

  void initialise() async {
    getHeaderTable();
    await fetchPrakarsa();
    // await fetchPrakarsa();
  }

  String errMsg = '';
  int currentPage = 0;
  int lastPage = 0;
  int totalData = 0;
  int limit = 10;

  Future fetchPrakarsa() async {
    final res = await runBusyFuture(
      _ritelPrakarsaAPI.fetchPrakarsa(
        key: SearchParametersModel(
          name: searchController.text,
          limit: limit,
          page: currentPage,
          loanTypeId: loanTypeFileterController.text.isNotEmpty
              ? StatusPrakarsaIntFormatter.getLoanTypeId(
                  loanTypeFileterController.text,
                )
              : '',
          status: submissionStatusFilterController.text.isNotEmpty
              ? StatusPrakarsaIntFormatter.getStatusId(
                  submissionStatusFilterController.text,
                )
              : '',
        ),
      ),
    );

    res.fold(
      (errorMessage) {
        _ritelPrakarsa = [];
        lastPage = 0;
        totalData = 0;
      },
      (response) {
        _ritelPrakarsa = response.data ?? [];
        currentPage = response.meta?.currentPage ?? 0;
        lastPage = response.meta?.lastPage ?? 0;
        totalData = response.meta?.totalData ?? 0;
        limit = response.meta?.size ?? 0;
      },
    );
    generatePrakarsaWidget(_ritelPrakarsa);
  }

  void onSearchName(String value) async {
    searchController.text = value;
    notifyListeners();
    await fetchPrakarsa();
  }

  void onFilterLoanType(String value) async {
    loanTypeFileterController.text = value;
    notifyListeners();
    await fetchPrakarsa();
  }

  void onFilterStatus(String value) async {
    submissionStatusFilterController.text = value;
    notifyListeners();
    await fetchPrakarsa();
  }

  void generatePrakarsaWidget(List<PrakarsaListModel> listPrakarsa) {
    content = List.generate(
      listPrakarsa.length,
      (index) => ItemTablePrakarsa(
        isLast: index == listPrakarsa.length - 1,
        prakarsaData: listPrakarsa[index],
      ),
    );
    notifyListeners();
  }

  void sortingDebiturName() {
    if (isAscNameDebitur) {
      _ritelPrakarsa.sort(
        (a, b) => (b.titlePipeline ?? '').compareTo(a.titlePipeline ?? ''),
      );
    } else {
      _ritelPrakarsa.sort(
        (a, b) => (a.titlePipeline ?? '').compareTo(b.titlePipeline ?? ''),
      );
    }
    isAscNameDebitur = !isAscNameDebitur;
    generatePrakarsaWidget(_ritelPrakarsa);
  }

  void sortingLoanAmount() {
    if (isAscLoanAmount) {
      _ritelPrakarsa.sort(
        (a, b) => (b.loanAmount ?? '').compareTo(a.loanAmount ?? ''),
      );
    } else {
      _ritelPrakarsa.sort(
        (a, b) => (a.loanAmount ?? '').compareTo(b.loanAmount ?? ''),
      );
    }
    isAscLoanAmount = !isAscLoanAmount;
    generatePrakarsaWidget(_ritelPrakarsa);
  }

  void sortingDateSub() {
    if (isAscDateSub) {
      _ritelPrakarsa.sort(
        (a, b) => (b.submissionDate ?? '').compareTo(a.submissionDate ?? ''),
      );
    } else {
      _ritelPrakarsa.sort(
        (a, b) => (a.submissionDate ?? '').compareTo(b.submissionDate ?? ''),
      );
    }
    isAscDateSub = !isAscDateSub;
    generatePrakarsaWidget(_ritelPrakarsa);
  }

  void pagingNavigation(int index) async {
    currentPage = index;
    notifyListeners();
    await fetchPrakarsa();
  }

  String prakarsaId = '';
  int codeTable = 0;
  String initial = '';
  String name = '';
  String loanAmount = '';
  String pipelineId = '';
  void getIdByIndex(int index) {
    prakarsaId = _ritelPrakarsa[index].prakarsaId ?? '';
    codeTable = _ritelPrakarsa[index].codeTable ?? 0;
    initial = _ritelPrakarsa[index].initial ?? '';
    name = _ritelPrakarsa[index].titlePipeline ?? '';
    loanAmount = _ritelPrakarsa[index].loanAmount ?? '';
    pipelineId = _ritelPrakarsa[index].pipelinesId ?? '';
    notifyListeners();
  }
}
