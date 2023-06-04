class InfoUsahaDebiturModel {
  String? businessName;
  String? jenisKomoditas;
  String? economySectorsId;
  String? economySectorsName;
  String? economySubSectorsId;
  String? economySubSectorsName;
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
  String? addressIdChild;
  String? addressIdParent;

  InfoUsahaDebiturModel({
    this.businessName,
    this.jenisKomoditas,
    this.economySectorsId,
    this.economySectorsName,
    this.economySubSectorsId,
    this.economySubSectorsName,
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
    this.addressIdChild,
    this.addressIdParent,
  });

  InfoUsahaDebiturModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'] as String?;
    jenisKomoditas = json['jenisKomoditas'] as String?;
    economySectorsId = json['economy_sectorsId'] as String?;
    economySectorsName = json['economySectorsName'] as String?;
    economySubSectorsId = json['economy_sub_sectorsId'] as String?;
    economySubSectorsName = json['economySubSectorsName'] as String?;
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
    addressIdChild = json['addressIdChild'] as String?;
    addressIdParent = json['addressIdParent'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['businessName'] = businessName;
    json['jenisKomoditas'] = jenisKomoditas;
    json['economy_sectorsId'] = economySectorsId;
    json['economySectorsName'] = economySectorsName;
    json['economy_sub_sectorsId'] = economySubSectorsId;
    json['economySubSectorsName'] = economySubSectorsName;
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
    json['addressIdChild'] = addressIdChild;
    json['addressIdParent'] = addressIdParent;

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
