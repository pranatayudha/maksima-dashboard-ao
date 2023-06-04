import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double? paddingHorizontal;

  const CustomLinearProgressIndicator({
    this.paddingHorizontal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LinearProgressIndicator(),
          SizedBox(height: 8.0),
          Text(
            'Memuat data...',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
