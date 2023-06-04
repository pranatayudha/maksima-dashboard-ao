class JenisKonfirmasiFormatter {
  static String forInput(String jenis) {
    String? jenisKonfirmasi;
    switch (jenis) {
      case 'Kunjungan Lapangan':
        jenisKonfirmasi = 'kunjungan lapangan';
        break;
      case 'Video Call':
        jenisKonfirmasi = 'videocall';
        break;
      case 'Email':
        jenisKonfirmasi = 'email';
        break;
      case 'Whatsapp':
        jenisKonfirmasi = 'whatsapp';
        break;
      default:
        jenisKonfirmasi = '-';
        break;
    }

    return jenisKonfirmasi;
  }

  static String forOutput(String jenis) {
    String? jenisKonfirmasi;
    switch (jenis) {
      case 'kunjungan lapangan':
        jenisKonfirmasi = 'Kunjungan Lapangan';
        break;
      case 'videocall':
        jenisKonfirmasi = 'Video Call';
        break;
      case 'email':
        jenisKonfirmasi = 'Email';
        break;
      case 'whatsapp':
        jenisKonfirmasi = 'Whatsapp';
        break;
      default:
        jenisKonfirmasi = '-';
        break;
    }

    return jenisKonfirmasi;
  }
}
