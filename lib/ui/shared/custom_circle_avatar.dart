import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/icon_constants.dart';

class CustomCircleAvatar extends StatelessWidget {
  final Uint8List? photo;
  final double? outerRadius;
  final double? innerRadius;

  const CustomCircleAvatar(
    this.photo, {
    this.outerRadius,
    this.innerRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: outerRadius ?? 68,
        backgroundColor: CustomColor.lightGrey,
        child: photo != null && photo!.isNotEmpty
            ? CircleAvatar(
                radius: innerRadius ?? 60,
                backgroundImage: MemoryImage(photo!),
              )
            : CircleAvatar(
                radius: innerRadius ?? 60,
                backgroundImage: const AssetImage(IconConstants.person),
              ),
      ),
    );
  }
}
