class JenisDokumenFormatter {
  static String forInput(String jenis) {
    String? jenisDokumen;
    switch (jenis) {
      case 'DO':
        jenisDokumen = 'do';
        break;
      case 'Invoice':
        jenisDokumen = 'invoice';
        break;
      default:
        jenisDokumen = '-';
        break;
    }

    return jenisDokumen;
  }

  static String forOutput(String jenis) {
    String? jenisDokumen;
    switch (jenis) {
      case 'do':
        jenisDokumen = 'DO';
        break;
      case 'invoice':
        jenisDokumen = 'Invoice';
        break;
      default:
        jenisDokumen = '-';
        break;
    }

    return jenisDokumen;
  }
}
