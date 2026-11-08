import "dart:typed_data";

abstract interface class ComposerLocalFile {
  String get name;
  Future<int> length();
  Future<Uint8List> readBytes();
}

abstract interface class ComposerFilePicker {
  Future<List<ComposerLocalFile>> pickFiles();
}
