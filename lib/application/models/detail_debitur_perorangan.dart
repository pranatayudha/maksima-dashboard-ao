import 'summary_screening_debitur.dart';

class DetailDebiturPerorangan {
  Header? header;
  Stepper? stepper;
  PreScreening? preScreening;
  int? trigger;

  DetailDebiturPerorangan({
    this.header,
    this.stepper,
    this.preScreening,
    this.trigger,
  });

  DetailDebiturPerorangan.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    stepper =
        json['stepper'] != null ? Stepper.fromJson(json['stepper']) : null;
    preScreening = json['preScreening'] != null
        ? PreScreening.fromJson(json['preScreening'])
        : null;
    trigger = json['trigger'];
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
    data['trigger'] = trigger;

    return data;
  }
}

class Header {
  String? pipelineFlagId;
  String? pipelinesId;
  int? codeTable;
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
    this.pipelineFlagId,
    this.pipelinesId,
    this.codeTable,
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
    pipelineFlagId = json['pipeline_flagId'];
    pipelinesId = json['pipelinesId'];
    codeTable = json['codeTable'];
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
    data['pipeline_flagId'] = pipelineFlagId;
    data['pipelinesId'] = pipelinesId;
    data['codeTable'] = codeTable;
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
  dynamic summary;
  String? description;
  Notes? notes;

  PreScreening({this.result, this.summary, this.description, this.notes});

  PreScreening.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    summary = json['summary'];
    description = json['description'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['summary'] = summary;
    data['description'] = description;
    if (notes != null) {
      data['notes'] = notes!.toJson();
    }

    return data;
  }
}

class Summary {
  Lpg? lpg;
  Lpg? dhn;
  Dukcapil? dukcapil;
  Slik? slik;

  Summary({this.lpg, this.dhn, this.dukcapil, this.slik});

  Summary.fromJson(Map<String, dynamic> json) {
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
