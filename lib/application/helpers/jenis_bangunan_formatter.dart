class JenisBangunanFormatter {
  static String forInput(String jenisBangunan) {
    String? jenis;
    switch (jenisBangunan) {
      case 'Properti Komersial':
        jenis = '161';
        break;
      case 'Gudang':
        jenis = '162';
        break;
      case 'Rumah Toko / Rumah Kantor':
        jenis = '163';
        break;
      case 'Hotel':
        jenis = '164';
        break;
      case 'Gedung - Lainnya':
        jenis = '175';
        break;
      case 'Rumah Tinggal':
        jenis = '176';
        break;
      case 'Apartemen / Rumah Susun':
        jenis = '177';
        break;
      default:
        break;
    }

    return jenis!;
  }

  static String forOutput(int jenisBangunan) {
    String? jenis;
    switch (jenisBangunan) {
      case 161:
        jenis = 'Properti Komersial';
        break;
      case 162:
        jenis = 'Gudang';
        break;
      case 163:
        jenis = 'Rumah Toko / Rumah Kantor';
        break;
      case 164:
        jenis = 'Hotel';
        break;
      case 175:
        jenis = 'Gedung - Lainnya';
        break;
      case 176:
        jenis = 'Rumah Tinggal';
        break;
      case 177:
        jenis = 'Apartemen / Rumah Susun';
        break;
      default:
        break;
    }

    return jenis!;
  }
}
