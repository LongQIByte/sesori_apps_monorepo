import "dart:convert";
import "dart:io";

import "package:sesori_bridge/src/api/upload_file_storage.dart";
import "package:sesori_bridge/src/repositories/upload_file_repository.dart";
import "package:sesori_bridge/src/routing/upload_file_handler.dart";
import "package:sesori_shared/sesori_shared.dart";
import "package:test/test.dart";

import "routing_test_helpers.dart";

void main() {
  test("JSON upload returns a path to the exact bytes on the bridge", () async {
    final root = await Directory.systemTemp.createTemp("sesori-upload-route-");
    addTearDown(() async => await root.delete(recursive: true));
    final handler = UploadFileHandler(
      repository: UploadFileRepository(storage: UploadFileStorage(directoryPath: root.path)),
    );
    final request = makeRequest(
      "POST",
      "/file/upload",
      body: jsonEncode(const UploadFileRequest(name: "test.py", base64: "cHJpbnQoMSk=")),
    );
    final response = await handler.routeForTest(request);
    expect(response.status, 200);
    final result = UploadFileResponse.fromJson(jsonDecode(response.body ?? "") as Map<String, dynamic>);
    expect(await File(result.path).readAsString(), "print(1)");
    final badRequest = makeRequest(
      "POST",
      "/file/upload",
      body: jsonEncode(const UploadFileRequest(name: "../escape", base64: "YQ==")),
    );
    expect((await handler.routeForTest(badRequest)).status, 400);
  });
}
