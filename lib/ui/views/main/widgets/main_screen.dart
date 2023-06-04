import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../application/controllers/custom_menu_controller.dart';
import 'side_menu.dart';
import 'sidebar_menu.dart';

class MainScreen extends StatelessWidget {
  final String username;
  final String personalNumber;
  final String photo;
  final int selectedPage;
  final Function() onPressedLogout;
  final Function(int i) onChanged;
  const MainScreen({
    super.key,
    required this.username,
    required this.personalNumber,
    required this.photo,
    required this.onPressedLogout,
    required this.selectedPage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<CustomMenuController>().scaffoldKey,
      drawer: SideMenu(
        onTap: (i) => onChanged(i),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SidebarPage(
                username: username,
                personalNumber: personalNumber,
                photo: photo,
                onPressedLogout: onPressedLogout,
                selectedPage: selectedPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
