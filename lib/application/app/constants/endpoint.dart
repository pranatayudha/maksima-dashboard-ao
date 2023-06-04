import '../../../flavors.dart';

class Endpoint {
  static String performaURL = F.variables['baseURL'];
  static String userLoginSSO = '$performaURL/user/login-sso';
  static String userLogoutSSO = '$performaURL/user/logout-sso';
  static String employeesRegister = '$performaURL/employees/register';

  static String generateToken = '/generate-token';
  static String getPublicFile = '/private-files?fileURL=';

  static String maksimaUrlDsbAoPrakarsa = '/dsb-ao/prakarsa';

  static String fetchPrakarsa = '$maksimaUrlDsbAoPrakarsa/list?';
  static String fetchDetailDebitur = '$maksimaUrlDsbAoPrakarsa/detail-debitur/';
  static String fetchDetailPrakarsa =
      '$maksimaUrlDsbAoPrakarsa/detail-prakarsa/';
  static String fetchScreening = '$maksimaUrlDsbAoPrakarsa/screening/';

  static String urlLkn = '$maksimaUrlDsbAoPrakarsa/lkn-';
  static String urlIdentitasPerusahaan =
      '$maksimaUrlDsbAoPrakarsa/info-perusahaan-';
  static String urlLegalitasUsaha = '$maksimaUrlDsbAoPrakarsa/legalitas-usaha-';
  static String urlIzinUsaha = '$maksimaUrlDsbAoPrakarsa/izin-usaha/';
  static String urlDokumenLainnya = '$maksimaUrlDsbAoPrakarsa/dokumen-lainnya/';
  static String fetchInfoPengurus = '$maksimaUrlDsbAoPrakarsa/info-pengurus';
  static String updateInfoPengurus = '$maksimaUrlDsbAoPrakarsa/info-pengurus';
  static String urlIdentitasPerorangan =
      '$maksimaUrlDsbAoPrakarsa/info-debitur';
  static String urlInfoUsahaPerorangan = '$maksimaUrlDsbAoPrakarsa/info-usaha';
  static String urlAgunanPokok = '/prakarsa/agunan-pokok/';
  static String urlDsbAgunanPokok = '/dsb-ao/prakarsa/agunan-pokok/';
  static String urlListAgunanTambahan = '/prakarsa/agunan-tambahan/list/';
  static String urlAgunanTambahan = '/prakarsa/agunan-tambahan';
  static String urlDeleteAgunanTambahan = '/prakarsa/agunan-tambahan/delete';
  static String urlListAgunanTambahanTanahBangunan =
      '/prakarsa/agunan-tambahan/tanah-bangunan/pembanding/list';
}
