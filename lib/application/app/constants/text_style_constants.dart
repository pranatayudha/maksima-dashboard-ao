import 'package:flutter/material.dart';

import 'custom_color.dart';

var titleStyle24 = const TextStyle(
  fontSize: 24,
  color: CustomColor.black,
  fontWeight: FontWeight.w700,
);
var titleStyle20 = titleStyle24.copyWith(fontSize: 20);
var titleStyle16 = titleStyle24.copyWith(fontSize: 16);
var titleStyle14 = titleStyle24.copyWith(fontSize: 14);

var normalStyle = const TextStyle(
  fontSize: 14,
  color: CustomColor.black,
  fontWeight: FontWeight.w400,
);
var valueNominalStyle = normalStyle.copyWith(color: CustomColor.primaryOrange);

var valueStatusStyle = const TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

var initialName = const TextStyle(
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

var titleValue = const TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: CustomColor.darkGrey,
);

var valueStyle = const TextStyle(
  fontSize: 16,
  color: CustomColor.black,
  fontWeight: FontWeight.w400,
);

var warningStyle = const TextStyle(
  fontSize: 14,
  color: CustomColor.primaryRed,
  fontWeight: FontWeight.w400,
);
