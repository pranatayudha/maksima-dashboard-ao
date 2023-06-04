import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DivTwoSection extends StatelessWidget {
  final Widget leftSection;
  final Widget rightSection;

  const DivTwoSection({
    super.key,
    required this.leftSection,
    required this.rightSection,
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
            child: leftSection,
          ),
        ),
        Div(
          divison: const Division(
            colS: 6,
            colM: 6,
            colL: 6,
            colXL: 6,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: rightSection,
          ),
        ),
      ],
    );
  }
}
