import 'package:flutter/material.dart';

import 'header.dart';

class BaseView extends StatelessWidget {
  final String username;
  final String personalNumber;
  final String photo;
  final Function() onPressedLogout;
  const BaseView({
    super.key,
    required this.username,
    required this.personalNumber,
    required this.photo,
    required this.onPressedLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            Header(
              username: username,
              personalNumber: personalNumber,
              photo: photo,
              onPressedLogout: onPressedLogout,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
