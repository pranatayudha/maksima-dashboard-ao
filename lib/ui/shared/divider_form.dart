import 'package:flutter/material.dart';

import 'thick_light_grey_divider.dart';

class DividerForm extends StatelessWidget {
  const DividerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: ThickLightGreyDivider(
        verticalPadding: 0.0,
      ),
    );
  }
}
