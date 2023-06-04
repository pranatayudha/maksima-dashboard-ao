// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import 'custom_circular_progress_indicator.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final bool isBusy;
  final Color? color;
  final double? radius;
  final double? height;
  final double? labelSize;
  final bool isOutlineButton;

  const CustomButton({
    Key? key,
    required this.label,
    this.labelColor,
    required this.onPressed,
    required this.isBusy,
    this.color,
    this.radius,
    this.height,
    this.labelSize,
    this.isOutlineButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 4),
      child: SizedBox(
        height: height ?? 40,
        width: double.infinity,
        child: isOutlineButton ? _outlineButton() : _elvetedButton(),
      ),
    );
  }

  OutlinedButton _outlineButton() {
    return OutlinedButton(
      onPressed: onPressed != null ? () => onPressed!() : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 2.0, color: color ?? const Color(0xff027DEF)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
      ),
      child: isBusy
          ? const CustomCircularProgressIndicator()
          : Text(
              label,
              style: TextStyle(
                fontSize: labelSize ?? 16,
                fontWeight: FontWeight.bold,
                color: labelColor ?? const Color(0xff027DEF),
              ),
              overflow: TextOverflow.ellipsis,
            ),
    );
  }

  ElevatedButton _elvetedButton() {
    return ElevatedButton(
      onPressed: onPressed != null ? () => onPressed!() : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return CustomColor.darkGrey;
          }
          // ignore: newline-before-return
          return color ?? CustomColor.secondaryBlue;
        }),
      ),
      child: isBusy
          ? const CustomCircularProgressIndicator()
          : Text(
              label,
              style: TextStyle(
                fontSize: labelSize ?? 16,
                fontWeight: FontWeight.bold,
                color: labelColor ?? Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}
