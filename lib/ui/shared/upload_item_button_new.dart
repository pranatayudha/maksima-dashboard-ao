import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/icon_constants.dart';
import '../../application/enums/dialog_type.dart';
import 'styles.dart';

class UploadItemButtonNew extends StatelessWidget {
  final String? imageUrl;
  final String label;
  final Function onPressed;
  final String? errorText;
  final double? fontSize;

  const UploadItemButtonNew({
    required this.imageUrl,
    required this.label,
    required this.onPressed,
    required this.errorText,
    this.fontSize = 16,
    Key? key,
  }) : super(key: key);

  Future _expandImage(String imageUrl) async {
    await locator<DialogService>().showCustomDialog(
      variant: DialogType.maksimaImageFileExpand,
      data: {'imageFile': imageUrl},
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageUrl == null)
          InkWell(
            onTap: () {
              onPressed();
            },
            child: DottedBorder(
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
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        else
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
                        child: imageUrl != null
                            ? GestureDetector(
                                onTap: () => _expandImage(imageUrl!),
                                child:
                                    Image.network(imageUrl!, fit: BoxFit.cover),
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
              if (imageUrl == null)
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
        const SizedBox(height: 16.0),
      ],
    );
  }
}
