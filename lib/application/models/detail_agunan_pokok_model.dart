import 'detail_lkn.dart';

class DetailAgunanPokokModel {
  String? id;
  String? prakarsaId;
  int? jenisAgunanPokok;
  String? pathUploadExcel;
  String? status;
  String? jenisPengikatan;
  String? nPW;
  String? nL;
  String? pNPW;
  String? pNL;
  String? nilaiPengikatan;
  String? nominalTotalPiutang;
  dynamic jumlahStock;
  dynamic totalNilaiPasarWajarAgunan;
  bool? delFlag;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  dynamic noAgunanCbs;
  dynamic coverNoteNum;
  dynamic dateOfCoverNote;
  dynamic agunanNum;
  dynamic tanggalPengikatanAgunan;
  List<VisitPath>? pathFotoAgunanPersediaan;
  String? analisapokok;
  Rasio? rasio;
  int? stepperPokok;

  DetailAgunanPokokModel({
    this.id,
    this.prakarsaId,
    this.jenisAgunanPokok,
    this.pathUploadExcel,
    this.status,
    this.jenisPengikatan,
    this.nPW,
    this.nL,
    this.pNPW,
    this.pNL,
    this.nilaiPengikatan,
    this.nominalTotalPiutang,
    this.jumlahStock,
    this.totalNilaiPasarWajarAgunan,
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
    this.pathFotoAgunanPersediaan,
    this.analisapokok,
    this.rasio,
    this.stepperPokok,
  });

  DetailAgunanPokokModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    prakarsaId = json['prakarsaId'] as String?;
    jenisAgunanPokok = json['jenisAgunanPokok'] as int?;
    pathUploadExcel = json['pathUploadExcel'] as String?;
    status = json['status'] as String?;
    jenisPengikatan = json['jenisPengikatan'] as String?;
    nPW = json['NPW'] as String?;
    nL = json['NL'] as String?;
    pNPW = json['PNPW'] as String?;
    pNL = json['PNL'] as String?;
    nilaiPengikatan = json['nilaiPengikatan'] as String?;
    nominalTotalPiutang = json['nominalTotalPiutang'] as String?;
    jumlahStock = json['jumlahStock'];
    totalNilaiPasarWajarAgunan = json['totalNilaiPasarWajarAgunan'];
    delFlag = json['delFlag'] as bool?;
    createdAt = json['createdAt'] as String?;
    createdBy = json['createdBy'] as String?;
    updatedAt = json['updatedAt'] as String?;
    updatedBy = json['updatedBy'] as String?;
    noAgunanCbs = json['noAgunan_cbs'];
    coverNoteNum = json['coverNoteNum'];
    dateOfCoverNote = json['dateOfCoverNote'];
    agunanNum = json['agunanNum'];
    tanggalPengikatanAgunan = json['tanggalPengikatanAgunan'];
    if (json['pathFotoAgunanPersediaan'] != null) {
      pathFotoAgunanPersediaan = <VisitPath>[];
      json['pathFotoAgunanPersediaan'].forEach((v) {
        pathFotoAgunanPersediaan!.add(VisitPath.fromJson(v));
      });
    }
    analisapokok = json['analisapokok'] as String?;
    rasio = (json['rasio'] as Map<String, dynamic>?) != null
        ? Rasio.fromJson(json['rasio'] as Map<String, dynamic>)
        : null;
    stepperPokok = json['stepperPokok'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['prakarsaId'] = prakarsaId;
    json['jenisAgunanPokok'] = jenisAgunanPokok;
    json['pathUploadExcel'] = pathUploadExcel;
    json['status'] = status;
    json['jenisPengikatan'] = jenisPengikatan;
    json['NPW'] = nPW;
    json['NL'] = nL;
    json['PNPW'] = pNPW;
    json['PNL'] = pNL;
    json['nilaiPengikatan'] = nilaiPengikatan;
    json['nominalTotalPiutang'] = nominalTotalPiutang;
    json['jumlahStock'] = jumlahStock;
    json['totalNilaiPasarWajarAgunan'] = totalNilaiPasarWajarAgunan;
    json['delFlag'] = delFlag;
    json['createdAt'] = createdAt;
    json['createdBy'] = createdBy;
    json['updatedAt'] = updatedAt;
    json['updatedBy'] = updatedBy;
    json['noAgunan_cbs'] = noAgunanCbs;
    json['coverNoteNum'] = coverNoteNum;
    json['dateOfCoverNote'] = dateOfCoverNote;
    json['agunanNum'] = agunanNum;
    json['tanggalPengikatanAgunan'] = tanggalPengikatanAgunan;
    if (pathFotoAgunanPersediaan != null) {
      json['pathFotoAgunanPersediaan'] =
          pathFotoAgunanPersediaan!.map((v) => v.toJson()).toList();
    }
    json['analisapokok'] = analisapokok;
    json['rasio'] = rasio?.toJson();
    json['stepperPokok'] = stepperPokok;

    return json;
  }
}

class Rasio {
  String? coverageNpw;
  String? coverageNl;
  String? coverangePnPw;
  String? coveragePnl;
  String? coverageNilaiPengikat;

  Rasio({
    this.coverageNpw,
    this.coverageNl,
    this.coverangePnPw,
    this.coveragePnl,
    this.coverageNilaiPengikat,
  });

  Rasio.fromJson(Map<String, dynamic> json) {
    coverageNpw = json['coverageNpw'] as String?;
    coverageNl = json['coverageNl'] as String?;
    coverangePnPw = json['coverangePnPw'] as String?;
    coveragePnl = json['coveragePnl'] as String?;
    coverageNilaiPengikat = json['coverageNilaiPengikat'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['coverageNpw'] = coverageNpw;
    json['coverageNl'] = coverageNl;
    json['coverangePnPw'] = coverangePnPw;
    json['coveragePnl'] = coveragePnl;
    json['coverageNilaiPengikat'] = coverageNilaiPengikat;

    return json;
  }
}
