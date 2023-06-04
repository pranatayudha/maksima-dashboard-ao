class StepperTabAgunanModel {
  bool? success;
  Data? data;
  String? message;
  int? code;

  StepperTabAgunanModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  StepperTabAgunanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    data = (json['data'] as Map<String, dynamic>?) != null
        ? Data.fromJson(json['data'] as Map<String, dynamic>)
        : null;
    message = json['message'] as String?;
    code = json['code'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['data'] = data?.toJson();
    json['message'] = message;
    json['code'] = code;

    return json;
  }
}

class Data {
  int? informasiUmum;
  int? pembanding;
  int? penilaian;
  String? jenisPenilaian;

  Data({
    this.informasiUmum,
    this.pembanding,
    this.penilaian,
    this.jenisPenilaian,
  });

  Data.fromJson(Map<String, dynamic> json) {
    informasiUmum = json['informasi_umum'] as int?;
    pembanding = json['pembanding'] as int?;
    penilaian = json['penilaian'] as int?;
    jenisPenilaian = json['jenis_penilaian'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['informasi_umum'] = informasiUmum;
    json['pembanding'] = pembanding;
    json['penilaian'] = penilaian;
    json['jenis_penilaian'] = jenisPenilaian;

    return json;
  }
}
