import 'detail_debitur_perorangan.dart';

class SummaryScreeningSpouse {
  String? name;
  Lpg? dhn;
  Dukcapil? dukcapil;
  Slik? slik;

  SummaryScreeningSpouse({this.name, this.dhn, this.dukcapil, this.slik});

  SummaryScreeningSpouse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dhn = json['dhn'] != null ? Lpg.fromJson(json['dhn']) : null;
    dukcapil =
        json['dukcapil'] != null ? Dukcapil.fromJson(json['dukcapil']) : null;
    slik = json['slik'] != null ? Slik.fromJson(json['slik']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
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
