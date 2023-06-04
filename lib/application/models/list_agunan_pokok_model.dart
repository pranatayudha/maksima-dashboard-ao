class ListAgunanModel {
  String? id;
  String? prakarsaId;
  String? status;
  int? jenisAgunanPokok;
  int? index;

  ListAgunanModel({
    this.id,
    this.prakarsaId,
    this.status,
    this.jenisAgunanPokok,
    this.index,
  });

  ListAgunanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    prakarsaId = json['prakarsaId'] as String?;
    status = json['status'] as String?;
    jenisAgunanPokok = json['jenisAgunanPokok'] as int?;
    index = json['index'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['prakarsaId'] = prakarsaId;
    json['status'] = status;
    json['jenisAgunanPokok'] = jenisAgunanPokok;
    json['index'] = index;

    return json;
  }
}
