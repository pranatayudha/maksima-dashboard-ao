import 'package:flutter/material.dart';

import '../../application/app/constants/image_constants.dart';
import '../../application/app/constants/text_style_constants.dart';

class NotExistPhoto extends StatelessWidget {
  final String desc;
  const NotExistPhoto({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstants.imageNotFound521,
          height: 50,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            desc,
            style: warningStyle,
          ),
        ),
      ],
    );
  }
}
