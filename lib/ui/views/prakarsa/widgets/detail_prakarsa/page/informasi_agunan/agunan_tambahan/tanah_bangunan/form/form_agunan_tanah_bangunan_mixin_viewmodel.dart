import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/enums/document_name.dart';
import '../../../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../../../../application/models/postal_code_model.dart';

mixin FormAgunanTanahBangunanMixinViewModel on BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  final jenisPenilaianController = TextEditingController();
  final nameKJPPController = TextEditingController();
  final noLapPenilaianController = TextEditingController();
  final tglLaporanController = TextEditingController();
  final tglPenilaianController = TextEditingController();
  final noPersetujuanIzinController = TextEditingController();
  final tglPersetjuanIzinController = TextEditingController();
  final statusKepemilikanController = TextEditingController();
  final jenisPengikatanController = TextEditingController();
  final luasTanahController = TextEditingController();
  final luasBangunanController = TextEditingController();
  final permukaanTanahController = TextEditingController();
  final bentukTanahController = TextEditingController();
  final bentukBangunanController = TextEditingController();
  final peruntukkanZoningController = TextEditingController();
  final spesifikasiBangunanController = TextEditingController();
  final batasBaratController = TextEditingController();
  final batasUtaraController = TextEditingController();
  final batasTimurController = TextEditingController();
  final batasSelatanController = TextEditingController();
  final noImbController = TextEditingController();
  final tagLocationController = TextEditingController();
  final alamatController = TextEditingController();
  final kodePosController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();
  final jenisSertifikatController = TextEditingController();
  final noJenisSertifikatController = TextEditingController();
  final namaPemilikController = TextEditingController();
  final tglJatuhTempoController = TextEditingController();
  final noSPPTNOPController = TextEditingController();
  final njopController = TextEditingController();
  final njopTanahPerMeterController = TextEditingController();
  final njopBangunanPerMeterController = TextEditingController();

  bool isNotIMBReady = false;
  String selectedLatLng = '0,0';

  PostalCodeModel? postalCode;

  Map<Enum, bool> isLoadDoc = {
    DocName.docKepemilikan: false,
    DocName.docBuktiPBB: false,
    DocName.docIMB: false,
    DocName.docKJPP: false,
    DocName.docIzin: false,
  };

  Map<Enum, String> urlDoc = {
    DocName.docKepemilikan: '',
    DocName.docBuktiPBB: '',
    DocName.docIMB: '',
    DocName.docKJPP: '',
    DocName.docIzin: '',
  };

  Map<Enum, String> urlDocPublic = {
    DocName.docKepemilikan: '',
    DocName.docBuktiPBB: '',
    DocName.docIMB: '',
    DocName.docKJPP: '',
    DocName.docIzin: '',
  };

  List<String> urlFotoAgunanTambahan = [];
  List<FotoKunjunganModel> fotoAgunanTambahanList = [];

  void onChangedJenisPenilaian(String val) {
    jenisPenilaianController.text = val;
    notifyListeners();
  }

  void onSelectedNameKJPP(String val) {
    nameKJPPController.text = val;
    notifyListeners();
  }

  void setTanggalLaporan(String date) => tglLaporanController.text = date;

  void setTanggalPenilaian(String date) => tglPenilaianController.text = date;

  void setTglPersetjuanIzin(String date) => tglPersetjuanIzinController.text = date;

  void setTglJatuhTempo(String date) => tglJatuhTempoController.text = date;

  void onChangedStatusKepemilikan(String val) {
    statusKepemilikanController.text = val;
  }

  void onChangedJenisPengikatan(String val) {
    jenisPengikatanController.text = val;
    notifyListeners();
  }

  void onChangedPermukaanTanah(String val) {
    permukaanTanahController.text = val;
    notifyListeners();
  }

  void onChangedBentukTanah(String val) {
    bentukTanahController.text = val;
    notifyListeners();
  }

  void onChangedBentukBangunan(String val) {
    bentukBangunanController.text = val;
    notifyListeners();
  }

  void onChangedPeruntukkanZoning(String val) {
    peruntukkanZoningController.text = val;
    notifyListeners();
  }

  void onChangedjenisSertifikat(String val) {
    jenisSertifikatController.text = val;
    notifyListeners();
  }

  void onChangedNotIMBReady(bool? value) {
    isNotIMBReady = value!;
    notifyListeners();
  }

  void setTagLocationTanah(data) {
    LatLng tempLatLng = data['latLng'];

    selectedLatLng = '${tempLatLng.latitude}, ${tempLatLng.longitude}';

    tagLocationController
      ..text = data['address']
      ..selection = TextSelection.collapsed(
        offset: tagLocationController.text.length,
      );
  }

  void setKodePos(data) {
    postalCode = data;
    kodePosController
      ..text = '${data.postalCode ?? ''}'
          '${data.province != null ? ', Prov ${data.province}' : ''}'
          '${data.city != null ? ', Kota ${data.city}' : ''}'
          '${data.district != null ? ', Kec. ${data.district}' : ''}'
          '${data.village != null ? ', Kel. ${data.village}' : ''}'
      ..selection = TextSelection.collapsed(
        offset: kodePosController.text.length,
      );
  }

  @override
  void dispose() {
    jenisPenilaianController.dispose();
    nameKJPPController.dispose();
    noLapPenilaianController.dispose();
    tglLaporanController.dispose();
    tglPenilaianController.dispose();
    noPersetujuanIzinController.dispose();
    tglPersetjuanIzinController.dispose();
    statusKepemilikanController.dispose();
    jenisPengikatanController.dispose();
    luasTanahController.dispose();
    luasBangunanController.dispose();
    permukaanTanahController.dispose();
    bentukTanahController.dispose();
    bentukBangunanController.dispose();
    peruntukkanZoningController.dispose();
    spesifikasiBangunanController.dispose();
    batasBaratController.dispose();
    batasUtaraController.dispose();
    batasTimurController.dispose();
    batasSelatanController.dispose();
    noImbController.dispose();
    tagLocationController.dispose();
    alamatController.dispose();
    kodePosController.dispose();
    rtController.dispose();
    rwController.dispose();
    jenisSertifikatController.dispose();
    noJenisSertifikatController.dispose();
    namaPemilikController.dispose();
    tglJatuhTempoController.dispose();
    noSPPTNOPController.dispose();
    njopController.dispose();
    njopTanahPerMeterController.dispose();
    njopBangunanPerMeterController.dispose();
    super.dispose();
  }
}
