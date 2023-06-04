// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class SpaceWidth extends StatelessWidget {
  final double width;
  const SpaceWidth(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SpaceWidth2 extends StatelessWidget {
  const SpaceWidth2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 2,
    );
  }
}

class SpaceWidth4 extends StatelessWidget {
  const SpaceWidth4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 4,
    );
  }
}

class SpaceWidth10 extends StatelessWidget {
  const SpaceWidth10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 10,
    );
  }
}
