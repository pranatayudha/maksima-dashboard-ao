class StatusPrakarsaIntFormatter {
  static dynamic getLoanTypeId(String loanTypeId) {
    return loanTypeId.contains('Semua')
        ? ''
        : loanTypeId.contains('PTR')
            ? 1
            : 2;
  }

  static dynamic getStatusId(String status) {
    if (status.contains('Siap')) {
      status = 'Siap';
    } else if (status.contains('Ditolak') || status.contains('Tolak')) {
      status = 'Ditolak';
    }

    switch (status) {
      case 'Data Belum Lengkap':
      case 'Lengkapi Informasi Prakarsa':
        return 1;
      case 'Siap':
        return 2;
      case 'Verifikasi OPK':
      case 'Verifikasi ADK':
        return 3;
      case 'Verifikasi CBL':
        return 4;
      case 'Putusan Kredit oleh Kadiv':
        return 5;
      case 'Putusan Kredit oleh Wakadiv':
        return 6;
      case 'Putusan Kredit oleh CBL':
        return 7;
      case 'Revisi OPK':
        return 8;
      case 'Revisi CBL':
        return 9;
      case 'Revisi Pusat':
        return 10;
      case 'Offering Debitur':
        return 11;
      case 'Akad Kredit':
        return 12;
      case 'Pembuatan Fasilitas':
        return 13;
      case 'Ditolak':
        return 14;
      default:
        return '';
    }
  }
}
