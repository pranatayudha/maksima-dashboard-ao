class DetailAgunanTambahanModel {
  String? id;
  String? prakarsaId;
  String? jenisPengikatan;
  String? luasTanah;
  String? addressesId;
  String? nOP;
  String? jenisSertifikat;
  String? numSertifikat;
  String? namaPemilik;
  String? jatuhTempo;
  List<String>? pathBuktiBayarPBBTerakhir;
  List<PathFotoAgunanTambahan>? pathFotoAgunanTambahan;
  String? pathDataPembanding;
  bool? delFlag;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  int? noAgunanCbs;
  int? coverNoteNum;
  int? dateOfCoverNote;
  int? agunanNum;
  String? tanggalPengikatanAgunan;
  String? jenisAgunanTambahan;
  String? jenisPenilaian;
  String? statusKepemilikan;
  String? permukaanTanah;
  String? bentukTanah;
  String? batasBarat;
  String? batasUtara;
  String? batasTimur;
  String? batasSelatan;
  String? alamatSesuaiSertifikat;
  String? nJOP;
  String? nJOPm2;
  String? pathSertifikatKepemilikan;
  String? namaKjpp;
  String? nomorPenilaian;
  String? tanggalLaporan;
  String? tanggalPenilaian;
  String? pathDokumenKjpp;
  String? nomorPersetujuanIzinPrinsip;
  String? tanggalPersetujuanIzinPrinsip;
  String? pathDokumenPersetujuan;
  int? stepperUmumTambahanTanah;
  TagLocation? tagLocation;
  String? detail;
  String? postalCode;
  String? province;
  String? city;
  String? district;
  String? village;
  String? rt;
  String? rw;
  String? bentukBangunan;
  bool? isNotIMBReady;
  String? luasBangunan;
  String? njopBangunanM2;
  String? njopTanahM2;
  String? numIMB;
  String? numResiIMB;
  String? pathDokumenIMB;
  String? peruntukan;
  String? spesifikasiBangunan;
  int? stepperUmumTambahanTanahBangunan;

  DetailAgunanTambahanModel({
    this.id,
    this.prakarsaId,
    this.jenisPengikatan,
    this.luasTanah,
    this.addressesId,
    this.nOP,
    this.jenisSertifikat,
    this.numSertifikat,
    this.namaPemilik,
    this.jatuhTempo,
    this.pathBuktiBayarPBBTerakhir,
    this.pathFotoAgunanTambahan,
    this.pathDataPembanding,
    this.delFlag,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.noAgunanCbs,
    this.coverNoteNum,
    this.dateOfCoverNote,
    this.agunanNum,
    this.tanggalPengikatanAgunan,
    this.jenisAgunanTambahan,
    this.jenisPenilaian,
    this.statusKepemilikan,
    this.permukaanTanah,
    this.bentukTanah,
    this.batasBarat,
    this.batasUtara,
    this.batasTimur,
    this.batasSelatan,
    this.alamatSesuaiSertifikat,
    this.nJOP,
    this.nJOPm2,
    this.pathSertifikatKepemilikan,
    this.namaKjpp,
    this.nomorPenilaian,
    this.tanggalLaporan,
    this.tanggalPenilaian,
    this.pathDokumenKjpp,
    this.nomorPersetujuanIzinPrinsip,
    this.tanggalPersetujuanIzinPrinsip,
    this.pathDokumenPersetujuan,
    this.stepperUmumTambahanTanah,
    this.tagLocation,
    this.detail,
    this.postalCode,
    this.province,
    this.city,
    this.district,
    this.village,
    this.rt,
    this.rw,
    this.bentukBangunan,
    this.isNotIMBReady,
    this.luasBangunan,
    this.njopBangunanM2,
    this.njopTanahM2,
    this.numIMB,
    this.numResiIMB,
    this.pathDokumenIMB,
    this.peruntukan,
    this.spesifikasiBangunan,
    this.stepperUmumTambahanTanahBangunan,
  });

  DetailAgunanTambahanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prakarsaId = json['prakarsaId'];
    jenisPengikatan = json['jenisPengikatan'];
    luasTanah = json['luasTanah'].toString();
    addressesId = json['addressesId'];
    nOP = json['NOP'];
    jenisSertifikat = json['jenisSertifikat'];
    numSertifikat = json['numSertifikat'];
    namaPemilik = json['namaPemilik'];
    jatuhTempo = json['jatuhTempo'];
    pathBuktiBayarPBBTerakhir =
        json['pathBuktiBayarPBBTerakhir'].cast<String>();
    pathFotoAgunanTambahan = (json['pathFotoAgunanTambahan'] as List?)
        ?.map(
          (dynamic e) => (e is Map) ?
              PathFotoAgunanTambahan.fromJson(e as Map<String, dynamic>) : PathFotoAgunanTambahan(path: e),
        )
        .toList();
    pathDataPembanding = json['pathDataPembanding'];
    delFlag = json['delFlag'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    noAgunanCbs = json['noAgunan_cbs'];
    coverNoteNum = json['coverNoteNum'];
    dateOfCoverNote = json['dateOfCoverNote'];
    agunanNum = json['agunanNum'];
    tanggalPengikatanAgunan = json['tanggalPengikatanAgunan'];
    jenisAgunanTambahan = json['jenisAgunanTambahan'];
    jenisPenilaian = json['jenisPenilaian'];
    statusKepemilikan = json['statusKepemilikan'];
    permukaanTanah = json['permukaanTanah'];
    bentukTanah = json['bentukTanah'];
    batasBarat = json['batasBarat'];
    batasUtara = json['batasUtara'];
    batasTimur = json['batasTimur'];
    batasSelatan = json['batasSelatan'];
    alamatSesuaiSertifikat = json['alamatSesuaiSertifikat'];
    nJOP = json['NJOP'] != null ? '${json['NJOP']}' : null;
    nJOPm2 = json.containsKey('NJOPm2') ? json['NJOPm2'].toString() : null;
    pathSertifikatKepemilikan = json['pathSertifikatKepemilikan'];
    namaKjpp = json['namaKjpp'];
    nomorPenilaian = json['nomorPenilaian'];
    tanggalLaporan = json['tanggalLaporan'];
    tanggalPenilaian = json['tanggalPenilaian'];
    pathDokumenKjpp = json['pathDokumenKjpp'];
    nomorPersetujuanIzinPrinsip = json['nomorPersetujuanIzinPrinsip'];
    tanggalPersetujuanIzinPrinsip = json['tanggalPersetujuanIzinPrinsip'];
    pathDokumenPersetujuan = json['pathDokumenPersetujuan'];
    stepperUmumTambahanTanah = json.containsKey('stepper_umum_tambahan_tanah') ? json['stepper_umum_tambahan_tanah'] : null;
    tagLocation = json['tagLocation'] != null
        ? TagLocation.fromJson(json['tagLocation'])
        : null;
    detail = json['detail'];
    postalCode = json['postalCode'];
    province = json['province'];
    city = json['city'];
    district = json['district'];
    village = json['village'];
    rt = json['rt'];
    rw = json['rw'];
    bentukBangunan = json.containsKey('bentukBangunan') ? json['bentukBangunan'] : null;
    isNotIMBReady = json.containsKey('isNotIMBReady') ? json['isNotIMBReady'] : null;
    luasBangunan = json.containsKey('luasBangunan') ? json['luasBangunan'].toString() : null;
    njopBangunanM2 = json.containsKey('NJOPBangunanM2') ? json['NJOPBangunanM2'].toString() : null;
    njopTanahM2 = json.containsKey('NJOPTanahM2') ? json['NJOPTanahM2'].toString() : null;
    numIMB = json.containsKey('numIMB') ? json['numIMB'] : null;
    numResiIMB = json.containsKey('numResiIMB') ? json['numResiIMB'] : null;
    pathDokumenIMB = json.containsKey('pathDokumenIMB') ? json['pathDokumenIMB'] : null;
    peruntukan = json.containsKey('peruntukan') ? json['peruntukan'] :null;
    spesifikasiBangunan = json.containsKey('spesifikasiBangunan') ? json['spesifikasiBangunan'] : null;
    stepperUmumTambahanTanahBangunan = json.containsKey('stepper_umum_tambahan_tanah_bangunan') ? json['stepper_umum_tambahan_tanah_bangunan'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['prakarsaId'] = prakarsaId;
    data['jenisPengikatan'] = jenisPengikatan;
    data['luasTanah'] = luasTanah;
    data['addressesId'] = addressesId;
    data['NOP'] = nOP;
    data['jenisSertifikat'] = jenisSertifikat;
    data['numSertifikat'] = numSertifikat;
    data['namaPemilik'] = namaPemilik;
    data['jatuhTempo'] = jatuhTempo;
    data['pathBuktiBayarPBBTerakhir'] = pathBuktiBayarPBBTerakhir;
    data['pathFotoAgunanTambahan'] =
        pathFotoAgunanTambahan?.map((e) => e.toJson()).toList();
    data['pathDataPembanding'] = pathDataPembanding;
    data['delFlag'] = delFlag;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['noAgunan_cbs'] = noAgunanCbs;
    data['coverNoteNum'] = coverNoteNum;
    data['dateOfCoverNote'] = dateOfCoverNote;
    data['agunanNum'] = agunanNum;
    data['tanggalPengikatanAgunan'] = tanggalPengikatanAgunan;
    data['jenisAgunanTambahan'] = jenisAgunanTambahan;
    data['jenisPenilaian'] = jenisPenilaian;
    data['statusKepemilikan'] = statusKepemilikan;
    data['permukaanTanah'] = permukaanTanah;
    data['bentukTanah'] = bentukTanah;
    data['batasBarat'] = batasBarat;
    data['batasUtara'] = batasUtara;
    data['batasTimur'] = batasTimur;
    data['batasSelatan'] = batasSelatan;
    data['alamatSesuaiSertifikat'] = alamatSesuaiSertifikat;
    data['NJOP'] = nJOP;
    data['NJOPm2'] = nJOPm2;
    data['pathSertifikatKepemilikan'] = pathSertifikatKepemilikan;
    data['namaKjpp'] = namaKjpp;
    data['nomorPenilaian'] = nomorPenilaian;
    data['tanggalLaporan'] = tanggalLaporan;
    data['tanggalPenilaian'] = tanggalPenilaian;
    data['pathDokumenKjpp'] = pathDokumenKjpp;
    data['nomorPersetujuanIzinPrinsip'] = nomorPersetujuanIzinPrinsip;
    data['tanggalPersetujuanIzinPrinsip'] = tanggalPersetujuanIzinPrinsip;
    data['pathDokumenPersetujuan'] = pathDokumenPersetujuan;
    data['stepper_umum_tambahan_tanah'] = stepperUmumTambahanTanah;
    if (tagLocation != null) {
      data['tagLocation'] = tagLocation!.toJson();
    }
    data['detail'] = detail;
    data['postalCode'] = postalCode;
    data['province'] = province;
    data['city'] = city;
    data['district'] = district;
    data['village'] = village;
    data['rt'] = rt;
    data['rw'] = rw;
    data['bentukBangunan'] = bentukBangunan;
    data['isNotIMBReady'] = isNotIMBReady;
    data['luasBangunan'] = luasBangunan;
    data['NJOPBangunanM2'] = njopBangunanM2;
    data['NJOPTanahM2'] = njopTanahM2;
    data['numIMB'] = numIMB;
    data['numResiIMB'] = numResiIMB;
    data['pathDokumenIMB'] = pathDokumenIMB;
    data['peruntukan'] = peruntukan;
    data['spesifikasiBangunan'] = spesifikasiBangunan;
    data['stepper_umum_tambahan_tanah_bangunan'] = stepperUmumTambahanTanahBangunan;

    return data;
  }
}

class TagLocation {
  String? latLng;
  String? name;

  TagLocation({this.latLng, this.name});

  TagLocation.fromJson(Map<String, dynamic> json) {
    latLng = json['latLng'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latLng'] = latLng;
    data['name'] = name;
    // ignore: newline-before-return
    return data;
  }
}

class PathFotoAgunanTambahan {
  String? path;
  String? photoName;
  TagLocation? tagLocation;

  PathFotoAgunanTambahan({
    this.path,
    this.photoName,
    this.tagLocation,
  });

  PathFotoAgunanTambahan.fromJson(Map<String, dynamic> json) {
    path = json['path'] as String?;
    photoName = json['photoName'] as String?;
    tagLocation = (json['tagLocation'] as Map<String, dynamic>?) != null
        ? TagLocation.fromJson(json['tagLocation'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['path'] = path;
    json['photoName'] = photoName;
    json['tagLocation'] = tagLocation?.toJson();

    return json;
  }
}
