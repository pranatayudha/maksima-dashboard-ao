import 'package:flutter/material.dart';

import 'styles.dart';

class AppBarWidget extends AppBar {
  AppBarWidget.titleWithBackButton({
    Key? key,
    required String title,
    required Function onBackButtonTapped,
    Color? color,
  }) : super(
          key: key,
          elevation: 0,
          backgroundColor: color ?? Colors.white,
          title: Text(title, style: tsHeading6),
          centerTitle: true,
          leading: Container(
            padding: EdgeInsets.zero,
            width: 30.0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff606060),
                size: 24.0,
              ),
              onPressed: () => onBackButtonTapped(),
            ),
          ),
        );
}
