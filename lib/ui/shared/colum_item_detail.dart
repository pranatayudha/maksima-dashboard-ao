// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ColumnItemDetail extends StatelessWidget {
  List<Widget> listWidget;
  ColumnItemDetail({Key? key, required this.listWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          listWidget.length,
          (index) => Container(
            child: listWidget[index],
          ),
        ),
      ),
    );
  }
}
