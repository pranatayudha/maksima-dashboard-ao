class InformasiPengurusModel {
  String? id;
  String? index;
  String? cvPipelinesId;
  String? ptPipelinesId;
  String? ktpNum;
  String? npwpNum;
  String? fullName;
  String? gender;
  String? dateOfBirth;
  String? placeOfBirth;
  String? maritalStatus;
  TagLocation? tagLocation;
  String? detail;
  String? postalCode;
  String? province;
  String? city;
  String? district;
  String? village;
  String? rt;
  String? rw;
  dynamic sharePercentage;
  dynamic shares;
  dynamic shareNominal;
  String? phoneNum;
  String? email;
  String? spouseFullname;
  String? spouseKtpNum;
  String? spouseDateOfBirth;
  String? spousePlaceOfBirth;
  String? ktpPath;
  String? npwpPath;
  String? ktpSelfiePath;
  String? spouseKtpPath;
  String? kkPath;
  String? marriagePath;
  dynamic notMarriagePath;
  dynamic divorcePath;
  dynamic deathCertificatePath;
  dynamic kkNum;
  dynamic kkDate;
  dynamic marriageNum;
  dynamic marriageDate;
  dynamic divorceNum;
  dynamic divorceDate;
  dynamic notMarriageNum;
  dynamic notMarriageDate;
  String? createdAt;
  String? createdBy;
  int? jobCode;
  String? jobDescription;
  bool? stepper;
  int? stepInformasiPengurus;
  String? deathCertificateNum;
  String? deathCertificateDate;

  InformasiPengurusModel({
    this.id,
    this.index,
    this.cvPipelinesId,
    this.ptPipelinesId,
    this.ktpNum,
    this.npwpNum,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.placeOfBirth,
    this.maritalStatus,
    this.tagLocation,
    this.detail,
    this.postalCode,
    this.province,
    this.city,
    this.district,
    this.village,
    this.rt,
    this.rw,
    this.sharePercentage,
    this.shares,
    this.shareNominal,
    this.phoneNum,
    this.email,
    this.spouseFullname,
    this.spouseKtpNum,
    this.spouseDateOfBirth,
    this.spousePlaceOfBirth,
    this.ktpPath,
    this.npwpPath,
    this.ktpSelfiePath,
    this.spouseKtpPath,
    this.kkPath,
    this.marriagePath,
    this.notMarriagePath,
    this.divorcePath,
    this.deathCertificatePath,
    this.kkNum,
    this.kkDate,
    this.marriageNum,
    this.marriageDate,
    this.divorceNum,
    this.divorceDate,
    this.notMarriageNum,
    this.notMarriageDate,
    this.createdAt,
    this.createdBy,
    this.jobCode,
    this.jobDescription,
    this.stepper,
    this.stepInformasiPengurus,
    this.deathCertificateNum,
    this.deathCertificateDate,
  });

  InformasiPengurusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    cvPipelinesId = json['cv_pipelinesId'] as String?;
    ptPipelinesId = json['pt_pipelinesId'] as String?;
    ktpNum = json['ktpNum'] as String?;
    npwpNum = json['npwpNum'] as String?;
    fullName = json['fullName'] as String?;
    gender = json['gender'] as String?;
    dateOfBirth = json['dateOfBirth'] as String?;
    placeOfBirth = json['placeOfBirth'] as String?;
    maritalStatus = json['maritalStatus'] as String?;
    tagLocation = (json['tagLocation'] as Map<String, dynamic>?) != null
        ? TagLocation.fromJson(json['tagLocation'] as Map<String, dynamic>)
        : null;
    detail = json['detail'] as String?;
    postalCode = json['postalCode'] as String?;
    province = json['province'] as String?;
    city = json['city'] as String?;
    district = json['district'] as String?;
    village = json['village'] as String?;
    rt = json['rt'] as String?;
    rw = json['rw'] as String?;
    sharePercentage = json['sharePercentage'];
    shares = json['shares'];
    shareNominal = json['shareNominal'];
    phoneNum = json['phoneNum'] as String?;
    email = json['email'] as String?;
    spouseFullname = json['spouseFullname'] as String?;
    spouseKtpNum = json['spouseKtpNum'] as String?;
    spouseDateOfBirth = json['spouseDateOfBirth'] as String?;
    spousePlaceOfBirth = json['spousePlaceOfBirth'] as String?;
    ktpPath = json['ktpPath'] as String?;
    npwpPath = json['npwpPath'] as String?;
    ktpSelfiePath = json['ktpSelfiePath'] as String?;
    spouseKtpPath = json['spouseKtpPath'] as String?;
    kkPath = json['kkPath'] as String?;
    marriagePath = json['marriagePath'] as String?;
    notMarriagePath = json['notMarriagePath'];
    divorcePath = json['divorcePath'];
    deathCertificatePath = json['deathCertificatePath'];
    kkNum = json['kkNum'];
    kkDate = json['kkDate'];
    marriageNum = json['marriageNum'];
    marriageDate = json['marriageDate'];
    divorceNum = json['divorceNum'];
    divorceDate = json['divorceDate'];
    notMarriageNum = json['notMarriageNum'];
    notMarriageDate = json['notMarriageDate'];
    createdAt = json['createdAt'] as String?;
    createdBy = json['createdBy'] as String?;
    jobCode = json['jobCode'] as int?;
    jobDescription = json['jobDescription'] as String?;
    stepper = json['stepper'] as bool?;
    stepInformasiPengurus = json['step_informasi_pengurus'] as int;
    deathCertificateNum = json['deathCertificateNum'] as String?;
    deathCertificateDate = json['deathCertificateDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['cv_pipelinesId'] = cvPipelinesId;
    json['pt_pipelinesId'] = ptPipelinesId;
    json['ktpNum'] = ktpNum;
    json['npwpNum'] = npwpNum;
    json['fullName'] = fullName;
    json['gender'] = gender;
    json['dateOfBirth'] = dateOfBirth;
    json['placeOfBirth'] = placeOfBirth;
    json['maritalStatus'] = maritalStatus;
    json['tagLocation'] = tagLocation?.toJson();
    json['detail'] = detail;
    json['postalCode'] = postalCode;
    json['province'] = province;
    json['city'] = city;
    json['district'] = district;
    json['village'] = village;
    json['rt'] = rt;
    json['rw'] = rw;
    json['sharePercentage'] = sharePercentage;
    json['shares'] = shares;
    json['shareNominal'] = shareNominal;
    json['phoneNum'] = phoneNum;
    json['email'] = email;
    json['spouseFullname'] = spouseFullname;
    json['spouseKtpNum'] = spouseKtpNum;
    json['spouseDateOfBirth'] = spouseDateOfBirth;
    json['spousePlaceOfBirth'] = spousePlaceOfBirth;
    json['ktpPath'] = ktpPath;
    json['npwpPath'] = npwpPath;
    json['ktpSelfiePath'] = ktpSelfiePath;
    json['spouseKtpPath'] = spouseKtpPath;
    json['kkPath'] = kkPath;
    json['marriagePath'] = marriagePath;
    json['notMarriagePath'] = notMarriagePath;
    json['divorcePath'] = divorcePath;
    json['deathCertificatePath'] = deathCertificatePath;
    json['kkNum'] = kkNum;
    json['kkDate'] = kkDate;
    json['marriageNum'] = marriageNum;
    json['marriageDate'] = marriageDate;
    json['divorceNum'] = divorceNum;
    json['divorceDate'] = divorceDate;
    json['notMarriageNum'] = notMarriageNum;
    json['notMarriageDate'] = notMarriageDate;
    json['createdAt'] = createdAt;
    json['createdBy'] = createdBy;
    json['jobCode'] = jobCode;
    json['jobDescription'] = jobDescription;
    json['stepper'] = stepper;
    json['step_informasi_pengurus'] = stepInformasiPengurus;
    json['deathCertificateNum'] = deathCertificateNum;
    json['deathCertificateDate'] = deathCertificateDate;

    return json;
  }
}

class TagLocation {
  String? latLng;
  String? name;

  TagLocation({
    this.latLng,
    this.name,
  });

  TagLocation.fromJson(Map<String, dynamic> json) {
    latLng = json['latLng'] as String?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['latLng'] = latLng;
    json['name'] = name;

    return json;
  }
}
