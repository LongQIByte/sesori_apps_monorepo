import "package:freezed_annotation/freezed_annotation.dart";

part "upload_file.freezed.dart";
part "upload_file.g.dart";

/// Maximum decoded size of a file uploaded through the relay.
const maxUploadedFileBytes = 50 * 1000 * 1000;

@Freezed(fromJson: true, toJson: true)
sealed class UploadFileRequest with _$UploadFileRequest {
  const factory UploadFileRequest({required String name, required String base64}) = _UploadFileRequest;

  factory UploadFileRequest.fromJson(Map<String, dynamic> json) => _$UploadFileRequestFromJson(json);
}

@Freezed(fromJson: true, toJson: true)
sealed class UploadFileResponse with _$UploadFileResponse {
  const factory UploadFileResponse({required String path}) = _UploadFileResponse;

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) => _$UploadFileResponseFromJson(json);
}
