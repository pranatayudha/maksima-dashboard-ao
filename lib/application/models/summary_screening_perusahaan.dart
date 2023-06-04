import 'detail_debitur_perorangan.dart';

class SummaryScreeningPerusahaan {
  String? name;
  Lpg? lpg;
  Lpg? dhn;
  Dukcapil? dukcapil;
  Slik? slik;

  SummaryScreeningPerusahaan({
    this.name,
    this.lpg,
    this.dhn,
    this.slik,
  });

  SummaryScreeningPerusahaan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lpg = json['lpg'] != null ? Lpg.fromJson(json['lpg']) : null;
    dhn = json['dhn'] != null ? Lpg.fromJson(json['dhn']) : null;
    slik = json['slik'] != null ? Slik.fromJson(json['slik']) : null;
    dukcapil =
        json['dukcapil'] != null ? Dukcapil.fromJson(json['dukcapil']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name!;
    if (lpg != null) {
      data['lpg'] = lpg!.toJson();
    }
    if (dhn != null) {
      data['dhn'] = dhn!.toJson();
    }
    if (slik != null) {
      data['slik'] = slik!.toJson();
    }
    if (dukcapil != null) {
      data['dukcapil'] = dukcapil!.toJson();
    }

    return data;
  }
}
