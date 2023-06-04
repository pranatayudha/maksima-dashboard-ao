import 'package:flutter/material.dart';

import '../../../../../../../../application/models/foto_kunjungan_model.dart';
import 'preview_foto_lkn.dart';

class OpenPreviewLKN {
  // ignore: long-parameter-list
  void openPreviewLKN({
    required BuildContext context,
    required double width,
    required FotoKunjunganModel data,
    String titleMain = 'Preview Foto Kunjungan',
    String titleSecondary = 'Lokasi Foto Kunjungan',
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: Container(
              height: MediaQuery.of(context).size.height,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: PreviewFotoLKN(
                  width: width,
                  data: data,
                  titleMain: titleMain,
                  titleSecondary: titleSecondary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
