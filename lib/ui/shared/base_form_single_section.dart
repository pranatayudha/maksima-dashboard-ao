import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/text_style_constants.dart';
import 'thick_light_grey_divider.dart';

class BaseFormSingleSection extends StatelessWidget {
  final String? titleSection;
  final Widget widget;
  final bool? isLast;
  final bool? haveAction;
  final String? actionText;
  final Function? onPressed;
  const BaseFormSingleSection({
    super.key,
    this.titleSection,
    required this.widget,
    this.isLast = false,
    this.haveAction = false,
    this.onPressed,
    this.actionText,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleSection!,
                  style: titleStyle20,
                ),
                if (haveAction!)
                  TextButton(
                    onPressed: haveAction!
                        ? onPressed != null
                            ? () => onPressed!()
                            : null
                        : null,
                    child: Text(
                      actionText!,
                      style: titleStyle20.copyWith(
                        color: CustomColor.secondaryBlue,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
              ],
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
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: widget,
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
