import 'package:flutter/material.dart';

import '../app/constants/custom_color.dart';

class StatusPengajuanFormatter {
  static Color getLabelColor(String status) {
    if (status.contains('Revisi')) {
      status = 'Revisi';
    } else if (status.contains('Verifikasi')) {
      status = 'Verifikasi';
    } else if (status.contains('Ditolak') || status.contains('Tolak')) {
      status = 'Ditolak';
    } else if (status.contains('Putusan')) {
      status = 'Putusan';
    } else if (status.contains('Siap')) {
      status = 'Siap';
    } else if (status.contains('Offering')) {
      status = 'Offering';
    } else if (status.contains('Fasilitas')) {
      status = 'Fasilitas';
    }

    switch (status) {
      case 'Data Belum Lengkap':
      case 'Lengkapi Informasi Prakarsa':
      case 'Revisi':
        return const Color(0xffFEF5EE);
      case 'Verifikasi':
      case 'Putusan':
      case 'Akad Kredit':
      case 'Offering':
      case 'Fasilitas':
        return const Color(0xffE6EEF5);
      case 'Ditolak':
        return const Color(0xffFBE7E9);
      case 'Siap':
        return const Color(0xffEBF8F6);
      default:
        return CustomColor.darkGrey;
    }
  }

  static Color getTextColor(String status) {
    if (status.contains('Revisi')) {
      status = 'Revisi';
    } else if (status.contains('Verifikasi')) {
      status = 'Verifikasi';
    } else if (status.contains('Ditolak') || status.contains('Tolak')) {
      status = 'Ditolak';
    } else if (status.contains('Putusan')) {
      status = 'Putusan';
    } else if (status.contains('Siap')) {
      status = 'Siap';
    } else if (status.contains('Offering')) {
      status = 'Offering';
    } else if (status.contains('Fasilitas')) {
      status = 'Fasilitas';
    }

    switch (status) {
      case 'Data Belum Lengkap':
      case 'Lengkapi Informasi Prakarsa':
      case 'Revisi':
        return const Color(0xffF07126);
      case 'Verifikasi':
      case 'Putusan':
      case 'Akad Kredit':
      case 'Offering':
      case 'Fasilitas':
        return const Color(0xff07539A);
      case 'Ditolak':
        return const Color(0xffD70C24);
      case 'Siap':
        return const Color(0xff38BAA7);

      default:
        return Colors.white;
    }
  }

  static String convertStatus(String status) {
    if (status.contains('Ditolak') || status.contains('Tolak')) {
      status = 'Ditolak';
    } else if (status.contains('Revisi ADK')) {
      status = status.replaceAll('ADK', 'OPK');
    }

    switch (status) {
      case 'Data Belum Lengkap':
      case 'Lengkapi Informasi Prakarsa':
        return 'Data Belum Lengkap';
      case 'Verifikasi ADK':
        return 'Verifikasi OPK';
      default:
        return status;
    }
  }
}
