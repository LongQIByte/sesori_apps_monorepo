import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";
import "package:saf_stream/saf_stream_platform_interface.dart";
import "package:saf_util/saf_util_platform_interface.dart";
import "package:sesori_app_ui/sesori_app_ui.dart";
import "package:sesori_shared/sesori_shared.dart";

class _SafPicker() extends SafUtilPlatform {
  @override
  Future<List<SafDocumentFile>?> pickFiles({String? initialUri, List<String>? mimeTypes, bool multiple = true}) async =>
      [
        SafDocumentFile(uri: "content://test/source", name: "source.py", isDir: false, length: 3, lastModified: 0),
      ];
}

class _SafReader({required final bool oversized}) extends SafStreamPlatform {
  String? readUri;
  bool closed = false;
  bool sent = false;
  @override
  Future<String> startReadCustomFileStream(String uri, {int? bufferSize}) async {
    readUri = uri;
    return "session";
  }

  @override
  Future<Uint8List?> readCustomFileStreamChunk(String session) async {
    if (sent) return null;
    sent = true;
    return oversized ? Uint8List(maxUploadedFileBytes + 1) : Uint8List.fromList([1, 2, 3]);
  }

  @override
  Future<void> endReadCustomFileStream(String session) async {
    closed = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test("Android keeps the original name and reads the selected URI lazily", () async {
    final oldPicker = SafUtilPlatform.instance;
    final oldReader = SafStreamPlatform.instance;
    final reader = _SafReader(oversized: false);
    SafUtilPlatform.instance = _SafPicker();
    SafStreamPlatform.instance = reader;
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    addTearDown(() {
      SafUtilPlatform.instance = oldPicker;
      SafStreamPlatform.instance = oldReader;
      debugDefaultTargetPlatformOverride = null;
    });
    final files = await const FlutterComposerFilePicker().pickFiles();
    expect(files.single.name, "source.py");
    expect(await files.single.length(), 3);
    expect(reader.readUri, isNull);
    expect(await files.single.readBytes(), [1, 2, 3]);
    expect(reader.readUri, "content://test/source");
    expect(reader.closed, isTrue);
  });

  test("Android closes an oversized stream without keeping its bytes", () async {
    final oldPicker = SafUtilPlatform.instance;
    final oldReader = SafStreamPlatform.instance;
    final reader = _SafReader(oversized: true);
    SafUtilPlatform.instance = _SafPicker();
    SafStreamPlatform.instance = reader;
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    addTearDown(() {
      SafUtilPlatform.instance = oldPicker;
      SafStreamPlatform.instance = oldReader;
      debugDefaultTargetPlatformOverride = null;
    });
    final files = await const FlutterComposerFilePicker().pickFiles();
    await expectLater(files.single.readBytes(), throwsFormatException);
    expect(reader.closed, isTrue);
  });
}
