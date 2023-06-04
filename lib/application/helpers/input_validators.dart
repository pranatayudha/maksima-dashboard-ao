import 'package:intl/intl.dart';

import '../app/constants/common.dart';

class InputValidators {
  static String? validateRequiredField(String? value, {String? fieldType}) =>
      value!.isEmpty ? '${fieldType ?? 'Kolom ini'} harus diisi' : null;

  static String? validatePN(String? value) =>
      value!.isEmpty ? 'Personal Number harus diisi' : null;

  static String? validatePassword(String? value) =>
      value!.isEmpty ? 'Password harus diisi' : null;

  static String? validateEmail(String? value) {
    const Pattern pattern =
        r'^\s*(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*$';
    final RegExp regex = RegExp(pattern as String);

    return !regex.hasMatch(value!) ? 'Masukkan Email yang valid' : null;
  }

  static String? validateKTPNumber(String? value, {required String fieldType}) {
    const Pattern pattern = r'^[0-9]{16,16}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? '$fieldType harus diisi'
        : !regex.hasMatch(value)
            ? 'Harus berupa 16 digit angka'
            : null;
  }

  static String? validateName(String? value, {required String fieldType}) {
    const Pattern pattern = r'^[a-z A-Z,.\-]+$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? '$fieldType harus diisi'
        : !regex.hasMatch(value)
            ? 'Tidak boleh mengandung karakter spesial & angka'
            : null;
  }

  static String? validateKtpDate(String? value) {
    const Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Tanggal Terbit E-KTP harus diisi'
        : !regex.hasMatch(value)
            ? 'Format tanggal terbit E-KTP yang valid adalah DD/MM/YYYY'
            : null;
  }

  static String? validateAktaPendirianDate(String? value) {
    const Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Tanggal Akta Pendirian harus diisi'
        : !regex.hasMatch(value)
            ? 'Format tanggal Akta Pendirian yang valid adalah DD/MM/YYYY'
            : null;
  }

  static String? validateBirthDate(String? value) {
    const Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Tanggal Lahir Nasabah harus diisi'
        : !regex.hasMatch(value)
            ? 'Format tanggal lahir yang valid adalah DD/MM/YYYY'
            : null;
  }

  static String? validateTanggalPemenuhanNPWP(String? value) {
    const Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Tanggal Pemenuhan NPWP harus diisi'
        : !regex.hasMatch(value)
            ? 'Format tanggal yang valid adalah DD/MM/YYYY'
            : null;
  }

  static String? validatePostalCode(String? value) {
    const Pattern pattern = r'^[0-9]{5,}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Kode Pos harus diisi'
        : !regex.hasMatch(value)
            ? 'Minimal 5 angka'
            : null;
  }

  static String? validateDependentsOrJobDuration(
    String? value, {
    required String fieldType,
  }) {
    const Pattern pattern = r'^[0-9]{1,2}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? '$fieldType harus diisi'
        : !regex.hasMatch(value)
            ? 'Maximal 2 angka'
            : null;
  }

  static String? validateRTRW(String? value, {required String fieldType}) {
    const Pattern pattern = r'^[0-9]{1,3}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? '$fieldType harus diisi'
        : !regex.hasMatch(value)
            ? 'Maximal 3 angka'
            : null;
  }

  static String? validateMobileNumber(String? value) {
    const Pattern pattern = r'^[1-9][0-9]{8,12}$';

    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'No. Handphone harus diisi'
        : !regex.hasMatch(value)
            ? 'Tanpa angka 0 di depan, min 9 digit & max 13 digit'
            : null;
  }

  static String? validateLocationTravelTime(String? value) {
    const Pattern pattern = r'^[0-9]{0,}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Waktu Tempuh Lokasi Nasabah harus diisi'
        : !regex.hasMatch(value)
            ? 'Harus berupa angka'
            : null;
  }

  static String? validateHarusBerupaAngka(String? value) {
    const Pattern pattern = r'^[0-9]{0,}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Field ini tidak boleh kosong'
        : !regex.hasMatch(value)
            ? 'Harus berupa angka'
            : null;
  }

  static String? validateNPWP(String? value) {
    const Pattern pattern = r'^[0-9,.\-]{15,}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'No. NPWP harus diisi'
        : !regex.hasMatch(value)
            ? 'NPWP harus 15 digit'
            : null;
  }

  static String? validateNominalPinjaman(String? value, int? maxValue) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return value!.isEmpty
        ? 'Nominal Pinjaman harus diisi'
        : maxValue != null
            ? _removeThousandsSeparator(value) > maxValue ||
                    _removeThousandsSeparator(value) >
                        Common.kmkTransaksionalLoanLimit
                ? 'Plafond tidak boleh melebihi Rp. ${formatter.format(maxValue)} dan max ${Common.kmkTransaksionalLoanLimit ~/ 1000000} jt.'
                : null
            : _removeThousandsSeparator(value) < Common.minLoanLimit ||
                    _removeThousandsSeparator(value) > Common.maxLoanLimit
                ? 'Plafond kurang dari ${Common.ritelMinLoanLimit ~/ 1000000} juta.'
                : null;
  }

  static String? validateNominal(String? value, int? maxValue) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return value!.isEmpty
        ? 'Nominal harus diisi'
        : maxValue != null
            ? _removeThousandsSeparator(value) > maxValue
                ? 'Nominal tidak boleh melebihi Rp. ${formatter.format(maxValue)}.'
                : null
            : _removeThousandsSeparator(value) < Common.minLoanLimit ||
                    _removeThousandsSeparator(value) > Common.maxLoanLimit
                ? 'Nominal kurang dari ${Common.ritelMinLoanLimit ~/ 1000000} juta.'
                : null;
  }

  static int _removeThousandsSeparator(String text) {
    final removedThousandsSeparator = text.split('.').join();

    return int.parse(removedThousandsSeparator);
  }

  static String? ritelValidateBirthDate(
    String? value, {
    required String fieldType,
  }) {
    const Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? '$fieldType harus diisi'
        : !regex.hasMatch(value)
            ? 'Format tanggal lahir yang valid adalah DD/MM/YYYY'
            : null;
  }

  static String? validateConfirmationDate(
    String? value, {
    required String fieldType,
  }) {
    const Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? '$fieldType harus diisi'
        : !regex.hasMatch(value)
            ? 'Format tanggal yang valid adalah DD/MM/YYYY'
            : null;
  }

  static String? ritelValidateNPWP(String? value) {
    const Pattern pattern = r'^[0-9]{15,15}$';
    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'No. NPWP harus diisi'
        : !regex.hasMatch(value)
            ? 'NPWP harus 15 digit'
            : null;
  }

  static String? ritelValidateNominalPinjaman(String? value, int? maxValue) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return value!.isEmpty
        ? 'Nominal Pinjaman harus diisi'
        : maxValue != null
            ? _removeThousandsSeparator(value) > maxValue
                ? 'Plafond tidak boleh melebihi Rp. ${formatter.format(maxValue)}.'
                : _removeThousandsSeparator(value) < Common.ritelMinLoanLimit ||
                        _removeThousandsSeparator(value) >
                            Common.ritelMaxLoanLimit
                    ? 'Plafond kurang dari ${Common.ritelMinLoanLimit ~/ 1000000} juta.'
                    : null
            : null;
  }

  static String? ritelValidateRekomendasiPlafond(
    String? value,
    String? maksimalKredit,
    int? maxValue,
  ) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return value!.isEmpty
        ? 'Rekomendasi Plafond harus diisi'
        : _removeThousandsSeparator(value) > maxValue!
            ? 'Plafond tidak boleh melebihi Rp. ${formatter.format(maxValue)}.'
            : _removeThousandsSeparator(value) < Common.ritelMinLoanLimit ||
                    _removeThousandsSeparator(value) > Common.ritelMaxLoanLimit
                ? 'Plafond minimal ${Common.ritelMinLoanLimit ~/ 1000000} juta'
                : _removeThousandsSeparator(value) >
                        _removeThousandsSeparator(maksimalKredit!)
                    ? 'Plafond tidak boleh melebihi nilai maksimal kredit yang dapat diberikan.'
                    : null;
  }

  static String? ritelValidateRekomendasiPlafondPari(
    String? value,
    String? maksimalKredit,
    int? maxValue,
  ) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return value!.isEmpty
        ? 'Rekomendasi Plafond harus diisi'
        : _removeThousandsSeparator(value) > maxValue!
            ? 'Plafond tidak boleh melebihi Rp. ${formatter.format(maxValue)}.'
            : _removeThousandsSeparator(value) >
                    _removeThousandsSeparator(maksimalKredit!)
                ? 'Nilai rekomendasi yang dimasukkan melebihi maksimal kredit yang dapat diberikan'
                : _removeThousandsSeparator(value) <
                            Common.ritelMinLoanLimitPARI ||
                        _removeThousandsSeparator(value) >
                            Common.ritelMaxLoanLimit
                    ? 'Plafond kurang dari ${Common.ritelMinLoanLimitPARI ~/ 1000000} juta.'
                    : null;
    // _removeThousandsSeparator(value) > maxValue!
    //     ? 'Plafond tidak boleh melebihi Rp. ${formatter.format(maxValue)}.'

    // :
  }

  static String? validateBiayaLainnya(
    String? value,
    String name,
  ) {
    return value!.isEmpty ? 'Biaya $name harus diisi' : null;
  }

  static String? validateSDS(String? value) {
    const Pattern pattern = r'^(2[09]|[2-9][0-9])$';

    final RegExp regex = RegExp(pattern as String);

    return value!.isEmpty
        ? 'Sharing Dana Sendiri harus diisi'
        : !regex.hasMatch(value)
            ? 'SDS tidak boleh kurang dari 20%'
            : null;
  }

  static String? validateNominalPembayaranEscrow(
    String? value,
    int? maxValue,
  ) {
    return value!.isEmpty
        ? 'Nominal Pembayaran Ke Rek. Escrow harus diisi'
        : _removeThousandsSeparator(value) < maxValue!
            ? 'Nominal pembayaran tidak sesuai dengan outstanding'
            : null;
  }

  static String? ritelValidateNominalPinjamanPARI(
    String? value,
    int? maxValue,
  ) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return value!.isEmpty
        ? 'Nominal Pinjaman harus diisi'
        : maxValue != null
            ? _removeThousandsSeparator(value) > maxValue
                ? 'Plafond tidak boleh melebihi Rp. ${formatter.format(maxValue)}.'
                : _removeThousandsSeparator(value) <
                            Common.ritelMinLoanLimitPARI ||
                        _removeThousandsSeparator(value) >
                            Common.ritelMaxLoanLimit
                    ? 'Plafond kurang dari ${Common.ritelMinLoanLimitPARI ~/ 1000000} juta.'
                    : null
            : null;
  }
}
