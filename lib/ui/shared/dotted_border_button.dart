import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

class DottedBorderButton extends StatelessWidget {
  final String label;
  final Function? onTap;
  final double? height;

  const DottedBorderButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        color: const Color(0xffF1F8FF),
        child: InkWell(
          onTap: onTap != null ? () => onTap!() : null,
          child: DottedBorder(
            dashPattern: const <double>[5, 4],
            radius: const Radius.circular(4),
            color: const Color(0xff027DEF),
            borderType: BorderType.RRect,
            child: SizedBox(
              height: height ?? 40.0,
              child: Center(
                child: Text(label, style: tsHeading10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
