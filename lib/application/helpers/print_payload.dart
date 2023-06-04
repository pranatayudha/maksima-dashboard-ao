import 'dart:convert';

import 'package:flutter/material.dart';

void printPayload(dynamic payload) {
  JsonEncoder encoder = const JsonEncoder.withIndent(' ');
  String prettyprint = encoder.convert(payload);

  return debugPrint(prettyprint);
}
