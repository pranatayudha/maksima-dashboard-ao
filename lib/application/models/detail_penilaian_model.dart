class DetailPenilaianModel {
  String? metodePendekatan;
  String? judgementHargaAset;
  String? nPW;
  String? coverageRatioNPW;
  String? nL;
  String? coverageRatioNL;
  String? pNPW;
  String? coverageRatioPNPW;
  String? pNL;
  String? coverageRatioPNL;
  String? nilaiPengikatan;
  String? coverageRatioNilaiPengikatan;
  String? thingsBanksNeedToKnow;
  String? analisaAgunanTambahan;
  String? opiniKJPP;
  String? jenisPenilaian;

  DetailPenilaianModel({
    this.metodePendekatan,
    this.judgementHargaAset,
    this.nPW,
    this.coverageRatioNPW,
    this.nL,
    this.coverageRatioNL,
    this.pNPW,
    this.coverageRatioPNPW,
    this.pNL,
    this.coverageRatioPNL,
    this.nilaiPengikatan,
    this.coverageRatioNilaiPengikatan,
    this.thingsBanksNeedToKnow,
    this.analisaAgunanTambahan,
    this.opiniKJPP,
    this.jenisPenilaian,
  });

  DetailPenilaianModel.fromJson(Map<String, dynamic> json) {
    metodePendekatan = json['metodePendekatan'] as String?;
    judgementHargaAset = json['judgementHargaAset'] as String?;
    nPW = json['NPW'] as String?;
    coverageRatioNPW = json['coverageRatioNPW'] as String?;
    nL = json['NL'] as String?;
    coverageRatioNL = json['coverageRatioNL'] as String?;
    pNPW = json['PNPW'] as String?;
    coverageRatioPNPW = json['coverageRatioPNPW'] as String?;
    pNL = json['PNL'] as String?;
    coverageRatioPNL = json['coverageRatioPNL'] as String?;
    nilaiPengikatan = json['nilaiPengikatan'] as String?;
    coverageRatioNilaiPengikatan =
        json['coverageRatioNilaiPengikatan'] as String?;
    thingsBanksNeedToKnow = json['thingsBanksNeedToKnow'] as String?;
    analisaAgunanTambahan = json['analisaAgunanTambahan'] as String?;
    opiniKJPP = json['opiniKJPP'] as String?;
    jenisPenilaian = json['jenisPenilaian'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['metodePendekatan'] = metodePendekatan;
    json['judgementHargaAset'] = judgementHargaAset;
    json['NPW'] = nPW;
    json['coverageRatioNPW'] = coverageRatioNPW;
    json['NL'] = nL;
    json['coverageRatioNL'] = coverageRatioNL;
    json['PNPW'] = pNPW;
    json['coverageRatioPNPW'] = coverageRatioPNPW;
    json['PNL'] = pNL;
    json['coverageRatioPNL'] = coverageRatioPNL;
    json['nilaiPengikatan'] = nilaiPengikatan;
    json['coverageRatioNilaiPengikatan'] = coverageRatioNilaiPengikatan;
    json['thingsBanksNeedToKnow'] = thingsBanksNeedToKnow;
    json['analisaAgunanTambahan'] = analisaAgunanTambahan;
    json['opiniKJPP'] = opiniKJPP;
    json['jenisPenilaian'] = jenisPenilaian;

    return json;
  }
}
