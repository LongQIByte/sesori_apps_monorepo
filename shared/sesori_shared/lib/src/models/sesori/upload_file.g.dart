// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadFileRequest _$UploadFileRequestFromJson(Map json) => _UploadFileRequest(
  name: json['name'] as String,
  base64: json['base64'] as String,
);

Map<String, dynamic> _$UploadFileRequestToJson(_UploadFileRequest instance) =>
    <String, dynamic>{'name': instance.name, 'base64': instance.base64};

_UploadFileResponse _$UploadFileResponseFromJson(Map json) =>
    _UploadFileResponse(path: json['path'] as String);

Map<String, dynamic> _$UploadFileResponseToJson(_UploadFileResponse instance) =>
    <String, dynamic>{'path': instance.path};
