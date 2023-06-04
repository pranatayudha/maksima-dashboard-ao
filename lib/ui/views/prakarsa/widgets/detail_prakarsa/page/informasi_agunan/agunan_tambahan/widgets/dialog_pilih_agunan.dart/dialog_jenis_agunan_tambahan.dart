import 'package:flutter/material.dart';

import 'content_dialog_agunan_view.dart';

class DialogJenisAgunanTambahan {
  void openDialog({
    required BuildContext context,
    required double width,
    required Function(String) data,
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
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: ContentDialogAgunanView(
                callBack: (val) => data(val),
              ),
            ),
          ),
        );
      },
    );
  }
}
