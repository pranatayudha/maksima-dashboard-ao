import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';

class InDevelopment extends StatelessWidget {
  const InDevelopment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.developer_mode, size: 200, color: CustomColor.primaryColor),
        SizedBox(height: 20),
        Text(
          'In Development',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.5,
            color: CustomColor.pumpkinOrange1,
          ),
        ),
      ],
    );
  }
}
