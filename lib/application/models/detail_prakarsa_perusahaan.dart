class DetailPrakarsaPerusahaan {
  Header? header;
  Stepper? stepper;

  DetailPrakarsaPerusahaan({this.header, this.stepper});

  DetailPrakarsaPerusahaan.fromJson(Map<String, dynamic> json) {
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
  InformasiPerusahaan? informasiPerusahaan;
  bool? infoPengurus;
  bool? informasiFinansial;
  InformasiAgunan? informasiAgunan;
  bool? informasiNonFinansial;

  Stepper({
    this.screeningAwal,
    this.laporanKunjunganNasabah,
    this.informasiPerusahaan,
    this.infoPengurus,
    this.informasiFinansial,
    this.informasiAgunan,
    this.informasiNonFinansial,
  });

  Stepper.fromJson(Map<String, dynamic> json) {
    screeningAwal = json['screeningAwal'];
    laporanKunjunganNasabah = json['laporanKunjunganNasabah'];
    informasiPerusahaan = json['informasiPerusahaan'] != null
        ? InformasiPerusahaan.fromJson(json['informasiPerusahaan'])
        : null;
    infoPengurus = json['infoPengurus'];
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
    if (informasiPerusahaan != null) {
      data['informasiPerusahaan'] = informasiPerusahaan!.toJson();
    }
    data['infoPengurus'] = infoPengurus;
    data['informasiFinansial'] = informasiFinansial;
    data['informasiAgunan'] = informasiAgunan;
    data['informasiNonFinansial'] = informasiNonFinansial;

    return data;
  }
}

class InformasiPerusahaan {
  bool? parent;
  bool? identitasPerusahaan;
  bool? legalitasUsaha;
  bool? izinUsaha;
  bool? dokumenLainnya;

  InformasiPerusahaan({
    this.parent,
    this.identitasPerusahaan,
    this.legalitasUsaha,
    this.izinUsaha,
    this.dokumenLainnya,
  });

  InformasiPerusahaan.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    identitasPerusahaan = json['identitasPerusahaan'];
    legalitasUsaha = json['legalitasUsaha'];
    izinUsaha = json['izinUsaha'];
    dokumenLainnya = json['dokumenLainnya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent'] = parent;
    data['identitasPerusahaan'] = identitasPerusahaan;
    data['legalitasUsaha'] = legalitasUsaha;
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
