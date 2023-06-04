class DetailIdentitasPerorangan {
  String? prakarsaId;
  String? id;
  String? idAccountPari;
  String? pipelineFlagId;
  String? ktpNum;
  String? kkNum;
  int? numberOfDependents;
  String? lastEducation;
  String? dateOfExpiredKTP;
  String? dateOfIssuedKTP;
  String? religion;
  String? npwpNum;
  String? fullName;
  String? gender;
  DateOfBirth? dateOfBirth;
  String? placeOfBirth;
  String? motherMaiden;
  String? maritalStatus;
  String? phoneNum;
  String? email;
  String? spouseKtpNum;
  String? spouseFullname;
  DateOfBirth? spouseDateOfBirth;
  String? spousePlaceOfBirth;
  String? ktpPath;
  String? npwpPath;
  String? ktpSelfiePath;
  String? spouseKtpPath;
  String? kkPath;
  String? marriagePath;
  dynamic notMarriagePath;
  String? divorcePath;
  String? deathCertificatePath;
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
  String? kkDate;
  String? marriageNum;
  String? marriageDate;
  String? divorceNum;
  String? divorceDate;
  String? notMarriageNum;
  String? notMarriageDate;
  String? deathCertificateNum;
  String? deathCertificateDate;

  DetailIdentitasPerorangan({
    this.prakarsaId,
    this.id,
    this.idAccountPari,
    this.pipelineFlagId,
    this.ktpNum,
    this.kkNum,
    this.numberOfDependents,
    this.lastEducation,
    this.dateOfExpiredKTP,
    this.dateOfIssuedKTP,
    this.religion,
    this.npwpNum,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.placeOfBirth,
    this.motherMaiden,
    this.maritalStatus,
    this.phoneNum,
    this.email,
    this.spouseKtpNum,
    this.spouseFullname,
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
    this.kkDate,
    this.marriageNum,
    this.marriageDate,
    this.divorceNum,
    this.divorceDate,
    this.notMarriageNum,
    this.notMarriageDate,
    this.deathCertificateNum,
    this.deathCertificateDate,
  });

  DetailIdentitasPerorangan.fromJson(Map<String, dynamic> json) {
    prakarsaId = json['prakarsaId'] as String?;
    id = json['id'] as String?;
    idAccountPari = json['idAccountPari'] as String?;
    pipelineFlagId = json['pipeline_flagId'] as String?;
    ktpNum = json['ktpNum'] as String?;
    kkNum = json['kkNum'] as String?;
    numberOfDependents = json['numberOfDependents'] as int?;
    lastEducation = json['lastEducation'] as String?;
    dateOfExpiredKTP = json['dateOfExpiredKTP'] as String?;
    dateOfIssuedKTP = json['dateOfIssuedKTP'] as String?;
    religion = json['religion'] as String?;
    npwpNum = json['npwpNum'] as String?;
    fullName = json['fullName'] as String?;
    gender = json['gender'] as String?;
    dateOfBirth = (json['dateOfBirth'] as Map<String, dynamic>?) != null
        ? DateOfBirth.fromJson(json['dateOfBirth'] as Map<String, dynamic>)
        : null;
    placeOfBirth = json['placeOfBirth'] as String?;
    motherMaiden = json['motherMaiden'] as String?;
    maritalStatus = json['maritalStatus'] as String?;
    phoneNum = json['phoneNum'] as String?;
    email = json['email'] as String?;
    spouseKtpNum = json['spouseKtpNum'] as String?;
    spouseFullname = json['spouseFullname'] as String?;
    spouseDateOfBirth =
        (json['spouseDateOfBirth'] as Map<String, dynamic>?) != null
            ? DateOfBirth.fromJson(
                json['spouseDateOfBirth'] as Map<String, dynamic>,
              )
            : null;
    spousePlaceOfBirth = json['spousePlaceOfBirth'] as String?;
    ktpPath = json['ktpPath'] as String?;
    npwpPath = json['npwpPath'] as String?;
    ktpSelfiePath = json['ktpSelfiePath'] as String?;
    spouseKtpPath = json['spouseKtpPath'] as String?;
    kkPath = json['kkPath'] as String?;
    marriagePath = json['marriagePath'] as String?;
    notMarriagePath = json['notMarriagePath'];
    divorcePath = json['divorcePath'] as String?;
    deathCertificatePath = json['deathCertificatePath'] as String?;
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
    createdAt = json['createdAt'] as String?;
    createdBy = json['createdBy'] as String?;
    typePipeline = json['typePipeline'] as String?;
    initial = json['initial'] as String?;
    kkDate = json['kkDate'] as String?;
    marriageNum = json['marriageNum'] as String?;
    marriageDate = json['marriageDate'] as String?;
    divorceNum = json['divorceNum'] as String?;
    divorceDate = json['divorceDate'] as String?;
    notMarriageNum = json['notMarriageNum'] as String?;
    notMarriageDate = json['notMarriageDate'] as String?;
    deathCertificateNum = json['deathCertificateNum'] as String?;
    deathCertificateDate = json['deathCertificateDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['prakarsaId'] = prakarsaId;
    json['id'] = id;
    json['idAccountPari'] = idAccountPari;
    json['pipeline_flagId'] = pipelineFlagId;
    json['ktpNum'] = ktpNum;
    json['kkNum'] = kkNum;
    json['numberOfDependents'] = numberOfDependents;
    json['lastEducation'] = lastEducation;
    json['dateOfExpiredKTP'] = dateOfExpiredKTP;
    json['dateOfIssuedKTP'] = dateOfIssuedKTP;
    json['religion'] = religion;
    json['npwpNum'] = npwpNum;
    json['fullName'] = fullName;
    json['gender'] = gender;
    json['dateOfBirth'] = dateOfBirth?.toJson();
    json['placeOfBirth'] = placeOfBirth;
    json['motherMaiden'] = motherMaiden;
    json['maritalStatus'] = maritalStatus;
    json['phoneNum'] = phoneNum;
    json['email'] = email;
    json['spouseKtpNum'] = spouseKtpNum;
    json['spouseFullname'] = spouseFullname;
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
    json['tagLocation'] = tagLocation?.toJson();
    json['detail'] = detail;
    json['postalCode'] = postalCode;
    json['province'] = province;
    json['city'] = city;
    json['district'] = district;
    json['village'] = village;
    json['rt'] = rt;
    json['rw'] = rw;
    json['createdAt'] = createdAt;
    json['createdBy'] = createdBy;
    json['typePipeline'] = typePipeline;
    json['initial'] = initial;
    json['kkDate'] = kkDate;
    json['marriageNum'] = marriageNum;
    json['marriageDate'] = marriageDate;
    json['divorceNum'] = divorceNum;
    json['divorceDate'] = divorceDate;
    json['notMarriageNum'] = notMarriageNum;
    json['notMarriageDate'] = notMarriageDate;
    json['deathCertificateNum'] = deathCertificateNum;
    json['deathCertificateDate'] = deathCertificateDate;

    return json;
  }
}

class DateOfBirth {
  String? date;
  String? newDate;

  DateOfBirth({
    this.date,
    this.newDate,
  });

  DateOfBirth.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    newDate = json['newDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['date'] = date;
    json['newDate'] = newDate;

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
