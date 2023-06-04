import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DivSingleHalfSection extends StatelessWidget {
  final Widget widget;

  const DivSingleHalfSection({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      children: [
        Div(
          divison: const Division(
            colS: 6,
            colM: 6,
            colL: 6,
            colXL: 6,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: widget,
          ),
        ),
      ],
    );
  }
}
