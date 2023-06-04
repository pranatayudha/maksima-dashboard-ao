import 'package:flutter/material.dart';

import 'custom_circular_progress_indicator.dart';

class RoundedCornerButton extends StatelessWidget {
  final String label;
  final Function? onPressed;
  final bool isBusy;

  const RoundedCornerButton({
    required this.label,
    required this.onPressed,
    required this.isBusy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: TextButton(
        onPressed: onPressed != null ? () => onPressed!() : null,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xff1A1A1A),
          backgroundColor: onPressed != null
              ? const Color(0xffF5A577).withOpacity(0.5)
              : Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23.0),
          ),
        ),
        child: isBusy
            ? const CustomCircularProgressIndicator()
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.29,
                ),
              ),
      ),
    );
  }
}
