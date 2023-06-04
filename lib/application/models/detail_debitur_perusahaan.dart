import 'detail_debitur_perorangan.dart';

class DetailDebiturPerusahaan {
  Header? header;
  Stepper? stepper;
  PreScreening? preScreening;

  DetailDebiturPerusahaan({this.header, this.stepper, this.preScreening});

  DetailDebiturPerusahaan.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    stepper =
        json['stepper'] != null ? Stepper.fromJson(json['stepper']) : null;
    preScreening = json['preScreening'] != null
        ? PreScreening.fromJson(json['preScreening'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    if (stepper != null) {
      data['stepper'] = stepper!.toJson();
    }
    if (preScreening != null) {
      data['preScreening'] = preScreening!.toJson();
    }

    return data;
  }
}

class Header {
  String? nama;
  String? inisial;
  String? status;
  String? nominalPengajuan;
  String? tanggalPengajuan;
  String? jenisKredit;
  String? bentukUsaha;
  String? communityBranch;
  String? pemrakarsa;

  Header({
    this.nama,
    this.inisial,
    this.status,
    this.nominalPengajuan,
    this.tanggalPengajuan,
    this.jenisKredit,
    this.bentukUsaha,
    this.communityBranch,
    this.pemrakarsa,
  });

  Header.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    inisial = json['inisial'];
    status = json['status'];
    nominalPengajuan = json['nominalPengajuan'];
    tanggalPengajuan = json['tanggalPengajuan'];
    jenisKredit = json['jenisKredit'];
    bentukUsaha = json['bentukUsaha'];
    communityBranch = json['communityBranch'];
    pemrakarsa = json['pemrakarsa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['inisial'] = inisial;
    data['status'] = status;
    data['nominalPengajuan'] = nominalPengajuan;
    data['tanggalPengajuan'] = tanggalPengajuan;
    data['jenisKredit'] = jenisKredit;
    data['bentukUsaha'] = bentukUsaha;
    data['communityBranch'] = communityBranch;
    data['pemrakarsa'] = pemrakarsa;

    return data;
  }
}

class Stepper {
  int? preScreeningApproved;
  int? analisaPinjamanNasabah;
  int? hasilAnalisaPinjaman;
  dynamic revisi;
  VerifikasiADKCabang? verifikasiADKCabang;
  VerifikasiADKCabang? verifikasiCBL;
  VerifikasiADKCabang? putusanKreditCBL;
  VerifikasiADKCabang? putusanKreditKadiv;
  int? offeringDebitur;
  int? prosesAkadKredit;
  int? prosesPembuatanFasilitas;
  int? approvalStep;

  Stepper({
    this.preScreeningApproved,
    this.analisaPinjamanNasabah,
    this.hasilAnalisaPinjaman,
    this.revisi,
    this.verifikasiADKCabang,
    this.verifikasiCBL,
    this.putusanKreditCBL,
    this.putusanKreditKadiv,
    this.offeringDebitur,
    this.prosesAkadKredit,
    this.prosesPembuatanFasilitas,
    this.approvalStep,
  });

  Stepper.fromJson(Map<String, dynamic> json) {
    preScreeningApproved = json['pre_screening_approved'];
    analisaPinjamanNasabah = json['analisa_pinjaman_nasabah'];
    hasilAnalisaPinjaman = json['hasil_analisa_pinjaman'];
    revisi = json['revisi'];
    verifikasiADKCabang = json['verifikasi_ADK_cabang'] != null
        ? VerifikasiADKCabang.fromJson(json['verifikasi_ADK_cabang'])
        : null;
    verifikasiCBL = json['verifikasi_CBL'] != null
        ? VerifikasiADKCabang.fromJson(json['verifikasi_CBL'])
        : null;
    putusanKreditCBL = json['putusan_kredit_CBL'] != null
        ? VerifikasiADKCabang.fromJson(json['putusan_kredit_CBL'])
        : null;
    putusanKreditKadiv = json['putusan_kredit_kadiv'] != null
        ? VerifikasiADKCabang.fromJson(json['putusan_kredit_kadiv'])
        : null;
    offeringDebitur = json['offering_debitur'];
    prosesAkadKredit = json['proses_akad_kredit'];
    prosesPembuatanFasilitas = json['proses_pembuatan_fasilitas'];
    approvalStep = json['approvalStep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pre_screening_approved'] = preScreeningApproved;
    data['analisa_pinjaman_nasabah'] = analisaPinjamanNasabah;
    data['hasil_analisa_pinjaman'] = hasilAnalisaPinjaman;
    data['revisi'] = revisi;
    if (verifikasiADKCabang != null) {
      data['verifikasi_ADK_cabang'] = verifikasiADKCabang!.toJson();
    }
    if (verifikasiCBL != null) {
      data['verifikasi_CBL'] = verifikasiCBL!.toJson();
    }
    if (putusanKreditCBL != null) {
      data['putusan_kredit_CBL'] = putusanKreditCBL!.toJson();
    }
    if (putusanKreditKadiv != null) {
      data['putusan_kredit_kadiv'] = putusanKreditKadiv!.toJson();
    }
    data['offering_debitur'] = offeringDebitur;
    data['proses_akad_kredit'] = prosesAkadKredit;
    data['proses_pembuatan_fasilitas'] = prosesPembuatanFasilitas;
    data['approvalStep'] = approvalStep;

    return data;
  }
}

class VerifikasiADKCabang {
  int? status;
  String? reason;
  String? arguments;

  VerifikasiADKCabang({this.status, this.reason, this.arguments});

  VerifikasiADKCabang.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reason = json['reason'];
    arguments = json['arguments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['reason'] = reason;
    data['arguments'] = arguments;

    return data;
  }
}

class PreScreening {
  String? result;
  Notes? notes;
  dynamic summary;

  PreScreening({this.result, this.summary});

  PreScreening.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    summary = json['summary'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['summary'] = summary;
    if (notes != null) {
      data['notes'] = notes!.toJson();
    }

    return data;
  }
}

class Summary {
  int? mgmt;
  Data? data;
  dynamic spouseData;

  Summary({this.mgmt, this.data, this.spouseData});

  Summary.fromJson(Map<String, dynamic> json) {
    mgmt = json['mgmt'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    spouseData = json['spouseData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mgmt'] = mgmt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['spouseData'] = spouseData;

    return data;
  }
}

class Data {
  String? name;
  Lpg? dhn;
  Lpg? lpg;
  Slik? slik;
  Dukcapil? dukcapil;

  Data({this.name, this.dhn, this.lpg, this.slik, this.dukcapil});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dhn = json['dhn'] != null ? Lpg.fromJson(json['dhn']) : null;
    lpg = json['lpg'] != null ? Lpg.fromJson(json['lpg']) : null;
    slik = json['slik'] != null ? Slik.fromJson(json['slik']) : null;
    dukcapil =
        json['dukcapil'] != null ? Dukcapil.fromJson(json['dukcapil']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (dhn != null) {
      data['dhn'] = dhn!.toJson();
    }
    if (lpg != null) {
      data['lpg'] = lpg!.toJson();
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
