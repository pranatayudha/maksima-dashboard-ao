import 'package:flutter/material.dart';

import '../../application/app/constants/image_constants.dart';

class ServerMaintenance extends StatelessWidget {
  const ServerMaintenance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(ImageConstants.serverMaintenance),
              const SizedBox(height: 55.0),
              const Text(
                'Server Maintenance',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Pinang Mikro sedang dalam pemeliharaan sistem, kami akan segera kembali sesaat lagi.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff2A2929),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
