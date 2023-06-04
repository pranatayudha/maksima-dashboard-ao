import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../application/app/constants/icon_constants.dart';
import 'styles.dart';

class DottedBorderButtonIcon extends StatelessWidget {
  final String labelButton;
  final String? label;
  final Function? onTap;

  const DottedBorderButtonIcon({
    required this.labelButton,
    this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: tsCaption1,
          ),
          const SizedBox(height: 6),
        ],
        Material(
          child: Ink(
            color: const Color(0xffF8F9FA),
            child: InkWell(
              onTap: onTap != null ? () => onTap!() : null,
              child: DottedBorder(
                dashPattern: const [8, 8],
                radius: const Radius.circular(4),
                color: const Color(0xff99A0AF),
                borderType: BorderType.RRect,
                child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconConstants.upload,
                        scale: 4,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 11.0),
                      Text(
                        labelButton,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
