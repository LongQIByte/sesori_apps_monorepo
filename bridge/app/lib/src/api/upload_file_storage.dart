import "dart:io";
import "dart:typed_data";

import "package:path/path.dart" as p;

import "../foundation/data_directory_hardening.dart";

/// Files remain available until the bridge owner removes the uploads directory.
class const UploadFileStorage({required final String directoryPath}) {
  Future<String> write({required String name, required Uint8List bytes}) async {
    final root = createHardenedDirectory(directoryPath: directoryPath);
    final directory = await root.createTemp("upload-");
    try {
      await hardenPath(targetPath: directory.path, mode: ownerOnlyDirectoryMode);
      final file = File(p.join(directory.path, name));
      await file.writeAsBytes(bytes, flush: true);
      await hardenPath(targetPath: file.path, mode: ownerOnlyFileMode);
      return file.absolute.path;
    } catch (_) {
      await directory.delete(recursive: true);
      rethrow;
    }
  }
}
