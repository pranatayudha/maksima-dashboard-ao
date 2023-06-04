class DetailPrakarsaPerorangan {
  Header? header;
  Stepper? stepper;

  DetailPrakarsaPerorangan({this.header, this.stepper});

  DetailPrakarsaPerorangan.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    stepper =
        json['stepper'] != null ? Stepper.fromJson(json['stepper']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    if (stepper != null) {
      data['stepper'] = stepper!.toJson();
    }

    return data;
  }
}

class Header {
  String? nama;
  String? nominalPengajuan;

  Header({this.nama, this.nominalPengajuan});

  Header.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nominalPengajuan = json['nominalPengajuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['nominalPengajuan'] = nominalPengajuan;

    return data;
  }
}

class Stepper {
  bool? screeningAwal;
  bool? laporanKunjunganNasabah;
  InformasiDebitur? informasiDebitur;
  bool? informasiFinansial;
  InformasiAgunan? informasiAgunan;
  bool? informasiNonFinansial;

  Stepper({
    this.screeningAwal,
    this.laporanKunjunganNasabah,
    this.informasiDebitur,
    this.informasiFinansial,
    this.informasiAgunan,
    this.informasiNonFinansial,
  });

  Stepper.fromJson(Map<String, dynamic> json) {
    screeningAwal = json['screeningAwal'];
    laporanKunjunganNasabah = json['laporanKunjunganNasabah'];
    informasiDebitur = json['informasiDebitur'] != null
        ? InformasiDebitur.fromJson(json['informasiDebitur'])
        : null;
    informasiFinansial = json['informasiFinansial'];
    informasiAgunan = json['informasiAgunan'] != null
        ? InformasiAgunan.fromJson(json['informasiAgunan'])
        : null;
    informasiNonFinansial = json['informasiNonFinansial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['screeningAwal'] = screeningAwal;
    data['laporanKunjunganNasabah'] = laporanKunjunganNasabah;
    if (informasiDebitur != null) {
      data['informasiDebitur'] = informasiDebitur!.toJson();
    }
    data['informasiFinansial'] = informasiFinansial;
    data['informasiAgunan'] = informasiAgunan;
    data['informasiNonFinansial'] = informasiNonFinansial;

    return data;
  }
}

class InformasiDebitur {
  bool? parent;
  bool? identitasDiri;
  bool? infoUsaha;
  bool? izinUsaha;
  bool? dokumenLainnya;

  InformasiDebitur({
    this.parent,
    this.identitasDiri,
    this.infoUsaha,
    this.izinUsaha,
    this.dokumenLainnya,
  });

  InformasiDebitur.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    identitasDiri = json['identitasDiri'];
    infoUsaha = json['infoUsaha'];
    izinUsaha = json['izinUsaha'];
    dokumenLainnya = json['dokumenLainnya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent'] = parent;
    data['identitasDiri'] = identitasDiri;
    data['infoUsaha'] = infoUsaha;
    data['izinUsaha'] = izinUsaha;
    data['dokumenLainnya'] = dokumenLainnya;

    return data;
  }
}

class InformasiAgunan {
  bool? parent;
  bool? agunanPokok;
  bool? agunanTambahan;

  InformasiAgunan({
    this.parent,
    this.agunanPokok,
    this.agunanTambahan,
  });

  InformasiAgunan.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    agunanPokok = json['agunanPokok'];
    agunanTambahan = json['agunanTambahan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent'] = parent;
    data['agunanPokok'] = agunanPokok;
    data['agunanTambahan'] = agunanTambahan;

    return data;
  }
}
