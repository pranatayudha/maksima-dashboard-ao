// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GridItemDetail extends StatelessWidget {
  List<Widget> listWidget;

  GridItemDetail({Key? key, required this.listWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: listWidget.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          maxCrossAxisExtent: 200,
        ),
        itemBuilder: (context, index) {
          return listWidget[index];
        },
      ),
    );
  }
}
