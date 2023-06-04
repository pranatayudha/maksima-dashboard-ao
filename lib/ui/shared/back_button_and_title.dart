import 'package:flutter/material.dart';

import 'styles.dart';

class BackButtonAndTitle extends StatelessWidget {
  final String title;
  final bool centerTitle;
  final IconData? iconData;
  final Function? onPressed;

  const BackButtonAndTitle(
    this.title, {
    this.centerTitle = false,
    this.iconData = Icons.arrow_back,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0, 20.0, 0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: 30.0,
            child: IconButton(
              icon: Icon(
                iconData,
                color: const Color(0xff606060),
              ),
              onPressed: onPressed != null
                  ? () => onPressed!()
                  : () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: centerTitle ? 30.0 : 0),
              child: Text(
                title,
                style: tsHeading6,
                textAlign: centerTitle ? TextAlign.center : TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
