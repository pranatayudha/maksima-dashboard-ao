class DetailLegalitas {
  String? pipelinesId;
  String? deedEstNum;
  String? dateOfDeedEst;
  String? placeOfDeedEst;
  String? skKumhamNum;
  String? dateOfSkKumham;
  String? notaryName;
  String? notaryPosition;
  String? deedEstPath;
  String? skKumhamPath;
  String? deedEstFileName;
  String? skKumhamFileName;
  List<DeedOthers>? deedOthers;

  DetailLegalitas({
    this.pipelinesId,
    this.deedEstNum,
    this.dateOfDeedEst,
    this.placeOfDeedEst,
    this.skKumhamNum,
    this.dateOfSkKumham,
    this.notaryName,
    this.notaryPosition,
    this.deedEstPath,
    this.skKumhamPath,
    this.deedEstFileName,
    this.skKumhamFileName,
    this.deedOthers,
  });

  DetailLegalitas.fromJson(Map<String, dynamic> json) {
    pipelinesId = json['pipelinesId'];
    deedEstNum = json['deedEstNum'];
    dateOfDeedEst = json['dateOfDeedEst'];
    placeOfDeedEst = json['placeOfDeedEst'];
    skKumhamNum = json['skKumhamNum'];
    dateOfSkKumham = json['dateOfSkKumham'];
    notaryName = json['notaryName'];
    notaryPosition = json['notaryPosition'];
    deedEstPath = json['deedEstPath'];
    skKumhamPath = json['skKumhamPath'];
    deedEstFileName = json['deedEstFileName'];
    skKumhamFileName = json['skKumhamFileName'];
    if (json['deedOthers'] != null) {
      deedOthers = <DeedOthers>[];
      json['deedOthers'].forEach((v) {
        deedOthers!.add(DeedOthers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pipelinesId'] = pipelinesId;
    data['deedEstNum'] = deedEstNum;
    data['dateOfDeedEst'] = dateOfDeedEst;
    data['placeOfDeedEst'] = placeOfDeedEst;
    data['skKumhamNum'] = skKumhamNum;
    data['dateOfSkKumham'] = dateOfSkKumham;
    data['notaryName'] = notaryName;
    data['notaryPosition'] = notaryPosition;
    data['deedEstPath'] = deedEstPath;
    data['skKumhamPath'] = skKumhamPath;
    data['deedEstFileName'] = deedEstFileName;
    data['skKumhamFileName'] = skKumhamFileName;
    if (deedOthers != null) {
      data['deedOthers'] = deedOthers!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class DeedOthers {
  String? pipelinesId;
  String? deedEstNum;
  String? dateOfDeedEst;
  String? placeOfDeedEst;
  String? skKumhamNum;
  String? dateOfSkKumham;
  String? notaryName;
  String? notaryPosition;
  String? deedEstFilePath;
  String? skKumhamFilePath;
  String? deedEstFileName;
  String? skKumhamFileName;

  DeedOthers({
    this.pipelinesId,
    this.deedEstNum,
    this.dateOfDeedEst,
    this.placeOfDeedEst,
    this.skKumhamNum,
    this.dateOfSkKumham,
    this.notaryName,
    this.notaryPosition,
    this.deedEstFilePath,
    this.skKumhamFilePath,
    this.deedEstFileName,
    this.skKumhamFileName,
  });

  DeedOthers.fromJson(Map<String, dynamic> json) {
    pipelinesId = json['pipelinesId'];
    deedEstNum = json['deedEstNum'];
    dateOfDeedEst = json['dateOfDeedEst'];
    placeOfDeedEst = json['placeOfDeedEst'];
    skKumhamNum = json['skKumhamNum'];
    dateOfSkKumham = json['dateOfSkKumham'];
    notaryName = json['notaryName'];
    notaryPosition = json['notaryPosition'];
    deedEstFilePath = json['deedEstFilePath'];
    skKumhamFilePath = json['skKumhamFilePath'];
    deedEstFileName = json['deedEstFileName'];
    skKumhamFileName = json['skKumhamFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pipelinesId'] = pipelinesId;
    data['deedEstNum'] = deedEstNum;
    data['dateOfDeedEst'] = dateOfDeedEst;
    data['placeOfDeedEst'] = placeOfDeedEst;
    data['skKumhamNum'] = skKumhamNum;
    data['dateOfSkKumham'] = dateOfSkKumham;
    data['notaryName'] = notaryName;
    data['notaryPosition'] = notaryPosition;
    data['deedEstFilePath'] = deedEstFilePath;
    data['skKumhamFilePath'] = skKumhamFilePath;
    data['deedEstFileName'] = deedEstFileName;
    data['skKumhamFileName'] = skKumhamFileName;

    return data;
  }
}
