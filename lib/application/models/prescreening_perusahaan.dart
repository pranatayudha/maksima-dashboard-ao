class PrescreeningPerusahaan {
  Header? header;
  Notes? notes;
  dynamic summaryScreening;

  PrescreeningPerusahaan({this.header, this.summaryScreening});

  PrescreeningPerusahaan.fromJson(Map<String, dynamic> json) {
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
  String? titlePipeline;
  String? npwpNumb;
  String? resultScreening;

  Header({
    this.pipelineFlagId,
    this.pipelinesId,
    this.codeTable,
    this.titlePipeline,
    this.npwpNumb,
    this.resultScreening,
  });

  Header.fromJson(Map<String, dynamic> json) {
    pipelineFlagId = json['pipeline_flagId'];
    pipelinesId = json['pipelinesId'];
    codeTable = json['codeTable'];
    titlePipeline = json['titlePipeline'];
    npwpNumb = json['npwpNumb'];
    resultScreening = json['resultScreening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pipeline_flagId'] = pipelineFlagId;
    data['pipelinesId'] = pipelinesId;
    data['codeTable'] = codeTable;
    data['titlePipeline'] = titlePipeline;
    data['npwpNumb'] = npwpNumb;
    data['resultScreening'] = resultScreening;

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
