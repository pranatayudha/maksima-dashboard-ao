import 'dart:io';

import 'package:file_picker/file_picker.dart';

String getFilename(File file) {
  return file.path.split('/').last.toString();
}

String getPlatFormFilename(PlatformFile file) {
  return (file.path ?? '').split('/').last.toString();
}
