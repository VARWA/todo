// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_tasks_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetAllTasksResponse _$GetAllTasksResponseFromJson(Map<String, dynamic> json) {
  return _GetAllTasksResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllTasksResponse {
  String get status => throw _privateConstructorUsedError;
  List<GlobalTask> get list => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetAllTasksResponseCopyWith<GetAllTasksResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllTasksResponseCopyWith<$Res> {
  factory $GetAllTasksResponseCopyWith(
          GetAllTasksResponse value, $Res Function(GetAllTasksResponse) then) =
      _$GetAllTasksResponseCopyWithImpl<$Res, GetAllTasksResponse>;
  @useResult
  $Res call({String status, List<GlobalTask> list, int revision});
}

/// @nodoc
class _$GetAllTasksResponseCopyWithImpl<$Res, $Val extends GetAllTasksResponse>
    implements $GetAllTasksResponseCopyWith<$Res> {
  _$GetAllTasksResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<GlobalTask>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetAllTasksResponseCopyWith<$Res>
    implements $GetAllTasksResponseCopyWith<$Res> {
  factory _$$_GetAllTasksResponseCopyWith(_$_GetAllTasksResponse value,
          $Res Function(_$_GetAllTasksResponse) then) =
      __$$_GetAllTasksResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, List<GlobalTask> list, int revision});
}

/// @nodoc
class __$$_GetAllTasksResponseCopyWithImpl<$Res>
    extends _$GetAllTasksResponseCopyWithImpl<$Res, _$_GetAllTasksResponse>
    implements _$$_GetAllTasksResponseCopyWith<$Res> {
  __$$_GetAllTasksResponseCopyWithImpl(_$_GetAllTasksResponse _value,
      $Res Function(_$_GetAllTasksResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_$_GetAllTasksResponse(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<GlobalTask>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GetAllTasksResponse implements _GetAllTasksResponse {
  const _$_GetAllTasksResponse(
      {required this.status,
      required final List<GlobalTask> list,
      required this.revision})
      : _list = list;

  factory _$_GetAllTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetAllTasksResponseFromJson(json);

  @override
  final String status;
  final List<GlobalTask> _list;
  @override
  List<GlobalTask> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final int revision;

  @override
  String toString() {
    return 'GetAllTasksResponse(status: $status, list: $list, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetAllTasksResponse &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_list), revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetAllTasksResponseCopyWith<_$_GetAllTasksResponse> get copyWith =>
      __$$_GetAllTasksResponseCopyWithImpl<_$_GetAllTasksResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetAllTasksResponseToJson(
      this,
    );
  }
}

abstract class _GetAllTasksResponse implements GetAllTasksResponse {
  const factory _GetAllTasksResponse(
      {required final String status,
      required final List<GlobalTask> list,
      required final int revision}) = _$_GetAllTasksResponse;

  factory _GetAllTasksResponse.fromJson(Map<String, dynamic> json) =
      _$_GetAllTasksResponse.fromJson;

  @override
  String get status;
  @override
  List<GlobalTask> get list;
  @override
  int get revision;
  @override
  @JsonKey(ignore: true)
  _$$_GetAllTasksResponseCopyWith<_$_GetAllTasksResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
