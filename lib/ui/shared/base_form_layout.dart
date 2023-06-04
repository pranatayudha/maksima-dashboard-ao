import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../application/app/constants/text_style_constants.dart';

class BaseFromLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget rightSection;
  const BaseFromLayout({
    super.key,
    this.title,
    this.subtitle,
    required this.rightSection,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Responsive(
              children: [
                Div(
                  divison: const Division(
                    colS: 4,
                    colM: 4,
                    colL: 4,
                    colXL: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          style: titleStyle16,
                        ),
                        Text(
                          subtitle ?? '',
                          style: titleValue,
                        ),
                      ],
                    ),
                  ),
                ),
                Div(
                  divison: const Division(
                    colS: 8,
                    colM: 8,
                    colL: 8,
                    colXL: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: rightSection,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
