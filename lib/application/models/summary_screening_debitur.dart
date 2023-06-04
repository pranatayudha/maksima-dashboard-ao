class SummaryScreeningDebitur {
  Lpg? lpg;
  Lpg? dhn;
  Dukcapil? dukcapil;
  Slik? slik;

  SummaryScreeningDebitur({this.lpg, this.dhn, this.dukcapil, this.slik});

  SummaryScreeningDebitur.fromJson(Map<String, dynamic> json) {
    lpg = json['lpg'] != null ? Lpg.fromJson(json['lpg']) : null;
    dhn = json['dhn'] != null ? Lpg.fromJson(json['dhn']) : null;
    dukcapil =
        json['dukcapil'] != null ? Dukcapil.fromJson(json['dukcapil']) : null;
    slik = json['slik'] != null ? Slik.fromJson(json['slik']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lpg != null) {
      data['lpg'] = lpg!.toJson();
    }
    if (dhn != null) {
      data['dhn'] = dhn!.toJson();
    }
    if (dukcapil != null) {
      data['dukcapil'] = dukcapil!.toJson();
    }
    if (slik != null) {
      data['slik'] = slik!.toJson();
    }

    return data;
  }
}

class Lpg {
  String? status;
  String? reason;

  Lpg({this.status, this.reason});

  Lpg.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['reason'] = reason;

    return data;
  }
}

class Dukcapil {
  String? status;
  List<Reason>? reason;

  Dukcapil({this.status, this.reason});

  Dukcapil.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reason'] != null) {
      reason = <Reason>[];
      json['reason'].forEach((v) {
        reason!.add(Reason.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (reason != null) {
      data['reason'] = reason!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Reason {
  String? field;
  String? fieldName;
  String? result;
  String? path;

  Reason({this.field, this.fieldName, this.result, this.path});

  Reason.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    fieldName = json['fieldName'];
    result = json['result'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['fieldName'] = fieldName;
    data['result'] = result;
    data['path'] = path;

    return data;
  }
}

class Slik {
  String? status;
  String? reason;
  String? path;

  Slik({this.status, this.reason, this.path});

  Slik.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reason = json['reason'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['reason'] = reason;
    data['path'] = path;

    return data;
  }
}
