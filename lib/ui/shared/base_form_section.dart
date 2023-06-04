import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../application/app/constants/text_style_constants.dart';
import 'thick_light_grey_divider.dart';

class BaseFormSection extends StatelessWidget {
  final String? titleSection;
  final Widget leftSection;
  final Widget rightSection;
  final bool? isLast;
  const BaseFormSection({
    super.key,
    this.titleSection,
    required this.leftSection,
    required this.rightSection,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      children: [
        if (titleSection != null)
          Div(
            divison: const Division(
              colS: 12,
              colM: 12,
              colL: 12,
              colXL: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                titleSection!,
                style: titleStyle20,
              ),
            ),
          ),
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
                    colS: 6,
                    colM: 6,
                    colL: 6,
                    colXL: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: rightSection,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLast!)
          const Padding(
            padding: EdgeInsets.only(bottom: 14.0),
            child: ThickLightGreyDivider(
              verticalPadding: 0.0,
            ),
          ),
      ],
    );
  }
}
