class InitialCodeTableFormatter {
  static String getPrakarsaType(int codeTable) {
    switch (codeTable) {
      case 1:
        return 'pr';
      case 2:
        return 'cv';
      case 3:
        return 'pt';
      case 4:
        return 'pari';
      default:
        return 'pr';
    }
  }

  static String getJenisKredit(int codeTable) {
    switch (codeTable) {
      case 1:
        return 'Pinang Maksima - PTR';
      case 2:
        return 'Pinang Maksima - PTR';
      case 3:
        return 'Pinang Maksima - PTR';
      case 4:
        return 'Pinang Maksima - PARI';
      default:
        return 'Pinang Maksima - PTR';
    }
  }
}
