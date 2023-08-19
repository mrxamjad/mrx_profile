import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerServices {
  // Pick Pdf from file

  static Future pickPdf(File? file, String? fileName) async {
    final pickedPdf = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowCompression: true,
        allowedExtensions: ['pdf']);

    if (pickedPdf != null) {
      file = File(pickedPdf.files[0].path!);
      fileName = pickedPdf.files[0].name;
      debugPrint("Pdf Picked: $fileName");
      debugPrint("Pdf Picked: $file");
    } else {
      debugPrint("No file Selected");
    }
    return file;
  }
}
