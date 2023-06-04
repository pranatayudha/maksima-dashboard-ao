class DetailIzinUsaha {
  String? jenisDokumen;
  String? pathDokumen;
  String? numDokumen;
  String? tanggalDokumen;
  String? tempatTerbitDokumen;

  DetailIzinUsaha({
    this.jenisDokumen,
    this.pathDokumen,
    this.numDokumen,
    this.tanggalDokumen,
    this.tempatTerbitDokumen,
  });

  DetailIzinUsaha.fromJson(Map<String, dynamic> json) {
    jenisDokumen = json['jenisDokumen'];
    pathDokumen = json['pathDokumen'];
    numDokumen = json['numDokumen'];
    tanggalDokumen = json['tanggalDokumen'];
    tempatTerbitDokumen = json['tempatTerbitDokumen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jenisDokumen'] = jenisDokumen;
    data['pathDokumen'] = pathDokumen;
    data['numDokumen'] = numDokumen;
    data['tanggalDokumen'] = tanggalDokumen;
    data['tempatTerbitDokumen'] = tempatTerbitDokumen;

    return data;
  }
}
