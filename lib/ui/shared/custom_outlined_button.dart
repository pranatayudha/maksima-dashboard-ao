import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final bool blackWeightLabel;
  final double? height;
  final double? borderWidth;
  final Color? color;
  final Color? borderColor;
  final bool? withShadow;
  final double? elevation;
  final double? radius;
  final double? labelSize;

  const CustomOutlinedButton({
    required this.label,
    this.labelColor,
    required this.onPressed,
    this.blackWeightLabel = false,
    this.height,
    this.borderWidth,
    this.color,
    this.borderColor,
    this.withShadow = true,
    this.elevation,
    this.radius,
    this.labelSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 40.0,
      child: OutlinedButton(
        onPressed: onPressed != null ? () => onPressed!() : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color ?? Colors.white,
          elevation: elevation ?? 5,
          shadowColor:
              withShadow! ? const Color.fromRGBO(109, 169, 234, 0.25) : null,
          side: onPressed != null
              ? BorderSide(
                  width: borderWidth ?? 1.0,
                  color: borderColor ?? const Color(0xff027DEF),
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 4.0),
          ),
        ),
        child: Text(
          label,
          style: onPressed != null
              ? TextStyle(
                  fontSize: labelSize ?? 16.0,
                  fontWeight: FontWeight.bold,
                  color: labelColor ?? CustomColor.secondaryBlue,
                )
              : TextStyle(
                  fontSize: labelSize ?? 16.0,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.darkGrey,
                ),
        ),
      ),
    );
  }
}
