import "dart:convert";

import "package:sesori_shared/sesori_shared.dart";

import "../api/upload_file_storage.dart";

class const UploadFileRepository({required final UploadFileStorage storage}) {
  Future<String> upload({required UploadFileRequest request}) async {
    final name = request.name;
    if (name.isEmpty ||
        name.length > 200 ||
        name == "." ||
        name == ".." ||
        RegExp(r'[\\/<>:"|?*\x00-\x1f]').hasMatch(name) ||
        name.endsWith(".") ||
        name.endsWith(" ") ||
        RegExp(r'^(CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(\.|$)', caseSensitive: false).hasMatch(name)) {
      throw const FormatException("Invalid file name");
    }
    if (request.base64.length > ((maxUploadedFileBytes + 2) ~/ 3) * 4) {
      throw const FormatException("File exceeds upload limit");
    }
    final bytes = base64Decode(request.base64);
    if (bytes.length > maxUploadedFileBytes) throw const FormatException("File exceeds upload limit");
    return await storage.write(name: name, bytes: bytes);
  }
}
