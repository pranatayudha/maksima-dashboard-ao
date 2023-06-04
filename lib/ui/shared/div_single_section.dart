import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DivSingleSection extends StatelessWidget {
  final Widget widget;

  const DivSingleSection({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      children: [
        Div(
          divison: const Division(
            colS: 12,
            colM: 12,
            colL: 12,
            colXL: 12,
          ),
          child: widget,
        ),
      ],
    );
  }
}
