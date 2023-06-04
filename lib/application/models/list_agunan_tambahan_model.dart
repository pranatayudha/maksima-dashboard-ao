class ListAgunanTambahanModel {
  int? index;
  String? codeTable;
  String? id;
  String? prakarsaId;
  String? status;
  String? jenisPenilaian;

  ListAgunanTambahanModel({
    this.index,
    this.codeTable,
    this.id,
    this.prakarsaId,
    this.status,
    this.jenisPenilaian,
  });

  ListAgunanTambahanModel copyWith({
    int? index,
    String? codeTable,
    String? id,
    String? prakarsaId,
    String? status,
    String? jenisPenilaian,
  }){
    return ListAgunanTambahanModel(
      index: index ?? this.index,
      codeTable: codeTable ?? this.codeTable,
      id: id ?? this.id,
      prakarsaId: prakarsaId ?? this.prakarsaId,
      status: status ?? this.status,
      jenisPenilaian: jenisPenilaian ?? this.jenisPenilaian,
    );
  }


  ListAgunanTambahanModel.fromJson(Map<String, dynamic> json) {
    codeTable = json['codeTable'] as String?;
    id = json['id'] as String?;
    prakarsaId = json['prakarsaId'] as String?;
    status = json['status'] as String?;
    jenisPenilaian = json['jenisPenilaian'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['codeTable'] = codeTable;
    json['id'] = id;
    json['prakarsaId'] = prakarsaId;
    json['status'] = status;
    json['jenisPenilaian'] = jenisPenilaian;

    return json;
  }
}
