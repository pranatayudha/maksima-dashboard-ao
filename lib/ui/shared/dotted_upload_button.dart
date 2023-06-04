import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../application/app/constants/icon_constants.dart';

class DottedUploadButton extends StatelessWidget {
  const DottedUploadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(8.0),
      color: const Color(0xff99A0AF),
      dashPattern: const [8, 8],
      strokeWidth: 1.5,
      child: Card(
        color: const Color(0xffF8F9FA),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconConstants.upload,
                scale: 4,
                color: Colors.black,
              ),
              const SizedBox(width: 11.0),
              const Text(
                'Tambah Foto',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
