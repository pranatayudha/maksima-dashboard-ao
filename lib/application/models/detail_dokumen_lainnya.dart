class DetailDokumenLainnya {
  int? id;
  String? docName;
  String? path;
  String? docNum;
  String? dateOfDocument;

  DetailDokumenLainnya({
    this.id,
    this.docName,
    this.path,
    this.docNum,
    this.dateOfDocument,
  });

  DetailDokumenLainnya.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docName = json['docName'];
    path = json['path'];
    docNum = json['docNum'];
    dateOfDocument = json['dateOfDocument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['docName'] = docName;
    data['path'] = path;
    data['docNum'] = docNum;
    data['dateOfDocument'] = dateOfDocument;

    return data;
  }
}
