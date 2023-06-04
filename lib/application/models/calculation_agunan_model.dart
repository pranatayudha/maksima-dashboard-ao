class CalculationAgunanModel {
  String? npw;
  String? nl;
  String? pnpw;
  String? pnl;
  String? plafonAwal;
  String? period;
  String? coverageNpw;
  String? coverageNl;
  String? coverangePnPw;
  String? coveragePnl;

  CalculationAgunanModel({
    this.npw,
    this.nl,
    this.pnpw,
    this.pnl,
    this.plafonAwal,
    this.period,
    this.coverageNpw,
    this.coverageNl,
    this.coverangePnPw,
    this.coveragePnl,
  });

  CalculationAgunanModel.fromJson(Map<String, dynamic> json) {
    npw = json['npw'] as String?;
    nl = json['nl'] as String?;
    pnpw = json['pnpw'] as String?;
    pnl = json['pnl'] as String?;
    plafonAwal = json['plafonAwal'] as String?;
    period = json['period'] as String?;
    coverageNpw = json['coverageNpw'] as String?;
    coverageNl = json['coverageNl'] as String?;
    coverangePnPw = json['coverangePnPw'] as String?;
    coveragePnl = json['coveragePnl'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['npw'] = npw;
    json['nl'] = nl;
    json['pnpw'] = pnpw;
    json['pnl'] = pnl;
    json['plafonAwal'] = plafonAwal;
    json['period'] = period;
    json['coverageNpw'] = coverageNpw;
    json['coverageNl'] = coverageNl;
    json['coverangePnPw'] = coverangePnPw;
    json['coveragePnl'] = coveragePnl;

    return json;
  }
}
