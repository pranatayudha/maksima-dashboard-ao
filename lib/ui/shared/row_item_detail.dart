import 'package:flutter/material.dart';

class RowItemDetail extends StatelessWidget {
  final List<Widget> listWidget;
  const RowItemDetail({
    Key? key,
    required this.listWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: List.generate(
          listWidget.length,
          (index) => Expanded(
            child: listWidget[index],
          ),
        ),
      ),
    );
  }
}
