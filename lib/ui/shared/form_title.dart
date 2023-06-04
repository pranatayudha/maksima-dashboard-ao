import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String title;
  final Function onBackArrowPressed;
  final Function onForwardArrowPressed;
  final bool hideForwardArrow;

  const FormTitle(
    this.title, {
    required this.onBackArrowPressed,
    required this.onForwardArrowPressed,
    required this.hideForwardArrow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff606060),
          ),
          onPressed: () => onBackArrowPressed(),
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.32,
              color: Color(0xff1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (hideForwardArrow)
          const SizedBox(width: 48)
        else
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Color(0xff606060),
            ),
            onPressed: () => onForwardArrowPressed(),
          ),
      ],
    );
  }
}
