import "dart:convert";
import "dart:io";

import "package:sesori_bridge/src/api/upload_file_storage.dart";
import "package:sesori_bridge/src/repositories/upload_file_repository.dart";
import "package:sesori_shared/sesori_shared.dart";
import "package:test/test.dart";

void main() {
  late Directory root;
  late UploadFileRepository repository;

  setUp(() async {
    root = await Directory.systemTemp.createTemp("sesori-upload-test-");
    repository = UploadFileRepository(storage: UploadFileStorage(directoryPath: root.path));
  });
  tearDown(() async => await root.delete(recursive: true));

  test("writes distinct files whose contents and names remain accessible", () async {
    const body = [0, 1, 2, 255];
    final request = UploadFileRequest(name: "source code.txt", base64: base64Encode(body));
    final first = await repository.upload(request: request);
    final second = await repository.upload(request: request);
    expect(first, isNot(second));
    expect(await File(first).readAsBytes(), body);
    expect(first, endsWith("source code.txt"));
    if (!Platform.isWindows) {
      final mode = await Process.run("stat", Platform.isMacOS ? ["-f", "%Lp", first] : ["-c", "%a", first]);
      expect((mode.stdout as String).trim(), "600");
    }
  });

  test("rejects unsafe names and malformed base64 before writing", () async {
    for (final name in ["../outside", r"..\outside", "NUL.txt", "bad\nname", "trailing."]) {
      await expectLater(
        repository.upload(
          request: UploadFileRequest(name: name, base64: "YQ=="),
        ),
        throwsFormatException,
      );
    }
    await expectLater(
      repository.upload(
        request: const UploadFileRequest(name: "a", base64: "%%%"),
      ),
      throwsFormatException,
    );
    expect(root.listSync(), isEmpty);
  });
}
