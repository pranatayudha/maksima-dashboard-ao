import 'package:flutter/material.dart';

import '../../../../../../application/helpers/responsive_helpers.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final double? height;
  const BaseView({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(
        left: ResponsiveHelpers.isDesktop(context) ? 16 : 0,
      ),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: child,
    );
  }
}
