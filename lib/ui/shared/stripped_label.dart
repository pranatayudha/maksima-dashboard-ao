import 'package:flutter/material.dart';

class StrippedLabel extends StatelessWidget {
  final String label;

  const StrippedLabel({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black12,
        border: Border(top: BorderSide(), bottom: BorderSide()),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.8,
          ),
        ),
      ),
    );
  }
}
