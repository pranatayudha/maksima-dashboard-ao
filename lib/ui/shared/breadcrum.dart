import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../application/app/constants/text_style_constants.dart';
import '../../application/helpers/responsive_helpers.dart';

class BreadCrum extends StatelessWidget {
  final double width;
  final List<String> breadCrum;
  final void Function() onTapBack;
  final Function(String val) onTapBreadCrum;
  const BreadCrum({
    Key? key,
    required this.width,
    required this.breadCrum,
    required this.onTapBack,
    required this.onTapBreadCrum,
  }) : super(key: key);

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
            padding: const EdgeInsets.only(bottom: 6),
            child: Responsive(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Div(
                  divison: const Division(
                    colS: 5,
                    colM: 5,
                    colL: 5,
                    colXL: 5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: titleHeader(context),
                  ),
                ),
                Div(
                  divison: const Division(
                    colS: 7,
                    colM: 7,
                    colL: 7,
                    colXL: 7,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: buildbreadCrum(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget titleHeader(BuildContext context) {
    return Row(
      children: [
        if (breadCrum.length > 1)
          InkWell(
            onTap: onTapBack,
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
        if (breadCrum.isNotEmpty)
          Text(
            breadCrum.last,
            style: titleStyle24,
          ),
      ],
    );
  }

  Widget buildbreadCrum(BuildContext context) {
    return Row(
      mainAxisAlignment: ResponsiveHelpers.isMobile(context)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: List.generate(
        breadCrum.length < 4 ? breadCrum.length : 4,
        (index) {
          bool isOverFlow = breadCrum.length > 3;
          int pos =
              breadCrum.length < 4 ? index : (breadCrum.length - 4) + index;
          String flag = breadCrum[pos];
          bool isTapable = pos != breadCrum.length - 1;

          return (isOverFlow && index == 0)
              ? Text(
                  '...',
                  style: normalStyle.copyWith(
                    decoration: isTapable ? TextDecoration.underline : null,
                  ),
                )
              : InkWell(
                  onTap: isTapable ? () => onTapBreadCrum(flag) : null,
                  child: Text(
                    '${pos != 0 ? '/ ' : ''}$flag ',
                    style: normalStyle.copyWith(
                      decoration: isTapable ? TextDecoration.underline : null,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
