// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadFileRequest {

 String get name; String get base64;
/// Create a copy of UploadFileRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadFileRequestCopyWith<UploadFileRequest> get copyWith => _$UploadFileRequestCopyWithImpl<UploadFileRequest>(this as UploadFileRequest, _$identity);

  /// Serializes this UploadFileRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UploadFileRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadFileRequest&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.base64, _this.base64) || other.base64 == _this.base64));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UploadFileRequest;
  return Object.hash(runtimeType,_this.name,_this.base64);
}

@override
String toString() {
  final _this = this as UploadFileRequest;
  return 'UploadFileRequest(name: ${_this.name}, base64: ${_this.base64})';
}


}

/// @nodoc
abstract mixin class $UploadFileRequestCopyWith<$Res>  {
  factory $UploadFileRequestCopyWith(UploadFileRequest value, $Res Function(UploadFileRequest) _then) = _$UploadFileRequestCopyWithImpl;
@useResult
$Res call({
 String name, String base64
});




}
/// @nodoc
class _$UploadFileRequestCopyWithImpl<$Res>
    implements $UploadFileRequestCopyWith<$Res> {
  _$UploadFileRequestCopyWithImpl(this._self, this._then);

  final UploadFileRequest _self;
  final $Res Function(UploadFileRequest) _then;

/// Create a copy of UploadFileRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? base64 = null,}) {
  return _then(UploadFileRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,base64: null == base64 ? _self.base64 : base64 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _UploadFileRequest implements UploadFileRequest {
  const _UploadFileRequest({required this.name, required this.base64});
  factory _UploadFileRequest.fromJson(Map<String, dynamic> json) => _$UploadFileRequestFromJson(json);

@override final  String name;
@override final  String base64;

/// Create a copy of UploadFileRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadFileRequestCopyWith<_UploadFileRequest> get copyWith => __$UploadFileRequestCopyWithImpl<_UploadFileRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadFileRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadFileRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.base64, base64) || other.base64 == base64));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,base64);
}

@override
String toString() {
    return 'UploadFileRequest(name: $name, base64: $base64)';
}


}

/// @nodoc
abstract mixin class _$UploadFileRequestCopyWith<$Res> implements $UploadFileRequestCopyWith<$Res> {
  factory _$UploadFileRequestCopyWith(_UploadFileRequest value, $Res Function(_UploadFileRequest) _then) = __$UploadFileRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String base64
});




}
/// @nodoc
class __$UploadFileRequestCopyWithImpl<$Res>
    implements _$UploadFileRequestCopyWith<$Res> {
  __$UploadFileRequestCopyWithImpl(this._self, this._then);

  final _UploadFileRequest _self;
  final $Res Function(_UploadFileRequest) _then;

/// Create a copy of UploadFileRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? base64 = null,}) {
  return _then(_UploadFileRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,base64: null == base64 ? _self.base64 : base64 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UploadFileResponse {

 String get path;
/// Create a copy of UploadFileResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadFileResponseCopyWith<UploadFileResponse> get copyWith => _$UploadFileResponseCopyWithImpl<UploadFileResponse>(this as UploadFileResponse, _$identity);

  /// Serializes this UploadFileResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UploadFileResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadFileResponse&&(identical(other.path, _this.path) || other.path == _this.path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UploadFileResponse;
  return Object.hash(runtimeType,_this.path);
}

@override
String toString() {
  final _this = this as UploadFileResponse;
  return 'UploadFileResponse(path: ${_this.path})';
}


}

/// @nodoc
abstract mixin class $UploadFileResponseCopyWith<$Res>  {
  factory $UploadFileResponseCopyWith(UploadFileResponse value, $Res Function(UploadFileResponse) _then) = _$UploadFileResponseCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$UploadFileResponseCopyWithImpl<$Res>
    implements $UploadFileResponseCopyWith<$Res> {
  _$UploadFileResponseCopyWithImpl(this._self, this._then);

  final UploadFileResponse _self;
  final $Res Function(UploadFileResponse) _then;

/// Create a copy of UploadFileResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,}) {
  return _then(UploadFileResponse(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _UploadFileResponse implements UploadFileResponse {
  const _UploadFileResponse({required this.path});
  factory _UploadFileResponse.fromJson(Map<String, dynamic> json) => _$UploadFileResponseFromJson(json);

@override final  String path;

/// Create a copy of UploadFileResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadFileResponseCopyWith<_UploadFileResponse> get copyWith => __$UploadFileResponseCopyWithImpl<_UploadFileResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadFileResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadFileResponse&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,path);
}

@override
String toString() {
    return 'UploadFileResponse(path: $path)';
}


}

/// @nodoc
abstract mixin class _$UploadFileResponseCopyWith<$Res> implements $UploadFileResponseCopyWith<$Res> {
  factory _$UploadFileResponseCopyWith(_UploadFileResponse value, $Res Function(_UploadFileResponse) _then) = __$UploadFileResponseCopyWithImpl;
@override @useResult
$Res call({
 String path
});




}
/// @nodoc
class __$UploadFileResponseCopyWithImpl<$Res>
    implements _$UploadFileResponseCopyWith<$Res> {
  __$UploadFileResponseCopyWithImpl(this._self, this._then);

  final _UploadFileResponse _self;
  final $Res Function(_UploadFileResponse) _then;

/// Create a copy of UploadFileResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(_UploadFileResponse(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
