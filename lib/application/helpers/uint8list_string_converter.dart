import 'dart:convert';
import 'dart:typed_data';

Uint8List? uint8ListFromString(String? data) {
  return data != null ? base64Decode(data) : null;
}
