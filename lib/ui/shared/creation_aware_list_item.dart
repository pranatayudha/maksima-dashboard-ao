// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CreationAwareListItem extends StatefulWidget {
  final Function() itemCreated;
  final Widget child;

  const CreationAwareListItem({
    required this.itemCreated,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _CreationAwareListItemState createState() => _CreationAwareListItemState();
}

class _CreationAwareListItemState extends State<CreationAwareListItem> {
  @override
  void initState() {
    super.initState();
    widget.itemCreated();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
