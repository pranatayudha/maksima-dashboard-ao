import 'package:flutter/material.dart';

import 'package:glass/glass.dart';

class ProcessingIndicator extends StatelessWidget {
  final String? label;
  final Color? labelColor;

  const ProcessingIndicator({
    this.label,
    this.labelColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            label ?? 'Processing...',
            style: TextStyle(
              color: labelColor ?? Colors.white,
            ),
          ),
        ],
      ).asGlass(),
    );
  }
}
