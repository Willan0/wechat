import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> getFiles() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.any, allowMultiple: false);
  if (result != null) {
    File file = File(result.files.single.path ?? '');
    return file;
  }
  return null;
}