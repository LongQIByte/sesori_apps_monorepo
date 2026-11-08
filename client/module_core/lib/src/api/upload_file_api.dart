import "package:injectable/injectable.dart";
import "package:sesori_auth/sesori_auth.dart";
import "package:sesori_shared/sesori_shared.dart";

import "client/relay_http_client.dart";

@lazySingleton
class UploadFileApi({required final RelayHttpApiClient client}) {
  Future<ApiResponse<UploadFileResponse>> upload({required String body}) => client.postWithTimeout(
    "/file/upload",
    fromJson: UploadFileResponse.fromJson,
    body: body,
    timeout: const Duration(minutes: 2),
  );
}
