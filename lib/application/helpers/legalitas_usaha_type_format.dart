class LegalitasUsahaTypeFormatter {
  static String forOutput(String? type) {
    switch (type) {
      case 'others akta':
        return 'Akta Lain';
      default:
        return type!.toUpperCase();
    }
  }
}
