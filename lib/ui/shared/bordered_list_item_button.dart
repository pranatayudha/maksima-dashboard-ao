import 'package:flutter/material.dart';

class BorderedListItemButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final double? topAndBottomPadding;
  final double? leftPadding;
  final Color? borderColor;
  final double? margin;

  const BorderedListItemButton({
    required this.label,
    required this.onTap,
    this.topAndBottomPadding = 24.5,
    this.leftPadding = 20,
    this.borderColor = Colors.black12,
    this.margin = 20.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margin!),
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                leftPadding!,
                topAndBottomPadding!,
                10,
                topAndBottomPadding!,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor!,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.29,
                      color: Color(0xff666666),
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
