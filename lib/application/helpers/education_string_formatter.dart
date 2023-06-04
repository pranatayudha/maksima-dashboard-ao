class EducationStringFormatter {
  static String forInput(String edu) {
    String? education;
    switch (edu) {
      case 'Belum Tamat':
        education = 'BT';
        break;
      case 'D1':
        education = 'D1';
        break;
      case 'D2':
        education = 'D2';
        break;
      case 'D3':
        education = 'D3';
        break;
      case 'S1':
        education = 'S1';
        break;
      case 'S2':
        education = 'S2';
        break;
      case 'S3':
        education = 'S3';
        break;
      case 'SD':
        education = 'SD';
        break;
      case 'SMP':
        education = 'SM';
        break;
      case 'SMU':
        education = 'SU';
        break;
      case 'Madrasah':
        education = 'TS';
        break;
      case 'Lainnya':
        education = 'ZZ';
        break;
      default:
        break;
    }

    return education!;
  }

  static String forOutput(String edu) {
    String? education;
    switch (edu) {
      case 'BT':
        education = 'Belum Tamat';
        break;
      case 'D1':
        education = 'D1';
        break;
      case 'D2':
        education = 'D2';
        break;
      case 'D3':
        education = 'D3';
        break;
      case 'S1':
      case 'S1/D4':
        education = 'S1';
        break;
      case 'S2':
        education = 'S2';
        break;
      case 'S3':
        education = 'S3';
        break;
      case 'SD':
        education = 'SD';
        break;
      case 'SM':
      case 'SM (SMP)':
        education = 'SMP';
        break;
      case 'SU':
      case 'SU (SMU)':
        education = 'SMU';
        break;
      case 'TS':
      case 'TS (Madrasah)':
        education = 'Madrasah';
        break;
      case 'ZZ':
        education = 'Lainnya';
        break;
      default:
        education = '-';
        break;
    }

    return education;
  }

  static String convertToLongText(String education) {
    String? result;
    switch (education) {
      case 'BT':
        result = 'Belum Tamat SD / Sederajat';
        break;
      case 'D1':
        result = 'Diploma 1';
        break;
      case 'D2':
        result = 'Diploma 2';
        break;
      case 'D3':
        result = 'Diploma 3';
        break;
      case 'S1':
        result = 'Sarjana / Diploma IV';
        break;
      case 'S2':
        result = 'Master';
        break;
      case 'S3':
        result = 'Doktor';
        break;
      case 'SD':
        result = 'SD';
        break;
      case 'SM':
        result = 'SMP';
        break;
      case 'SU':
        result = 'SMU';
        break;
      case 'TS':
        result = 'Tidak / Belum Sekolah';
        break;
      default:
        result = 'Lainnya';
        break;
    }

    return result;
  }
}
