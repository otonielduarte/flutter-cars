import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class UploadModel {
  final String fileName;
  final String mimeType;
  final String base64;

  const UploadModel(this.fileName, this.mimeType, this.base64);

  Map<String, dynamic> toJson() => {
        'fileName': this.fileName,
        'mimeType': this.mimeType,
        'base64': this.base64
      };

  UploadModel.fromFile(File file, String mimeType)
      : fileName = path.basename(file.path),
        mimeType = mimeType,
        base64 = base64Encode(file.readAsBytesSync());
}
