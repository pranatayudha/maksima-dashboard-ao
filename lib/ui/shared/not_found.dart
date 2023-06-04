import 'package:flutter/material.dart';

import '../../application/app/constants/image_constants.dart';

class NotFound extends StatelessWidget {
  final String label;

  const NotFound({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(ImageConstants.notFound, scale: 2),
        const SizedBox(height: 40.0),
        Text(
          label,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
