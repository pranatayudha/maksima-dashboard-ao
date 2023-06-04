import 'package:flutter/material.dart';

class PreSreeningRowItem extends StatelessWidget {
  final String leftTitle;
  final String leftValue;
  final String rightTitle;
  final String rightValue;
  const PreSreeningRowItem({
    Key? key,
    required this.leftTitle,
    required this.leftValue,
    required this.rightTitle,
    required this.rightValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          SizedBox(
            width: 304,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff66788A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  leftValue.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff03213E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          if (rightTitle != '')
            SizedBox(
              width: 304,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rightTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff66788A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rightValue.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff03213E),
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
