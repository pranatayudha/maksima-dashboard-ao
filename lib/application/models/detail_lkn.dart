class DetailLKN {
  String? name;
  DataLkn? dataLkn;
  String? status;

  DetailLKN({this.name, this.dataLkn, this.status});

  DetailLKN.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dataLkn =
        json['dataLkn'] != null ? DataLkn.fromJson(json['dataLkn']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (dataLkn != null) {
      data['dataLkn'] = dataLkn!.toJson();
    }
    data['status'] = status;

    return data;
  }
}

class DataLkn {
  String? prakarsaId;
  String? id;
  String? cbName;
  String? pipelinesId;
  int? codeTable;
  String? cbId;
  String? etaToCB;
  String? loanTypeId;
  String? loanAmount;
  TagLocation? tagLocation;
  String? dateOfVisit;
  String? visitResult;
  List<VisitPath>? visitPath;
  String? purposeVisit;
  String? ratingPARI;
  String? frekuensiTransaksi;
  String? nameOfficer;
  String? nameOfficerOther;
  String? position;
  String? divisionOfficer;
  String? positionOther;
  String? divisionOfficerOther;
  String? followUpPlan;

  DataLkn({
    this.prakarsaId,
    this.id,
    this.pipelinesId,
    this.codeTable,
    this.cbId,
    this.cbName,
    this.etaToCB,
    this.loanTypeId,
    this.loanAmount,
    this.tagLocation,
    this.dateOfVisit,
    this.visitResult,
    this.visitPath,
    this.purposeVisit,
    this.ratingPARI,
    this.frekuensiTransaksi,
    this.nameOfficer,
    this.nameOfficerOther,
    this.position,
    this.divisionOfficer,
    this.positionOther,
    this.divisionOfficerOther,
    this.followUpPlan,
  });

  DataLkn.fromJson(Map<String, dynamic> json) {
    prakarsaId = json['prakarsaId'];
    id = json['id'];
    pipelinesId = json['pipelinesId'];
    codeTable = json['codeTable'];
    cbId = json['community_branchesId'];
    cbName = json['cbName'];
    etaToCB = json['etaToCB'];
    loanTypeId = json['loan_typesId'];
    purposeVisit = json['purposeVisit'];
    ratingPARI = json['ratingPARI'];
    frekuensiTransaksi = json['transactionFrequency'];
    nameOfficer = json['nameOfficer'];
    nameOfficerOther = json['nameOfficerOther'];
    position = json['position'];
    divisionOfficer = json['divisionOfficer'];
    positionOther = json['positionOther'];
    divisionOfficerOther = json['divisionOfficerOther'];
    followUpPlan = json['followUpPlan'];

    loanAmount = json['loanAmount'];
    tagLocation = json['tagLocation'] != null
        ? TagLocation.fromJson(json['tagLocation'])
        : null;
    dateOfVisit = json['dateOfVisit'];
    visitResult = json['visitResult'];
    if (json['visitPath'] != null) {
      visitPath = <VisitPath>[];
      json['visitPath'].forEach((v) {
        visitPath!.add(VisitPath.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prakarsaId'] = prakarsaId;
    data['id'] = id;
    data['pipelinesId'] = pipelinesId;
    data['codeTable'] = codeTable;
    data['community_branchesId'] = cbId;
    data['cbName'] = cbName;
    data['etaToCB'] = etaToCB;
    data['loan_typesId'] = loanTypeId;
    data['loanAmount'] = loanAmount;
    if (tagLocation != null) {
      data['tagLocation'] = tagLocation!.toJson();
    }
    data['dateOfVisit'] = dateOfVisit;
    data['visitResult'] = visitResult;
    if (visitPath != null) {
      data['visitPath'] = visitPath!.map((v) => v.toJson()).toList();
    }
    data['purposeVisit'] = purposeVisit;
    data['ratingPARI'] = ratingPARI;
    data['transactionFrequency'] = frekuensiTransaksi;
    data['nameOfficer'] = nameOfficer;
    data['nameOfficerOther'] = nameOfficerOther;
    data['position'] = position;
    data['divisionOfficer'] = divisionOfficer;
    data['positionOther'] = positionOther;
    data['divisionOfficerOther'] = divisionOfficerOther;
    data['followUpPlan'] = followUpPlan;

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

    return data;
  }
}

class VisitPath {
  String? path;
  Meta? meta;

  VisitPath({this.path, this.meta});

  VisitPath.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }

    return data;
  }
}

class Meta {
  String? photoName;
  String? timeName;
  LocationDetail? locationDetail;

  Meta({this.photoName, this.locationDetail});

  Meta.fromJson(Map<String, dynamic> json) {
    photoName = json['photoName'];
    timeName = json['timeName'];
    locationDetail = json['locationDetail'] != null
        ? LocationDetail.fromJson(json['locationDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photoName'] = photoName;
    data['timeName'] = timeName;
    if (locationDetail != null) {
      data['locationDetail'] = locationDetail!.toJson();
    }

    return data;
  }
}

class LocationDetail {
  String? latLng;
  String? name;

  LocationDetail({this.latLng, this.name});

  LocationDetail.fromJson(Map<String, dynamic> json) {
    latLng = json['latLng'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latLng'] = latLng;
    data['name'] = name;

    return data;
  }
}
