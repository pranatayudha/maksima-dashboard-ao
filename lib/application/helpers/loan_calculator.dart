import 'dart:math';

import '../app/constants/common.dart';

/// RPC -> Untuk membatasi Angsuran Per Bulan (Angsuran Per Bulan harus sama atau di bawah RPC)
/// Suku Bunga per Pembayaran = Suku Bunga per Tahun / 12 * Jangka Waktu / Jumlah Angsuran
/// Angsuran per Pembayaran = (Plafond * Suku Bunga per Pembayaran) / (1 - 1 / (1 + Suku Bunga per Pembayaran)^Jumlah Angsuran)

class LoanCalculator {
  static double sukuBunga({required int plafond, required int tenor}) {
    if (plafond >= 500000 && plafond <= 10000000) {
      return tenor <= 12 ? 0.21 : 0.22;
    } else if (plafond > 10000000 && plafond <= 20000000) {
      return tenor <= 12 ? 0.2 : 0.21;
    } else {
      return tenor <= 12 ? 0.18 : 0.2;
    }
  }

  static int parsePolaAngsuranToInt(String polaAngsuranString) {
    switch (polaAngsuranString) {
      case Common.satuBulanan:
        return 1;
      case Common.tigaBulanan:
        return 3;
      case Common.empatBulanan:
        return 4;
      case Common.enamBulanan:
        return 6;
      case Common.sembilanBulanan:
        return 9;
      case Common.duaBelasBulanan:
        return 12;
      case Common.kmkTransaksional:
        return -1;
      default:
        return 0;
    }
  }

  static String parsePolaAngsuranToString(int polaAngsuranInt) {
    switch (polaAngsuranInt) {
      case 1:
        return Common.satuBulanan;
      case 3:
        return Common.tigaBulanan;
      case 4:
        return Common.empatBulanan;
      case 6:
        return Common.enamBulanan;
      case 9:
        return Common.sembilanBulanan;
      case 12:
        return Common.duaBelasBulanan;
      case -1:
        return Common.kmkTransaksional;
      default:
        return '0';
    }
  }

  static List<String> generateJangkaWaktuPinjamanOptions(int polaAngsuranInt) {
    switch (polaAngsuranInt) {
      case 1:
        return List.generate(12, (index) => (index + 1).toString());
      case 3:
        return List.generate(4, (index) => ((index + 1) * 3).toString());
      case 4:
        return List.generate(3, (index) => ((index + 1) * 4).toString());
      case 6:
        return List.generate(2, (index) => ((index + 1) * 6).toString());
      case 9:
        return List.generate(1, (index) => ((index + 1) * 9).toString());
      case 12:
        return List.generate(1, (index) => ((index + 1) * 12).toString());
      case -1:
        return List.generate(3, (index) => (index + 1).toString());
      default:
        return [];
    }
  }

  static int countAngsuranPerPembayaran(
    int plafond,
    int polaAngsuranInt,
    int tenor,
    double sukuBunga,
  ) {
    final jumlahAngsuran = tenor ~/ polaAngsuranInt;
    final sukuBungaPerBulan = sukuBunga / 12;
    final sukuBungaPerPembayaran = sukuBungaPerBulan * tenor / jumlahAngsuran;
    final angsuranPerPembayaran = (plafond * sukuBungaPerPembayaran) /
        (1 - 1 / pow(1 + sukuBungaPerPembayaran, jumlahAngsuran));

    return angsuranPerPembayaran.toInt();
  }

  static int countTotalPengembalianPinjaman(
    int plafond,
    int polaAngsuran,
    int tenor,
    double sukuBunga,
  ) {
    final jumlahAngsuran = tenor ~/ polaAngsuran;
    final angsuranPerPembayaran =
        countAngsuranPerPembayaran(plafond, polaAngsuran, tenor, sukuBunga);

    return angsuranPerPembayaran * jumlahAngsuran;
  }

  static double countProvisionFee(int jangkaWaktu, int plafond) {
    return (jangkaWaktu / 12) * 0.01 * plafond;
  }

  static double countAdministrationFee(int plafond) {
    if (plafond <= 10000000) {
      return 50000;
    } else if (plafond <= 20000000) {
      return 100000;
    } else if (plafond <= 50000000) {
      return 150000;
    } else if (plafond <= 75000000) {
      return 200000;
    }

    return 250000;
  }
}
