import 'package:flutter/material.dart';

import '../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../application/models/summary_screening_debitur.dart';
import 'dukcapil_contain.dart';

class PreScreeningDialog {
  // SLIK Dialog
  Future<dynamic> showDialogSlik({
    BuildContext? context,
    String? reason,
    String? status,
    Function()? onTap,
  }) {
    return showDialog(
      context: context!,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 100),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(85, 40, 85, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconConstants.slikSuccess, scale: 3),
                    const SizedBox(height: 24),
                    Text(
                      'Riwayat kolektabilitas Debitur',
                      style: titleStyle20,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      reason ?? '-',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: status == 'Lolos'
                            ? CustomColor.stateSuccess
                            : CustomColor.primaryRed80,
                      ),
                    ),
                    const SizedBox(height: 32),
                    InkWell(
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      onTap: onTap,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xff027DEF),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(
                          'Download iDeb SLIK',
                          textAlign: TextAlign.center,
                          style: titleStyle16.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //LPG Dialog
  Future<dynamic> showDialogLpg(
    BuildContext context, {
    String? title,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 100),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(85, 40, 85, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconConstants.lpgSuccess, scale: 3),
                    const SizedBox(height: 24),
                    Text(
                      'Sektor Ekonomi sesuai dengan target pasar yang ditentukan',
                      style: titleStyle20,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Lokasi usaha $title berada di',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' zona hijau',
                            style: titleStyle16.copyWith(
                              color: CustomColor.stateSuccess,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildButton(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //Dukcapil Dialog
  Future<dynamic> showDialogDukcapil(
    BuildContext context, {
    Function()? onTap,
    List<Reason>? data,
    String? urlFile,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(85, 30, 85, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'DETAIL DUKCAPIL',
                      style: TextStyle(
                        color: Color(0xff03213E),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 24),
                    DukcapilContain(
                      title: 'NIK',
                      value: data?[0].fieldName ?? '-',
                      result: data?[0].result ?? '-',
                    ),
                    const SizedBox(height: 16),
                    DukcapilContain(
                      title: 'Nama Lengkap Sesuai KTP',
                      value: data?[1].fieldName ?? '-',
                      result: data?[1].result ?? '-',
                    ),
                    const SizedBox(height: 16),
                    DukcapilContain(
                      title: 'Tempat Lahir',
                      value: data?[2].fieldName ?? '-',
                      result: data?[2].result ?? '-',
                    ),
                    const SizedBox(height: 16),
                    DukcapilContain(
                      title: 'Tanggal Lahir',
                      value: data?[3].fieldName ?? '-',
                      result: data?[3].result ?? '-',
                    ),
                    const SizedBox(height: 9),
                    InkWell(
                      onTap: onTap,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: _iconPreview(urlFile ?? '-', 1),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildButton(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //DHN Dialog
  Future<dynamic> showDialogDhn(
    BuildContext context,
    String debiturName,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 100),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(85, 40, 85, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconConstants.dhnSuccess, scale: 3),
                    const SizedBox(height: 24),
                    Text(
                      '$debiturName tidak termasuk dalam kategori DHN',
                      style: const TextStyle(
                        color: Color(0xff03213E),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildButton(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _iconPreview(String url, double scale) {
    String name = url.toLowerCase();
    if (name.contains('png') || name.contains('jpg') || name.contains('jpeg')) {
      return Image.network(
        url,
        width: 320,
        height: 184,
      );
    } else if (name.contains('pdf')) {
      return Center(
        child: Image.asset(
          IconConstants.pdf,
          scale: scale,
        ),
      );
    } else {
      return const Icon(Icons.image_not_supported_outlined);
    }
  }

  Widget _buildButton(BuildContext context) {
    return InkWell(
      mouseCursor: MaterialStateMouseCursor.clickable,
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: CustomColor.secondaryBlue,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: MediaQuery.of(context).size.width / 2.5,
        child: Text(
          'Sip, mengerti',
          textAlign: TextAlign.center,
          style: titleStyle16.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
