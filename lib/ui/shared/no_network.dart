// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../../application/app/constants/image_constants.dart';
import 'custom_button.dart';
import 'styles.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.blueTexturedBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: statusBarHeight + 71,
            right: 40,
            child: Image.asset(ImageConstants.noWifi, scale: 3),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: MediaQuery.of(context).size.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Offline', style: tsHeading1White),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(right: 53),
                  child: Text(
                    'Anda saat ini sedang tidak terhubung dengan koneksi internet. Silahkan periksa jaringan Anda dan cobalah kembali.',
                    style: tsBody6White,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200.0,
                  child: CustomButton(
                    label: 'OK',
                    color: Colors.white,
                    labelColor: const Color(0xff0F6FC2),
                    radius: 8,
                    onPressed: () => html.window.location.reload(),
                    isBusy: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
