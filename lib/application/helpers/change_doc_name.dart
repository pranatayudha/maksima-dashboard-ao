import 'package:recase/recase.dart';

String changeDocName(String label) {
  const pattern = r'\b(skdp|amdal|ho|siujk)\b';
  final regExp = RegExp(pattern, caseSensitive: false);
  if (regExp.hasMatch(label)) {
    return label.toUpperCase();
  } else {
    return label.titleCase;
  }
}
