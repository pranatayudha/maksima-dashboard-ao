import 'package:flutter/material.dart';

import '../../application/app/constants/text_style_constants.dart';

class CustomEmptyState extends StatelessWidget {
  final double height;
  final String title;
  final String subTitle;
  final String imageAsset;
  const CustomEmptyState({
    Key? key,
    required this.height,
    required this.title,
    required this.subTitle,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Image.asset(
              imageAsset,
              height: height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: titleStyle16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subTitle,
                style: normalStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
