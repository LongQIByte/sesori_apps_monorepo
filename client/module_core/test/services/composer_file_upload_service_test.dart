import "dart:async";
import "dart:convert";
import "dart:typed_data";

import "package:mocktail/mocktail.dart";
import "package:sesori_dart_core/src/capabilities/server_connection/connection_service.dart";
import "package:sesori_dart_core/src/foundation/platform/composer_file_picker.dart";
import "package:sesori_dart_core/src/repositories/upload_file_repository.dart";
import "package:sesori_dart_core/src/services/composer_file_upload_service.dart";
import "package:sesori_shared/sesori_shared.dart";
import "package:test/test.dart";

class _Connection() extends Mock implements ConnectionService;
class _Repository() extends Mock implements UploadFileRepository;
class _Target() implements ConnectedBridgeHandle;

class _LargeFile() implements ComposerLocalFile {
  @override
  String get name => "video.mp4";
  @override
  Future<int> length() async => maxUploadedFileBytes + 1;
  @override
  Future<Uint8List> readBytes() => throw StateError("Oversized file must not be read");
}

void main() {
  test("rejects an oversized file before reading it", () async {
    final service = ComposerFileUploadService(repository: _Repository(), connection: _Connection());
    await expectLater(service.readFile(file: _LargeFile()), throwsFormatException);
  });
  test("does not return a path after the selected bridge changes", () async {
    final connection = _Connection();
    final repository = _Repository();
    final target = _Target();
    const request = UploadFileRequest(name: "source.py", base64: "AQID");
    final started = Completer<void>();
    final response = Completer<String>();
    var current = true;
    when(() => connection.isConnectedBridgeCurrent(handle: target)).thenAnswer((_) => current);
    when(() => repository.upload(body: jsonEncode(request))).thenAnswer((_) {
      started.complete();
      return response.future;
    });
    final service = ComposerFileUploadService(repository: repository, connection: connection);
    final result = service.upload(
      target: target,
      name: "source.py",
      bytes: Uint8List.fromList([1, 2, 3]),
      isDraftCurrent: () => true,
    );
    await started.future;
    current = false;
    response.complete("/bridge/source.py");
    await expectLater(result, throwsStateError);
  });
}
