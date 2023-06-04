import 'package:flutter/material.dart';

import '../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../application/app/constants/text_style_constants.dart';

class HeaderContent extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const HeaderContent({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle20,
        ),
        Visibility(
          visible: onTap != null,
          child: InkWell(
            mouseCursor: MaterialStateMouseCursor.clickable,
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(color: CustomColor.primaryBlue),
              ),
              child: Row(
                children: [
                  Image.asset(
                    IconConstants.iconEditBlue,
                    height: 20,
                  ),
                  Text(
                    'Ubah Data',
                    style: titleStyle16.copyWith(
                      color: CustomColor.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
