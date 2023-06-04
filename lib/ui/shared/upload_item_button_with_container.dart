import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

class UploadItemButtonWithContainer extends StatelessWidget {
  final PlatformFile? file;
  final String? path;
  final String label;
  final Function onPressed;
  final String? errorText;
  final double? fontSize;

  const UploadItemButtonWithContainer({
    required this.file,
    required this.path,
    required this.label,
    required this.onPressed,
    required this.errorText,
    this.fontSize = 16,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (file == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  // style: tsHeading10,
                ),
              ),
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
              ),
            ],
          )
        else ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
            // style: tsHeading10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(11, 120, 237, 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: AutoSizeText(
                      path ?? '',
                      style: tsHeading10,
                    ),
                  ),
                ),
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
          ),
        ],
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
      ],
    );
  }
}
