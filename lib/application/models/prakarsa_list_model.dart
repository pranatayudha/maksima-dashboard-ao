class DataPrakarsaListModel {
  bool? success;
  List<PrakarsaListModel>? data;
  Meta? meta;
  int? code;
  String? message;

  DataPrakarsaListModel({
    this.success,
    this.data,
    this.meta,
    this.code,
    this.message,
  });

  DataPrakarsaListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    data = (json['data'] as List?)
        ?.map(
          (dynamic e) => PrakarsaListModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    meta = (json['meta'] as Map<String, dynamic>?) != null
        ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
        : null;
    code = json['code'] as int?;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['data'] = data?.map((e) => e.toJson()).toList();
    json['meta'] = meta?.toJson();
    json['code'] = code;
    json['message'] = message;

    return json;
  }
}

class PrakarsaListModel {
  String? pipelinesId;
  int? codeTable;
  String? prakarsaId;
  String? titlePipeline;
  String? typePipeline;
  String? loanAmount;
  int? loanTypesId;
  String? statusPrakarsa;
  String? initial;
  String? submissionDate;

  PrakarsaListModel({
    this.pipelinesId,
    this.codeTable,
    this.prakarsaId,
    this.titlePipeline,
    this.typePipeline,
    this.loanAmount,
    this.loanTypesId,
    this.statusPrakarsa,
    this.initial,
    this.submissionDate,
  });

  PrakarsaListModel.fromJson(Map<String, dynamic> json) {
    pipelinesId = json['pipelinesId'] as String?;
    codeTable = json['codeTable'] as int?;
    prakarsaId = json['prakarsaId'] as String?;
    titlePipeline = json['titlePipeline'] as String?;
    typePipeline = json['typePipeline'] as String?;
    loanAmount = json['loanAmount'] as String?;
    loanTypesId = json['loan_typesId'] as int?;
    statusPrakarsa = json['statusPrakarsa'] as String?;
    initial = json['initial'] as String?;
    submissionDate = json['submissionDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['pipelinesId'] = pipelinesId;
    json['codeTable'] = codeTable;
    json['prakarsaId'] = prakarsaId;
    json['titlePipeline'] = titlePipeline;
    json['typePipeline'] = typePipeline;
    json['loanAmount'] = loanAmount;
    json['loan_typesId'] = loanTypesId;
    json['statusPrakarsa'] = statusPrakarsa;
    json['initial'] = initial;
    json['submissionDate'] = submissionDate;

    return json;
  }
}

class Meta {
  int? currentPage;
  int? size;
  int? totalData;
  int? lastPage;

  Meta({
    this.currentPage,
    this.size,
    this.totalData,
    this.lastPage,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'] as int?;
    size = json['size'] as int?;
    totalData = json['totalData'] as int?;
    lastPage = json['lastPage'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['currentPage'] = currentPage;
    json['size'] = size;
    json['totalData'] = totalData;
    json['lastPage'] = lastPage;

    return json;
  }
}
