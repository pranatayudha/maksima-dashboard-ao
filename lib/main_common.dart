import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'application/app/app.locator.dart';
import 'application/app/pinang_maksima_dashboard_ao.dart';
import 'application/helpers/my_http_overrides.dart';
import 'infrastructure/database/hive_db.dart';
import 'ui/customs/custom_bottom_sheets/setup_bottom_sheet_ui.dart';
import 'ui/customs/custom_dialogs/setup_dialog_ui.dart';

Future mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // Android
      statusBarIconBrightness: Brightness.dark, // Android
      statusBarBrightness: Brightness.light, // iOS
    ),
  );

  await HiveDB.init();

  setupLocator();
  setupDialogUI();
  setupBottomSheetUI();
  // setupSnackbarUI();
  initializeDateFormatting();

  HttpOverrides.global = MyHttpOverrides();

  // responsive_ui package's for using Div and Responsive widgets
  Responsive.setGlobalBreakPoints(0, 425.0, 768.0, 1024.0);
  Responsive.setGlobalBreakPoints(425.0, 768.0, 1024.0, 1440.0);
  Responsive.setGlobalBreakPoints(768.0, 1024.0, 1440.0, 2560.0);

  runApp(const PinangMaksimaDashboardAO());
}
