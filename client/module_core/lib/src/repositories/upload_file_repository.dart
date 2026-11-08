import "package:injectable/injectable.dart";
import "package:sesori_auth/sesori_auth.dart";

import "../api/upload_file_api.dart";

@lazySingleton
class UploadFileRepository({required final UploadFileApi api}) {
  Future<String> upload({required String body}) async {
    return switch (await api.upload(body: body)) {
      SuccessResponse(:final data) => data.path,
      ErrorResponse(:final error) => throw StateError("File upload failed: ${error.toString()}"),
    };
  }
}
