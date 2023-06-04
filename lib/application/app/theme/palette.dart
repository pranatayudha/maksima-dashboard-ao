import 'package:flutter/material.dart';

class Palette {
  static MaterialColor primaryBlue = MaterialColor(
    0xff027DEF, //0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: const Color(0xff027DEF).withOpacity(0.1), //10%
      100: const Color(0xff027DEF).withOpacity(0.2), //20%
      200: const Color(0xff027DEF).withOpacity(0.3), //30%
      300: const Color(0xff027DEF).withOpacity(0.4), //40%
      400: const Color(0xff027DEF).withOpacity(0.5), //50%
      500: const Color(0xff027DEF).withOpacity(0.6), //60%
      600: const Color(0xff027DEF).withOpacity(0.7), //70%
      700: const Color(0xff027DEF).withOpacity(0.8), //80%
      800: const Color(0xff027DEF).withOpacity(0.9), //90%
      900: const Color(0xff027DEF), //100%
    },
  );
}
