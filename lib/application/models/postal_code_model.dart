class PostalCodeModel {
  String? provinceCode;
  String? province;
  String? cityCode;
  String? city;
  String? districtCode;
  String? district;
  String? villageCode;
  String? village;
  String? postalCode;

  PostalCodeModel({
    this.provinceCode,
    this.province,
    this.cityCode,
    this.city,
    this.districtCode,
    this.district,
    this.villageCode,
    this.village,
    this.postalCode,
  });

  PostalCodeModel.fromJson(Map<String, dynamic> json) {
    provinceCode = json['provinceCode'];
    province = json['province'];
    cityCode = json['cityCode'];
    city = json['city'];
    districtCode = json['districtCode'];
    district = json['district'];
    villageCode = json['villageCode'];
    village = json['village'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provinceCode'] = provinceCode;
    data['province'] = province;
    data['cityCode'] = cityCode;
    data['city'] = city;
    data['districtCode'] = districtCode;
    data['district'] = district;
    data['villageCode'] = villageCode;
    data['village'] = village;
    data['postalCode'] = postalCode;

    return data;
  }
}
