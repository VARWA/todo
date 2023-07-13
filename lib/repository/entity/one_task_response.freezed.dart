// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'one_task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OneTaskResponse _$OneTaskResponseFromJson(Map<String, dynamic> json) {
  return _OneTaskResponse.fromJson(json);
}

/// @nodoc
mixin _$OneTaskResponse {
  @JsonKey(includeToJson: false)
  String get status => throw _privateConstructorUsedError;
  GlobalTask get element => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OneTaskResponseCopyWith<OneTaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OneTaskResponseCopyWith<$Res> {
  factory $OneTaskResponseCopyWith(
          OneTaskResponse value, $Res Function(OneTaskResponse) then) =
      _$OneTaskResponseCopyWithImpl<$Res, OneTaskResponse>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String status,
      GlobalTask element,
      @JsonKey(includeToJson: false) int revision});

  $GlobalTaskCopyWith<$Res> get element;
}

/// @nodoc
class _$OneTaskResponseCopyWithImpl<$Res, $Val extends OneTaskResponse>
    implements $OneTaskResponseCopyWith<$Res> {
  _$OneTaskResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? element = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      element: null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as GlobalTask,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GlobalTaskCopyWith<$Res> get element {
    return $GlobalTaskCopyWith<$Res>(_value.element, (value) {
      return _then(_value.copyWith(element: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OneTaskResponseCopyWith<$Res>
    implements $OneTaskResponseCopyWith<$Res> {
  factory _$$_OneTaskResponseCopyWith(
          _$_OneTaskResponse value, $Res Function(_$_OneTaskResponse) then) =
      __$$_OneTaskResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String status,
      GlobalTask element,
      @JsonKey(includeToJson: false) int revision});

  @override
  $GlobalTaskCopyWith<$Res> get element;
}

/// @nodoc
class __$$_OneTaskResponseCopyWithImpl<$Res>
    extends _$OneTaskResponseCopyWithImpl<$Res, _$_OneTaskResponse>
    implements _$$_OneTaskResponseCopyWith<$Res> {
  __$$_OneTaskResponseCopyWithImpl(
      _$_OneTaskResponse _value, $Res Function(_$_OneTaskResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? element = null,
    Object? revision = null,
  }) {
    return _then(_$_OneTaskResponse(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      element: null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as GlobalTask,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OneTaskResponse implements _OneTaskResponse {
  const _$_OneTaskResponse(
      {@JsonKey(includeToJson: false) required this.status,
      required this.element,
      @JsonKey(includeToJson: false) required this.revision});

  factory _$_OneTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$$_OneTaskResponseFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String status;
  @override
  final GlobalTask element;
  @override
  @JsonKey(includeToJson: false)
  final int revision;

  @override
  String toString() {
    return 'OneTaskResponse(status: $status, element: $element, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OneTaskResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.element, element) || other.element == element) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, element, revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OneTaskResponseCopyWith<_$_OneTaskResponse> get copyWith =>
      __$$_OneTaskResponseCopyWithImpl<_$_OneTaskResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OneTaskResponseToJson(
      this,
    );
  }
}

abstract class _OneTaskResponse implements OneTaskResponse {
  const factory _OneTaskResponse(
          {@JsonKey(includeToJson: false) required final String status,
          required final GlobalTask element,
          @JsonKey(includeToJson: false) required final int revision}) =
      _$_OneTaskResponse;

  factory _OneTaskResponse.fromJson(Map<String, dynamic> json) =
      _$_OneTaskResponse.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get status;
  @override
  GlobalTask get element;
  @override
  @JsonKey(includeToJson: false)
  int get revision;
  @override
  @JsonKey(ignore: true)
  _$$_OneTaskResponseCopyWith<_$_OneTaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
