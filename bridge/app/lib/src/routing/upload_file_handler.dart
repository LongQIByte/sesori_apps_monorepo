import "package:sesori_shared/sesori_shared.dart";

import "../repositories/upload_file_repository.dart";
import "request_handler.dart";

class UploadFileHandler({required final UploadFileRepository repository})
    extends BodyRequestHandler<UploadFileRequest, UploadFileResponse> {
  this : super(method: HttpMethod.post, path: "/file/upload", fromJson: UploadFileRequest.fromJson);

  @override
  Future<UploadFileResponse> handle({required RelayRequest request, required UploadFileRequest body}) async {
    try {
      return UploadFileResponse(path: await repository.upload(request: body));
    } on FormatException catch (error) {
      throw buildErrorResponse(request: request, status: 400, message: error.message);
    }
  }
}
