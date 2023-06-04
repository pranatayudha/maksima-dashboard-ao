class DetailIdentitasPerusahaan {
  String? id;
  String? pipelineFlagId;
  String? companyName;
  String? companyNpwpNum;
  String? economySectorId;
  String? economySectorName;
  String? economySubSectorId;
  String? economySubSectorName;
  String? partnershipsId;
  DateOfDeedEst? dateOfDeedEst;
  String? deedEstNum;
  DateOfDeedEst? dateOfSkKumham;
  String? skKumhamNum;
  DateOfDeedEst? latestDateOfDeed;
  String? latestDeedNum;
  DateOfDeedEst? latestDateOfSkKumham;
  String? latestSkKumhamNum;
  String? fullnamePIC;
  String? phoneNumPIC;
  String? emailPIC;
  String? companyNpwpPath;
  String? deedEstPath;
  String? latestDeedPath;
  String? skKumhamPath;
  String? latestSkKumhamPath;
  String? placeOfDeedEst;
  String? latestPlaceOfDeed;
  TagLocation? tagLocation;
  String? detail;
  String? postalCode;
  String? province;
  String? city;
  String? district;
  String? village;
  String? rt;
  String? rw;
  String? createdAt;
  String? createdBy;
  String? typePipeline;
  String? initial;
  String? positionPIC;
  String? totalnominalValueShares;
  String? totalCompanyShares;

  DetailIdentitasPerusahaan({
    this.id,
    this.pipelineFlagId,
    this.companyName,
    this.companyNpwpNum,
    this.economySectorId,
    this.economySectorName,
    this.economySubSectorId,
    this.economySubSectorName,
    this.partnershipsId,
    this.dateOfDeedEst,
    this.deedEstNum,
    this.dateOfSkKumham,
    this.skKumhamNum,
    this.latestDateOfDeed,
    this.latestDeedNum,
    this.latestDateOfSkKumham,
    this.latestSkKumhamNum,
    this.fullnamePIC,
    this.phoneNumPIC,
    this.emailPIC,
    this.companyNpwpPath,
    this.deedEstPath,
    this.latestDeedPath,
    this.skKumhamPath,
    this.latestSkKumhamPath,
    this.placeOfDeedEst,
    this.latestPlaceOfDeed,
    this.tagLocation,
    this.detail,
    this.postalCode,
    this.province,
    this.city,
    this.district,
    this.village,
    this.rt,
    this.rw,
    this.createdAt,
    this.createdBy,
    this.typePipeline,
    this.initial,
    this.positionPIC,
    this.totalnominalValueShares,
    this.totalCompanyShares,
  });

  DetailIdentitasPerusahaan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pipelineFlagId = json['pipeline_flagId'];
    companyName = json['companyName'];
    companyNpwpNum = json['companyNpwpNum'];
    economySectorId = json['economy_sectorsId'];
    economySectorName = json['economySectorsName'];
    economySubSectorId = json['economy_sub_sectorsId'];
    economySubSectorName = json['economySubSectorsName'];
    partnershipsId = json['partnershipsId'];
    dateOfDeedEst = json['dateOfDeedEst'] != null
        ? DateOfDeedEst.fromJson(json['dateOfDeedEst'])
        : null;
    deedEstNum = json['deedEstNum'];
    dateOfSkKumham = json['dateOfSkKumham'] != null
        ? DateOfDeedEst.fromJson(json['dateOfSkKumham'])
        : null;
    skKumhamNum = json['skKumhamNum'];
    latestDateOfDeed = json['latestDateOfDeed'] != null
        ? DateOfDeedEst.fromJson(json['latestDateOfDeed'])
        : null;
    latestDeedNum = json['latestDeedNum'];
    latestDateOfSkKumham = json['latestDateOfSkKumham'] != null
        ? DateOfDeedEst.fromJson(json['latestDateOfSkKumham'])
        : null;
    latestSkKumhamNum = json['latestSkKumhamNum'];
    fullnamePIC = json['fullnamePIC'];
    phoneNumPIC = json['phoneNumPIC'];
    emailPIC = json['emailPIC'];
    companyNpwpPath = json['companyNpwpPath'];
    deedEstPath = json['deedEstPath'];
    latestDeedPath = json['latestDeedPath'];
    skKumhamPath = json['skKumhamPath'];
    latestSkKumhamPath = json['latestSkKumhamPath'];
    placeOfDeedEst = json['placeOfDeedEst'];
    latestPlaceOfDeed = json['latestPlaceOfDeed'];
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
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    typePipeline = json['typePipeline'];
    initial = json['initial'];
    positionPIC = json['positionPIC'];
    totalnominalValueShares = json['totalnominalValueShares'];
    totalCompanyShares = json['totalCompanyShares'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pipeline_flagId'] = pipelineFlagId;
    data['companyName'] = companyName;
    data['companyNpwpNum'] = companyNpwpNum;
    data['economy_sectorsId'] = economySectorId;
    data['economySectorsName'] = economySectorName;
    data['economy_sub_sectorsId'] = economySubSectorId;
    data['economySubSectorsName'] = economySubSectorName;
    data['partnershipsId'] = partnershipsId;
    if (dateOfDeedEst != null) {
      data['dateOfDeedEst'] = dateOfDeedEst!.toJson();
    }
    data['deedEstNum'] = deedEstNum;
    if (dateOfSkKumham != null) {
      data['dateOfSkKumham'] = dateOfSkKumham!.toJson();
    }
    data['skKumhamNum'] = skKumhamNum;
    if (latestDateOfDeed != null) {
      data['latestDateOfDeed'] = latestDateOfDeed!.toJson();
    }
    data['latestDeedNum'] = latestDeedNum;
    if (latestDateOfSkKumham != null) {
      data['latestDateOfSkKumham'] = latestDateOfSkKumham!.toJson();
    }
    data['latestSkKumhamNum'] = latestSkKumhamNum;
    data['fullnamePIC'] = fullnamePIC;
    data['phoneNumPIC'] = phoneNumPIC;
    data['emailPIC'] = emailPIC;
    data['companyNpwpPath'] = companyNpwpPath;
    data['deedEstPath'] = deedEstPath;
    data['latestDeedPath'] = latestDeedPath;
    data['skKumhamPath'] = skKumhamPath;
    data['latestSkKumhamPath'] = latestSkKumhamPath;
    data['placeOfDeedEst'] = placeOfDeedEst;
    data['latestPlaceOfDeed'] = latestPlaceOfDeed;
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
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['typePipeline'] = typePipeline;
    data['initial'] = initial;
    data['positionPIC'] = positionPIC;
    data['totalnominalValueShares'] = totalnominalValueShares;
    data['totalCompanyShares'] = totalCompanyShares;

    return data;
  }
}

class DateOfDeedEst {
  String? date;
  String? newDate;

  DateOfDeedEst({this.date, this.newDate});

  DateOfDeedEst.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    newDate = json['newDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['newDate'] = newDate;

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
