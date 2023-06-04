import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';

class MemuatDataIndicator extends StatelessWidget {
  const MemuatDataIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text(
          'Memuat data...',
          style: TextStyle(color: CustomColor.primaryBlack),
        ),
      ],
    );
  }
}
