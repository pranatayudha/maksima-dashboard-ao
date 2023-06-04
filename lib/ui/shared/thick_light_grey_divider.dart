import 'package:flutter/material.dart';

class ThickLightGreyDivider extends StatelessWidget {
  final double? height;
  final double? verticalPadding;

  const ThickLightGreyDivider({
    Key? key,
    this.height = 2.0,
    this.verticalPadding = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding!),
      child: Container(
        height: height,
        width: double.infinity,
        color: Colors.grey.shade100,
      ),
    );
  }
}
