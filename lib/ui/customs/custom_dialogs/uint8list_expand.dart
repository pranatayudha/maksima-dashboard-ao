import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class Uint8ListExpandDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const Uint8ListExpandDialog({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Image.memory(
        request!.data['image'] as Uint8List,
        fit: BoxFit.cover,
      ),
    );
  }
}
