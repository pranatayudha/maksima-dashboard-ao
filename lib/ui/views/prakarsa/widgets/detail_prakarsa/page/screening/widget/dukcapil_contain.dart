import 'package:flutter/material.dart';

class DukcapilContain extends StatelessWidget {
  final String title;
  final String value;
  final String result;
  const DukcapilContain({
    Key? key,
    required this.title,
    required this.value,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(title),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xff03213E),
              ),
            ),
            Text(
              result,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: result == 'Sesuai' || result == 'Ditemukan'
                    ? const Color(0xff38BAA7)
                    : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
