import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/controllers/custom_menu_controller.dart';
import '../../application/helpers/responsive_helpers.dart';

class Header extends StatelessWidget {
  final String username;
  final String personalNumber;
  final String photo;
  final Function() onPressedLogout;
  const Header({
    Key? key,
    required this.username,
    required this.personalNumber,
    required this.photo,
    required this.onPressedLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 72.0,
      child: Row(
        children: [
          if (!ResponsiveHelpers.isDesktop(context) &&
              !ResponsiveHelpers.isTablet(context))
            Container(
              height: double.infinity,
              width: 72.0,
              color: CustomColor.sideBarBackground,
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: context.read<CustomMenuController>().controlMenu,
                color: Colors.white,
              ),
            ),
          const Spacer(flex: 2),
          ProfileCard(
            username: username,
            personalNumber: personalNumber,
            photo: photo,
            onPressedLogout: onPressedLogout,
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String username;
  final String personalNumber;
  final String photo;
  final Function() onPressedLogout;
  const ProfileCard({
    Key? key,
    required this.username,
    required this.personalNumber,
    required this.photo,
    required this.onPressedLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    try {
      bytes = base64.decode(photo);
      // ignore: empty_catches
    } catch (e) {}

    return PopupMenuButton(
      tooltip: 'Logout',
      position: PopupMenuPosition.under,
      child: Container(
        margin: const EdgeInsets.only(right: 16.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0 / 2,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0 / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    personalNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: CustomColor.primaryBlue,
                foregroundImage: MemoryImage(bytes ?? Uint8List.fromList([])),
                child: Container(
                  decoration: const BoxDecoration(
                    color: CustomColor.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onSelected: (int index) {
        if (index == 1) {
          onPressedLogout();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}
