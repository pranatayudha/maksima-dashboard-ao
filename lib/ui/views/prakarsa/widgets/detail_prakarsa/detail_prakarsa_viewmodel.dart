import 'dart:developer';

import 'package:stacked/stacked.dart';

import '../../../../../application/app/app.locator.dart';
import '../../../../../application/mixins/route_mixin.dart';
import '../../../../../application/models/detail_prakarsa_perorangan.dart';
import '../../../../../application/models/detail_prakarsa_perusahaan.dart';
import '../../../../../application/models/sidebar_detail_model.dart';
import '../../../../../infrastructure/apis/prakarsa_api.dart';

class DetailPrakarsaViewModel extends BaseViewModel with RouteMixin {
  final _prakarsaAPI = locator<PrakarsaAPI>();

  List<SidebarDetailModel> listSidebar = [];
  int indexPage = 1;

  final String prakarsaId;
  final int codeTable;
  final String currentContent;
  DetailPrakarsaViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.currentContent,
  });

  Future initialize() async {
    breadCrum = localDBService.getRoutes();
    selectedPage = currentContent.isEmpty ? 'Screening Awal' : currentContent;
    await _fetchDetailPrakarsa();
    _initSidebar();
  }

  DetailPrakarsaPerorangan? _detailPrakarsaPerorangan;
  DetailPrakarsaPerorangan? get detailPrakarsaPerorangan =>
      _detailPrakarsaPerorangan;

  DetailPrakarsaPerusahaan? _detailPrakarsaPerusahaan;
  DetailPrakarsaPerusahaan? get detailPrakarsaPerusahaan =>
      _detailPrakarsaPerusahaan;

  bool? stepperStatus;

  Future _fetchDetailPrakarsa() async {
    if (codeTable == 1 || codeTable == 4) {
      final res = await runBusyFuture(
        _prakarsaAPI.fetchDetailPrakarsaPerorangan(prakarsaId: prakarsaId),
      );

      res.fold(
        (error) => log('error', name: 'Error Debitur'),
        (detailPrakarsaPerorangan) {
          _detailPrakarsaPerorangan = detailPrakarsaPerorangan;
          notifyListeners();
        },
      );
    } else {
      final res = await runBusyFuture(
        _prakarsaAPI.fetchDetailPrakarsaPerusahaan(prakarsaId: prakarsaId),
      );

      res.fold(
        (error) => log('error', name: 'Error Debitur'),
        (detailPrakarsaPerusahaan) {
          _detailPrakarsaPerusahaan = detailPrakarsaPerusahaan;
          notifyListeners();
        },
      );
    }
  }

  Future refreshStepper() async {
    await _fetchDetailPrakarsa();
    _initSidebar();
  }

  void _initSidebar() {
    if (codeTable == 1 || codeTable == 4) {
      listSidebar = _listPerorangan();
    } else {
      listSidebar = _listPerusahaan();
    }
  }

  List<SidebarDetailModel> _listPerorangan() {
    DetailPrakarsaPerorangan? perorangan = _detailPrakarsaPerorangan;

    return [
      SidebarDetailModel(
        flag: 'INFORMASI DEBITUR',
        menu: [
          Menu(
            title: 'Screening Awal',
            status: perorangan?.stepper?.screeningAwal,
            subMenu: [],
            onTap: () => indexPage = 1,
          ),
          Menu(
            title: 'Laporan Kunjungan Nasabah',
            status: perorangan?.stepper?.laporanKunjunganNasabah,
            subMenu: [],
            onTap: () => indexPage = 2,
          ),
          Menu(
            title: 'Informasi Debitur',
            status: perorangan?.stepper?.informasiDebitur?.parent,
            subMenu: [
              SubMenu(
                title: 'Identitas Diri Debitur',
                status: perorangan?.stepper?.informasiDebitur?.identitasDiri ??
                    false,
              ),
              SubMenu(
                title: 'Info Usaha',
                status:
                    perorangan?.stepper?.informasiDebitur?.infoUsaha ?? false,
              ),
              SubMenu(
                title: 'Izin Usaha',
                status: perorangan?.stepper?.informasiDebitur?.izinUsaha,
              ),
              SubMenu(
                title: 'Dokumen Lainnya',
                status: perorangan?.stepper?.informasiDebitur?.dokumenLainnya,
              ),
            ],
            onTap: () => indexPage = 3,
          ),
        ],
      ),
      SidebarDetailModel(
        flag: 'ANALISA & EVALUASI KREDIT (5C)',
        menu: [
          Menu(
            title: 'Informasi Finansial',
            status: perorangan?.stepper?.informasiFinansial,
            subMenu: [
              SubMenu(
                title: 'Mutasi Rekening',
                status: perorangan?.stepper?.informasiFinansial,
              ),
              SubMenu(
                title: 'Riwayat Proyek',
                status: perorangan?.stepper?.informasiFinansial,
              ),
              SubMenu(
                title: 'Data Laporan Finansial',
                status: perorangan?.stepper?.informasiFinansial,
              ),
              SubMenu(
                title: 'Perhitungan Kebutuhan Kredit',
                status: perorangan?.stepper?.informasiFinansial,
              ),
            ],
            onTap: () => indexPage = 4,
          ),
          Menu(
            title: 'Informasi Agunan',
            status: perorangan?.stepper?.informasiAgunan?.parent,
            subMenu: [
              SubMenu(
                title: 'Agunan Pokok',
                status: perorangan?.stepper?.informasiAgunan?.agunanPokok,
              ),
              SubMenu(
                title: 'Agunan Tambahan',
                status: perorangan?.stepper?.informasiAgunan?.agunanTambahan,
              ),
            ],
            onTap: () => indexPage = 5,
          ),
          Menu(
            title: 'Informasi Non Finansial',
            status: perorangan?.stepper?.informasiNonFinansial,
            subMenu: [],
          ),
          Menu(
            title: 'Screening Akhir',
            status: null,
            subMenu: [],
          ),
        ],
      ),
      SidebarDetailModel(
        flag: 'PERHITUNGAN & REKOMENDASI KREDIT',
        menu: [
          Menu(
            title: 'Perhitungan Kebutuhan Kredit',
            status: null,
            subMenu: [],
          ),
          Menu(
            title: 'Hasil Analisa & Rekomendasi',
            status: null,
            subMenu: [],
          ),
        ],
      ),
    ];
  }

  // ignore: long-method
  List<SidebarDetailModel> _listPerusahaan() {
    DetailPrakarsaPerusahaan? perusahaan = _detailPrakarsaPerusahaan;

    return [
      SidebarDetailModel(
        flag: 'INFORMASI DEBITUR',
        menu: [
          Menu(
            title: 'Screening Awal',
            status: perusahaan?.stepper?.screeningAwal,
            subMenu: [],
            onTap: () => indexPage = 1,
          ),
          Menu(
            title: 'Laporan Kunjungan Nasabah',
            status: perusahaan?.stepper?.laporanKunjunganNasabah,
            subMenu: [],
            onTap: () => indexPage = 2,
          ),
          Menu(
            title: 'Informasi Perusahaan',
            status: perusahaan?.stepper?.informasiPerusahaan?.parent,
            subMenu: [
              SubMenu(
                title: 'Identitas Perusahaan',
                status: perusahaan
                    ?.stepper?.informasiPerusahaan?.identitasPerusahaan,
              ),
              SubMenu(
                title: 'Legalitas Usaha',
                status:
                    perusahaan?.stepper?.informasiPerusahaan?.legalitasUsaha,
              ),
              SubMenu(
                title: 'Izin Usaha',
                status: perusahaan?.stepper?.informasiPerusahaan?.izinUsaha,
              ),
              SubMenu(
                title: 'Dokumen Lainnya',
                status:
                    perusahaan?.stepper?.informasiPerusahaan?.dokumenLainnya,
              ),
            ],
            onTap: () => indexPage = 3,
          ),
          Menu(
            title: 'Informasi Pengurus / Pemilik',
            status: perusahaan?.stepper?.infoPengurus,
            subMenu: [],
            onTap: () => indexPage = 4,
          ),
        ],
      ),
      SidebarDetailModel(
        flag: 'ANALISA & EVALUASI KREDIT (5C)',
        menu: [
          Menu(
            title: 'Informasi Finansial',
            status: perusahaan?.stepper?.informasiFinansial,
            subMenu: [
              SubMenu(
                title: 'Mutasi Rekening',
                status: perusahaan?.stepper?.informasiFinansial,
              ),
              SubMenu(
                title: 'Riwayat Proyek',
                status: perusahaan?.stepper?.informasiFinansial,
              ),
              SubMenu(
                title: 'Data Laporan Finansial',
                status: perusahaan?.stepper?.informasiFinansial,
              ),
              SubMenu(
                title: 'Perhitungan Kebutuhan Kredit',
                status: perusahaan?.stepper?.informasiFinansial,
              ),
            ],
            onTap: () => indexPage = 5,
          ),
          Menu(
            title: 'Informasi Agunan',
            status: perusahaan?.stepper?.informasiAgunan?.parent,
            subMenu: [
              SubMenu(
                title: 'Agunan Pokok',
                status: perusahaan?.stepper?.informasiAgunan?.agunanPokok,
              ),
              SubMenu(
                title: 'Agunan Tambahan',
                status: perusahaan?.stepper?.informasiAgunan?.agunanTambahan,
              ),
            ],
            onTap: () => indexPage = 6,
          ),
          Menu(
            title: 'Informasi Non Finansial',
            status: perusahaan?.stepper?.informasiNonFinansial,
            subMenu: [],
          ),
          Menu(
            title: 'Screening Akhir',
            status: null,
            subMenu: [],
          ),
        ],
      ),
      SidebarDetailModel(
        flag: 'PERHITUNGAN & REKOMENDASI KREDIT',
        menu: [
          Menu(
            title: 'Perhitungan Kebutuhan Kredit',
            status: null,
            subMenu: [],
          ),
          Menu(
            title: 'Hasil Analisa & Rekomendasi',
            status: null,
            subMenu: [],
          ),
        ],
      ),
    ];
  }

  void setContentPage(Map<String, dynamic> value) {
    selectedPage = value['title'];
    stepperStatus = value['status'];
    notifyListeners();
  }
}
