import 'package:flutter/material.dart';

import '../../../../application/models/postal_code_model.dart';
import '../postal_code_view.dart';

class OpenPostalCode {
  void openDialog({
    required BuildContext context,
    required double width,
    required Function(PostalCodeModel) data,
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
              child: PostalCodeView(
                callBack: (val) => data(val),
              ),
            ),
          ),
        );
      },
    );
  }
}
