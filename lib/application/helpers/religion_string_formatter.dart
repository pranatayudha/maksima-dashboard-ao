class ReligionStringFormatter {
  static String forInput(String religion) {
    String? agama;
    switch (religion) {
      case 'Buddha':
        agama = 'BUD';
        break;
      case 'Hindu':
        agama = 'HIN';
        break;
      case 'Katolik':
        agama = 'KAT';
        break;
      case 'Konghucu':
        agama = 'KHC';
        break;
      case 'Islam':
        agama = 'ISL';
        break;
      case 'Protestan':
        agama = 'KRI';
        break;
      case 'Kepercayaan':
        agama = 'KPC';
        break;
      case 'Lainnya':
        agama = 'ZZZ';
        break;
      default:
        agama = '-';
        break;
    }

    return agama;
  }

  static String forOutput(String religion) {
    String? agama;
    switch (religion) {
      case 'BUD':
        agama = 'Buddha';
        break;
      case 'HIN':
        agama = 'Hindu';
        break;
      case 'KAT':
        agama = 'Katolik';
        break;
      case 'KHC':
        agama = 'Konghucu';
        break;
      case 'ISL':
        agama = 'Islam';
        break;
      case 'KRI':
        agama = 'Protestan';
        break;
      case 'KPC':
        agama = 'Kepercayaan';
        break;
      case 'ZZZ':
        agama = 'Lainnya';
        break;
      default:
        agama = '-';
        break;
    }

    return agama;
  }
}
