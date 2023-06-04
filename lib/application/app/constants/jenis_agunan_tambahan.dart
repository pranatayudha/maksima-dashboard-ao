import '../../models/jenis_agunan_tambahan_filter_model.dart';

class JenisAgunanTambahan {
  List<JenisAgunanTambahanFilterModel> filterAgunanTambahan = [
    JenisAgunanTambahanFilterModel(
      value: 'Tanah',
      status: true,
    ),
    JenisAgunanTambahanFilterModel(
      value: 'Tanah dan Bangunan',
      status: true,
    ),
    JenisAgunanTambahanFilterModel(
      value: 'Kendaraan Bermotor',
      status: true,
    ),
    JenisAgunanTambahanFilterModel(
      value: 'Cash Collateral',
      status: true,
    ),
    JenisAgunanTambahanFilterModel(
      value: 'Alat Berat',
      status: false,
    ),
    JenisAgunanTambahanFilterModel(
      value: 'Personal Guarantee',
      status: false,
    ),
    JenisAgunanTambahanFilterModel(
      value: 'Corporate Guarantee',
      status: false,
    ),
  ];
}
