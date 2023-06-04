import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../flavors.dart';
import 'app.router.dart';
import 'constants/custom_color.dart';
import 'theme/palette.dart';

class PinangMaksimaDashboardAO extends StatelessWidget {
  const PinangMaksimaDashboardAO({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 2560,
        minWidth: 425,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(425, name: MOBILE),
          ResponsiveBreakpoint.resize(768, name: TABLET),
          ResponsiveBreakpoint.resize(1024, name: DESKTOP),
          ResponsiveBreakpoint.resize(1440, name: DESKTOP),
          ResponsiveBreakpoint.resize(2560, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1440, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2560, name: DESKTOP),
        ],
      ),
      title: F.variables['title'],
      theme: ThemeData(
        primarySwatch: Palette.primaryBlue,
        primaryColor: CustomColor.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Nunito',
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
