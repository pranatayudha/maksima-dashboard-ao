import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../application/app/app.locator.dart';
import '../../application/enums/dialog_type.dart';
import 'styles.dart';

class UploadItemButton extends StatelessWidget {
  final File? imageFile;
  final String label;
  final Function onPressed;
  final String? errorText;
  final double? fontSize;

  const UploadItemButton({
    required this.imageFile,
    required this.label,
    required this.onPressed,
    required this.errorText,
    this.fontSize = 16,
    Key? key,
  }) : super(key: key);

  Future _expandImage(File imageFile) async {
    await locator<DialogService>().showCustomDialog(
      variant: DialogType.imageFileExpand,
      data: {'imageFile': imageFile},
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 46.8,
                      height: 35.1,
                      color: Colors.black12,
                      child: imageFile != null
                          ? GestureDetector(
                              onTap: () => _expandImage(imageFile!),
                              child: Image.file(imageFile!, fit: BoxFit.cover),
                            )
                          : const Center(
                              child: Icon(Icons.image, color: Colors.black26),
                            ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(label, style: tsHeading10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15.0),
            if (imageFile == null)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromRGBO(11, 120, 237, 0.1),
                  side: const BorderSide(
                    color: Color.fromRGBO(72, 158, 251, 0.4),
                  ),
                ),
                onPressed: () => onPressed(),
                child: const Text('Upload', style: tsBody5PrimaryColor),
              )
            else
              IconButton(
                icon: const Icon(Icons.clear),
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => onPressed(),
              ),
          ],
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontSize: 12.0,
              ),
            ),
          ),
        const Divider(
          color: Colors.transparent,
          height: 20.0,
          thickness: 1.0,
        ),
      ],
    );
  }
}
