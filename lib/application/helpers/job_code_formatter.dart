class JobCodeFormatter {
  static int forInput(String? jobCode) {
    switch (jobCode) {
      case 'Pemilik, Direktur Utama/Presiden Dir.':
        return 1;
      case 'Pemilik, Direktur':
        return 2;
      case 'Pemilik, Komisaris Utama/Presiden Kom.':
        return 3;
      case 'Pemilik, Komisaris':
        return 4;
      case 'Pemilik, Kuasa Direksi':
        return 6;
      case 'Pemilik, Bukan Pengurus':
        return 7;
      case 'Pemilik, Grup':
        return 8;
      case 'Pemilik, Masyarakat':
        return 9;
      case 'Pemilik, Ketua Umum':
        return 10;
      case 'Pemilik, Ketua':
        return 11;
      case 'Pemilik, Sekretaris':
        return 12;
      case 'Pemilik, Bendahara':
        return 13;
      case 'Pengurus, Direktur Utama/Presiden Dir.':
        return 51;
      case 'Pengurus, Direktur':
        return 52;
      case 'Pengurus, Komisaris Utama/Presiden Kom':
        return 53;
      case 'Pengurus, Komisaris':
        return 54;
      case 'Pengurus, Kuasa Direksi':
        return 55;
      case 'Pengurus, Grup':
        return 56;
      case 'Pengurus, Ketua Umum':
        return 57;
      case 'Pengurus, Ketua':
        return 58;
      case 'Pengurus, Sekretaris':
        return 59;
      case 'Pengurus, Bendahara':
        return 60;
      case 'Pengurus, Lainnya':
        return 61;
      case 'Lainnya':
        return 99;
      default:
        return 0;
    }
  }

  static String forOutput(int? jobCode) {
    switch (jobCode) {
      case 1:
        return 'Pemilik, Direktur Utama/Presiden Dir.';
      case 2:
        return 'Pemilik, Direktur';
      case 3:
        return 'Pemilik, Komisaris Utama/Presiden Kom.';
      case 4:
        return 'Pemilik, Komisaris';
      case 6:
        return 'Pemilik, Kuasa Direksi';
      case 7:
        return 'Pemilik, Bukan Pengurus';
      case 8:
        return 'Pemilik, Grup';
      case 9:
        return 'Pemilik, Masyarakat';
      case 10:
        return 'Pemilik, Ketua Umum';
      case 11:
        return 'Pemilik, Ketua';
      case 12:
        return 'Pemilik, Sekretaris';
      case 13:
        return 'Pemilik, Bendahara';
      case 51:
        return 'Pengurus, Direktur Utama/Presiden Dir.';
      case 52:
        return 'Pengurus, Direktur';
      case 53:
        return 'Pengurus, Komisaris Utama/Presiden Kom';
      case 54:
        return 'Pengurus, Komisaris';
      case 55:
        return 'Pengurus, Kuasa Direksi';
      case 56:
        return 'Pengurus, Grup';
      case 57:
        return 'Pengurus, Ketua Umum';
      case 58:
        return 'Pengurus, Ketua';
      case 59:
        return 'Pengurus, Sekretaris';
      case 60:
        return 'Pengurus, Bendahara';
      case 61:
        return 'Pengurus, Lainnya';
      case 99:
        return 'Lainnya';
      default:
        return '';
    }
  }
}
