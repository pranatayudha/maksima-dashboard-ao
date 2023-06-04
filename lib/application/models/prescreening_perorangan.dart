class PrescreeningPerorangan {
  Header? header;
  Notes? notes;
  dynamic summaryScreening;

  PrescreeningPerorangan({this.header, this.summaryScreening});

  PrescreeningPerorangan.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    summaryScreening = json['summaryScreening'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    data['summaryScreening'] = summaryScreening;
    if (notes != null) {
      data['notes'] = notes!.toJson();
    }

    return data;
  }
}

class Header {
  String? pipelineFlagId;
  String? pipelinesId;
  int? codeTable;
  String? resultScreening;
  String? phoneNum;

  Header({
    this.pipelineFlagId,
    this.pipelinesId,
    this.codeTable,
    this.resultScreening,
    this.phoneNum,
  });

  Header.fromJson(Map<String, dynamic> json) {
    pipelineFlagId = json['pipeline_flagId'];
    pipelinesId = json['pipelinesId'];
    codeTable = json['codeTable'];
    resultScreening = json['resultScreening'];
    phoneNum = json['phoneNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pipeline_flagId'] = pipelineFlagId;
    data['pipelinesId'] = pipelinesId;
    data['codeTable'] = codeTable;
    data['resultScreening'] = resultScreening;
    data['phoneNum'] = phoneNum;

    return data;
  }
}

class Notes {
  String? dukcapil;
  String? slik;

  Notes({this.dukcapil, this.slik});

  Notes.fromJson(Map<String, dynamic> json) {
    dukcapil = json['dukcapil'];
    slik = json['slik'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dukcapil'] = dukcapil;
    data['slik'] = slik;

    return data;
  }
}
