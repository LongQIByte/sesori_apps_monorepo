import "dart:convert";
import "dart:isolate";
import "dart:typed_data";

import "package:injectable/injectable.dart";
import "package:sesori_shared/sesori_shared.dart";

import "../capabilities/server_connection/connection_service.dart";
import "../foundation/platform/composer_file_picker.dart";
import "../repositories/upload_file_repository.dart";

@lazySingleton
class ComposerFileUploadService({
  required final UploadFileRepository repository,
  required final ConnectionService connection,
}) {
  ConnectedBridgeHandle captureTarget() =>
      connection.captureConnectedBridge() ?? (throw StateError("No bridge connected"));

  bool isCurrent({required ConnectedBridgeHandle target}) => connection.isConnectedBridgeCurrent(handle: target);

  Future<Uint8List> readFile({required ComposerLocalFile file}) async {
    if (await file.length() > maxUploadedFileBytes) throw const FormatException("File exceeds 50 MB");
    final bytes = await file.readBytes();
    if (bytes.length > maxUploadedFileBytes) throw const FormatException("File exceeds 50 MB");
    return bytes;
  }

  Future<String> upload({
    required ConnectedBridgeHandle target,
    required String name,
    required Uint8List bytes,
    required bool Function() isDraftCurrent,
  }) async {
    if (bytes.length > maxUploadedFileBytes) throw const FormatException("File exceeds 50 MB");
    if (!isCurrent(target: target)) throw StateError("Bridge changed during upload");
    final body = await Isolate.run(() => jsonEncode(UploadFileRequest(name: name, base64: base64Encode(bytes))));
    if (!isDraftCurrent() || !isCurrent(target: target)) throw StateError("Bridge or draft changed during upload");
    final path = await repository.upload(body: body);
    if (!isCurrent(target: target)) throw StateError("Bridge changed during upload");
    return path;
  }
}
