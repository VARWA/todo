// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patch_all_tasks_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PatchAllTasksResponse _$PatchAllTasksResponseFromJson(
    Map<String, dynamic> json) {
  return _PatchAllTasksResponse.fromJson(json);
}

/// @nodoc
mixin _$PatchAllTasksResponse {
  List<GlobalTask> get list => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatchAllTasksResponseCopyWith<PatchAllTasksResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatchAllTasksResponseCopyWith<$Res> {
  factory $PatchAllTasksResponseCopyWith(PatchAllTasksResponse value,
          $Res Function(PatchAllTasksResponse) then) =
      _$PatchAllTasksResponseCopyWithImpl<$Res, PatchAllTasksResponse>;
  @useResult
  $Res call({List<GlobalTask> list});
}

/// @nodoc
class _$PatchAllTasksResponseCopyWithImpl<$Res,
        $Val extends PatchAllTasksResponse>
    implements $PatchAllTasksResponseCopyWith<$Res> {
  _$PatchAllTasksResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<GlobalTask>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PatchAllTasksResponseCopyWith<$Res>
    implements $PatchAllTasksResponseCopyWith<$Res> {
  factory _$$_PatchAllTasksResponseCopyWith(_$_PatchAllTasksResponse value,
          $Res Function(_$_PatchAllTasksResponse) then) =
      __$$_PatchAllTasksResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GlobalTask> list});
}

/// @nodoc
class __$$_PatchAllTasksResponseCopyWithImpl<$Res>
    extends _$PatchAllTasksResponseCopyWithImpl<$Res, _$_PatchAllTasksResponse>
    implements _$$_PatchAllTasksResponseCopyWith<$Res> {
  __$$_PatchAllTasksResponseCopyWithImpl(_$_PatchAllTasksResponse _value,
      $Res Function(_$_PatchAllTasksResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$_PatchAllTasksResponse(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<GlobalTask>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_PatchAllTasksResponse implements _PatchAllTasksResponse {
  _$_PatchAllTasksResponse(final List<GlobalTask> list) : _list = list;

  factory _$_PatchAllTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PatchAllTasksResponseFromJson(json);

  final List<GlobalTask> _list;
  @override
  List<GlobalTask> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'PatchAllTasksResponse(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PatchAllTasksResponse &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PatchAllTasksResponseCopyWith<_$_PatchAllTasksResponse> get copyWith =>
      __$$_PatchAllTasksResponseCopyWithImpl<_$_PatchAllTasksResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PatchAllTasksResponseToJson(
      this,
    );
  }
}

abstract class _PatchAllTasksResponse implements PatchAllTasksResponse {
  factory _PatchAllTasksResponse(final List<GlobalTask> list) =
      _$_PatchAllTasksResponse;

  factory _PatchAllTasksResponse.fromJson(Map<String, dynamic> json) =
      _$_PatchAllTasksResponse.fromJson;

  @override
  List<GlobalTask> get list;
  @override
  @JsonKey(ignore: true)
  _$$_PatchAllTasksResponseCopyWith<_$_PatchAllTasksResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
