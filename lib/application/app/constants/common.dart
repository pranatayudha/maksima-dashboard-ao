// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

class Common {
  static _CodeTable CodeTable = _CodeTable();

  static const kawin = 'Kawin';
  static const belumKawin = 'Belum Kawin';
  static const ceraiHidup = 'Cerai Hidup';
  static const ceraiMati = 'Cerai Mati';
  static const semuaPartner = 'Semua Partner';
  static const semuaDalamProses = 'Semua Dalam Proses';
  static const melengkapiDataPreScreening = 'Melengkapi Data Pre-Screening';
  static const preScreeningError = 'Pre-Screening Error';
  static const menungguHasilPreScreening = 'Menunggu Hasil Pre-Screening';
  static const preScreeningDitolak = 'Pre-Screening Ditolak';
  static const preScreeningDisetujui = 'Pre-Screening Disetujui';
  static const melengkapiDataAnalisaPinjaman =
      'Melengkapi Data Analisa Pinjaman';
  static const menungguPutusan = 'Menunggu Putusan';
  static const prakarsaDisetujuiMintaPersetujuanNasabah =
      'Prakarsa Disetujui, Minta Persetujuan Nasabah';
  static const prosesAkadKredit = 'Proses Akad Kredit';
  static const prosesPencairan = 'Proses Pencairan';
  static const prakarsaDitolak = 'Prakarsa Ditolak';
  static const prakarsaDisetujuiTetapiDitolakNasabah =
      'Prakarsa Disetujui, Tetapi Ditolak Nasabah';
  static const pencairanBerhasil = 'Pencairan Berhasil';
  static const prakarsaDitolakNasabah = 'Prakarsa Ditolak Nasabah';
  static const prakarsaDikembalikan = 'Prakarsa Dikembalikan';
  static const bulanan = 'Bulanan';
  static const musiman = 'Musiman';
  static const kmkTransaksional = 'KMK Transaksional';
  static const pinangPariMaksimaPrk = 'Pinang Maksima - KMK PRK Pinang PARI';
  static const kmkPTR = 'KMK - PTR';
  static const transaksionalPreFinancing = 'Transaksional Pre Financing';
  static const transaksionalPostFinancing = 'Transaksional Post Financing';
  static const tanahTanpaBangunan = 'Tanah Tanpa Bangunan';
  static const tanahDanBangunan = 'Tanah Dan Bangunan';
  static const kendaraan = 'Kendaraan';
  static const persediaan = 'Persediaan';
  static const piutangDagang = 'Piutang Dagang';
  static const lainnya = 'Lainnya';
  static const tanpaAgunan = 'Tanpa Agunan';
  static const shm = 'SHM';
  static const aktaJualBeli = 'Akta Jual Beli';
  static const girikPetokDLetterC = 'Girik/Petok D/Letter C';
  static const shgbShguShp = 'SHGB/SHGU/SHP';
  static const bpkb = 'BPKB';
  static const pinangMikro = 'Pinang Mikro';
  static const kmkAngsuranTetap = 'KMK Angsuran Tetap';
  static const kiAngsuranTetap = 'KI Angsuran Tetap';
  static const satuBulanan = '1 Bulanan';
  static const tigaBulanan = '3 Bulanan';
  static const empatBulanan = '4 Bulanan';
  static const enamBulanan = '6 Bulanan';
  static const sembilanBulanan = '9 Bulanan';
  static const duaBelasBulanan = '12 Bulanan';
  static const askrindo = 'Askrindo';
  static const kbruSimasInsurtech = 'KBRU - Simas Insurtech';
  static const brismaJamkrida = 'BRISMA - Jamkrida';
  static const berdasarkanPlafonKredit = 'Berdasarkan Plafon Kredit';
  static const statusBarHeightDiff = 24.0;
  static const callCentrePhoneNumber = '1500494';
  static const humasBankRayaEmail = 'humas@bankraya.co.id';

  static const sdsKMKLimit = 30;
  static const debtToEquityRatioLimit = 150;
  static const roeLimit = 0;
  static const roiLimit = 0;
  static const roaLimit = 0;
  static const nwcPositifLimit = 0;
  static const minLoanLimit = 500000;
  static const maxLoanLimit = 100000000;
  static const ritelMinLoanLimit = 100000000;
  static const ritelMinLoanLimitPARI = 500000000;
  static const ritelMaxLoanLimit = 10000000000;

  static const kmkTransaksionalLoanLimit = 50000000;

  static const dioErrorTypeOtherMessage =
      'Oops! Sesuatu telah terjadi. Jangan khawatir, kami sedang menanganinya. Kami akan segera kembali melayani Anda.';
  static const dioErrorTypeConnectionTimeoutMessage = 'Connection timeout.';
  static const statusCode400Message =
      '400 Bad Request: This indicates that the server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).';
  static const statusCode404Message =
      "404 Not Found: This indicates that the server can't find the requested resource";
  static const statusCode500Message =
      '500 Internal Server Error: This indicates that the server encountered an unexpected condition that prevented it from fulfilling the request.';
  static const statusCode502Message =
      '502 Bad Gateway: This indicates that the server, while acting as a gateway or proxy, received an invalid response from the upstream server.';

  static const sideMenuPrakarsaPerusahaan = [
    'Screening Awal',
    'Laporan Kunjungan Nasabah',
    'Identitas Perusahaan',
    'Legalitas Usaha',
    'Informasi Pengurus / Pemilik',
    'Izin Usaha',
    'Dokumen Lainnya',
  ];

  static const sideMenuPrakarsaPerorangan = [
    'Screening Awal',
    'Laporan Kunjungan Nasabah',
    'Identitas Diri Debitur',
    'Info Usaha',
    'Izin Usaha',
    'Dokumen Lainnya',
  ];

  static const jabatan = [
    'Direktur',
    'Kadiv Bisnis',
    'Wakadiv Bisnis',
    'Kabag Bisnis',
    'Pinca / CBL',
    'Wapinca',
    'RM Pusat',
  ];

  static const posisiPIC = [
    'Pemilik, Direktur',
    'Pemilik, Direktur',
    'Pemilik, Komisaris Utama/Presiden Kom.',
    'Pemilik, Komisaris',
    'Pemilik, Kuasa Direksi',
    'Pemilik, Bukan Pengurus',
    'Pemilik, Grup',
    'Pemilik, Masyarakat',
    'Pemilik, Ketua Umum',
    'Pemilik, Ketua',
    'Pemilik, Sekretaris',
    'Pemilik, Bendahara',
    'Pengurus, Direktur Utama/Presiden Dir.',
    'Pengurus, Direktur',
    'Pengurus, Komisaris Utama/Presiden Kom',
    'Pengurus, Komisaris',
    'Pengurus, Kuasa Direksi',
    'Pengurus, Grup',
    'Pengurus, Ketua Umum',
    'Pengurus, Ketua',
    'Pengurus, Sekretaris',
    'Pengurus, Bendahara',
    'Pengurus, Lainnya',
  ];

  static const jenisDokumenIzinUsaha = [
    'NIB',
    'TDP',
    'SIUP',
  ];

  static const List<String> namaKJJPRekananList = [
    'KJPP TOHA OKKY HERU & REKAN',
    'KJPP HARI UTOMO & REKAN',
    'KJPP ROMULO CHARLIE & REKAN',
    'KJPP DAMIANUS AMBUR & REKAN',
    'KJPP AYON SUHERMAN & REKAN',
    'KJPP RUKY, SAFRUDIN & REKAN',
    'KJPP AREYANTI, JUNITA & REKAN',
    'KJPP AGUS, ALI, FIRDAUS & REKAN',
    'KJPP DASA\'AT, YUDISTIRA & REKAN',
    'KJPP FEBRIMAN SIREGAR & REKAN',
    'KJPP MUTTAQIN BAMBANG PURWANTO ROZAK USWATUN & REKAN',
    'KJPP RIJA HUSAENI & REKAN',
    'KJPP JIMMY PRASETYO & REKAN',
    'KJPP HERLY, ARIAWAN & REKAN',
    'KJPP NIRBOYO ADIPUTRO, DWI APRIYANTI & REKAN',
    'KJPP RINALDI ALBERTH BAROTO & REKAN',
    'KJPP SAPTO, KASMODIARD & REKAN',
    'KJPP SUGENG, IRWAN, GUNAWAN & REKAN',
    'KJPP YUSRIZAL, HENRY, RUSLI & REKAN',
    'KJPP WISNU JUNAIDI & REKAN',
    'KJPP SATRIA ISKANDAR SETIAWAN & REKAN',
  ];

  static const List<String> jenisPenilaianList = [
    'Penilaian Internal',
    'Penilaian KJPP Rekanan',
    'Penilaian KJPP non Rekanan',
  ];

  static const List<String> jenisPenilaianKJPPList = [
    'Penilaian KJPP Rekanan',
    'Penilaian KJPP non Rekanan',
  ];

  static const List<String> jenisPenilaianKJPPNonList = [
    'Penilaian KJPP non Rekanan',
  ];

  static const List<String> statusKepemilikanList = [
    'Milik Sendiri',
    'Milik Pengurus Pemilik',
  ];

  static const List<String> jenisPengikatanList = [
    'HT 1',
    'HT 2',
    'HT 3',
    'HT 4',
  ];

  static const List<String> permukaanTanahList = [
    'Rata',
    'Bergelombang',
    'Landai',
  ];

  static const List<String> bentukTanahList = [
    'Segitiga',
    'Segiempat',
    'Trapesium',
    'Tidak Beraturan',
  ];

  static const List<String> bentukBangunanList = [
    'Tidak Bertingkat',
    'Bertingkat',
  ];

  static const List<String> peruntukkanZoningList = [
    'Perdagangan',
    'Perkantoran',
    'Pemukiman',
    'Industri',
    'Penduduk',
  ];

  static const List<String> jenisSertifikatList = [
    'SHM',
    'SHGB',
    'SHGU',
    'SHMSRS',
  ];

  static const List<String> jenisSertifikatTanahList = [
    'SHM',
    'SHGB',
    'SHGU',
  ];
}

class _CodeTable {
  final int Perorangan = 1;
  final int CV = 2;
  final int PT = 3;
  final int PARI = 4;

  final Map<int, String> names = {
    1: 'Perorangan',
    2: 'CV',
    3: 'PT',
    4: 'PARI',
  };
}
