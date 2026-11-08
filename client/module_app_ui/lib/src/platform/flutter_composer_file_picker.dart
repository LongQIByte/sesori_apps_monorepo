import "dart:typed_data";

import "package:desktop_drop/desktop_drop.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/foundation.dart" show TargetPlatform, defaultTargetPlatform, kIsWeb;
import "package:flutter/widgets.dart";
import "package:saf_stream/saf_stream.dart";
import "package:saf_util/saf_util.dart";
import "package:saf_util/saf_util_platform_interface.dart" show SafDocumentFile;
import "package:sesori_dart_core/sesori_dart_core.dart";
import "package:sesori_shared/sesori_shared.dart" show maxUploadedFileBytes;

class const FlutterComposerFilePicker() implements ComposerFilePicker {
  @override
  Future<List<ComposerLocalFile>> pickFiles() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final selected = await SafUtil().pickFiles();
      return (selected ?? []).map(_AndroidComposerLocalFile.new).toList(growable: false);
    }
    return (await FilePicker.pickFiles()).map(_PickedComposerLocalFile.new).toList(growable: false);
  }
}

class const _AndroidComposerLocalFile(final SafDocumentFile file) implements ComposerLocalFile {
  @override
  String get name => file.name;
  @override
  Future<int> length() async => file.length < 0 ? 0 : file.length;
  @override
  Future<Uint8List> readBytes() async {
    final bytes = BytesBuilder(copy: false);
    final reader = SafStream();
    final session = await reader.startReadCustomFileStream(file.uri, bufferSize: 64 * 1024);
    try {
      while (true) {
        final chunk = await reader.readCustomFileStreamChunk(session);
        if (chunk == null || chunk.isEmpty) break;
        if (bytes.length + chunk.length > maxUploadedFileBytes) throw const FormatException("File exceeds 50 MB");
        bytes.add(chunk);
        await Future<void>.delayed(Duration.zero);
      }
    } finally {
      await reader.endReadCustomFileStream(session);
    }
    return bytes.takeBytes();
  }
}

class const _PickedComposerLocalFile(final PlatformFile file) implements ComposerLocalFile {
  @override
  String get name => file.name;
  @override
  Future<int> length() async => await file.length() ?? (throw StateError("File size is unavailable"));
  @override
  Future<Uint8List> readBytes() => file.readAsBytes();
}

class const _DroppedComposerLocalFile(final DropItem file) implements ComposerLocalFile {
  @override
  String get name => file.name;
  @override
  Future<int> length() => file.length();
  @override
  Future<Uint8List> readBytes() => file.readAsBytes();
}

class const ComposerFileDropTarget({
  super.key,
  required final Widget child,
  required final void Function(List<ComposerLocalFile> files) onFiles,
  required final VoidCallback onUnsupportedDrop,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DropTarget(
    onDragDone: (details) {
      if (details.files.any((item) => item is! DropItemFile)) {
        onUnsupportedDrop();
        return;
      }
      onFiles(details.files.map(_DroppedComposerLocalFile.new).toList(growable: false));
    },
    child: child,
  );
}
