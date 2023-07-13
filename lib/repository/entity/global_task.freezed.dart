// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GlobalTask _$GlobalTaskFromJson(Map<String, dynamic> json) {
  return _GlobalTask.fromJson(json);
}

/// @nodoc
mixin _$GlobalTask {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get importance => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
      toJson: DateTimeParser.fromDatetimeToUnixWithNull)
  DateTime? get deadline => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'created_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'changed_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  DateTime get changedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GlobalTaskCopyWith<GlobalTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalTaskCopyWith<$Res> {
  factory $GlobalTaskCopyWith(
          GlobalTask value, $Res Function(GlobalTask) then) =
      _$GlobalTaskCopyWithImpl<$Res, GlobalTask>;
  @useResult
  $Res call(
      {String id,
      String text,
      String importance,
      @JsonKey(
          fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
          toJson: DateTimeParser.fromDatetimeToUnixWithNull)
      DateTime? deadline,
      bool done,
      String? color,
      @JsonKey(
          name: 'created_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      DateTime createdAt,
      @JsonKey(
          name: 'changed_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      DateTime changedAt,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy});
}

/// @nodoc
class _$GlobalTaskCopyWithImpl<$Res, $Val extends GlobalTask>
    implements $GlobalTaskCopyWith<$Res> {
  _$GlobalTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? importance = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GlobalTaskCopyWith<$Res>
    implements $GlobalTaskCopyWith<$Res> {
  factory _$$_GlobalTaskCopyWith(
          _$_GlobalTask value, $Res Function(_$_GlobalTask) then) =
      __$$_GlobalTaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      String importance,
      @JsonKey(
          fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
          toJson: DateTimeParser.fromDatetimeToUnixWithNull)
      DateTime? deadline,
      bool done,
      String? color,
      @JsonKey(
          name: 'created_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      DateTime createdAt,
      @JsonKey(
          name: 'changed_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      DateTime changedAt,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy});
}

/// @nodoc
class __$$_GlobalTaskCopyWithImpl<$Res>
    extends _$GlobalTaskCopyWithImpl<$Res, _$_GlobalTask>
    implements _$$_GlobalTaskCopyWith<$Res> {
  __$$_GlobalTaskCopyWithImpl(
      _$_GlobalTask _value, $Res Function(_$_GlobalTask) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? importance = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_$_GlobalTask(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_GlobalTask implements _GlobalTask {
  const _$_GlobalTask(
      {required this.id,
      required this.text,
      required this.importance,
      @JsonKey(
          fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
          toJson: DateTimeParser.fromDatetimeToUnixWithNull)
      required this.deadline,
      required this.done,
      required this.color,
      @JsonKey(
          name: 'created_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      required this.createdAt,
      @JsonKey(
          name: 'changed_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      required this.changedAt,
      @JsonKey(name: 'last_updated_by') required this.lastUpdatedBy});

  factory _$_GlobalTask.fromJson(Map<String, dynamic> json) =>
      _$$_GlobalTaskFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String importance;
  @override
  @JsonKey(
      fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
      toJson: DateTimeParser.fromDatetimeToUnixWithNull)
  final DateTime? deadline;
  @override
  final bool done;
  @override
  final String? color;
  @override
  @JsonKey(
      name: 'created_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  final DateTime createdAt;
  @override
  @JsonKey(
      name: 'changed_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  final DateTime changedAt;
  @override
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  @override
  String toString() {
    return 'GlobalTask(id: $id, text: $text, importance: $importance, deadline: $deadline, done: $done, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GlobalTask &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, importance, deadline,
      done, color, createdAt, changedAt, lastUpdatedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GlobalTaskCopyWith<_$_GlobalTask> get copyWith =>
      __$$_GlobalTaskCopyWithImpl<_$_GlobalTask>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GlobalTaskToJson(
      this,
    );
  }
}

abstract class _GlobalTask implements GlobalTask {
  const factory _GlobalTask(
      {required final String id,
      required final String text,
      required final String importance,
      @JsonKey(
          fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
          toJson: DateTimeParser.fromDatetimeToUnixWithNull)
      required final DateTime? deadline,
      required final bool done,
      required final String? color,
      @JsonKey(
          name: 'created_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      required final DateTime createdAt,
      @JsonKey(
          name: 'changed_at',
          fromJson: DateTimeParser.fromUnixToDatetime,
          toJson: DateTimeParser.fromDatetimeToUnix)
      required final DateTime changedAt,
      @JsonKey(name: 'last_updated_by')
      required final String lastUpdatedBy}) = _$_GlobalTask;

  factory _GlobalTask.fromJson(Map<String, dynamic> json) =
      _$_GlobalTask.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get importance;
  @override
  @JsonKey(
      fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
      toJson: DateTimeParser.fromDatetimeToUnixWithNull)
  DateTime? get deadline;
  @override
  bool get done;
  @override
  String? get color;
  @override
  @JsonKey(
      name: 'created_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  DateTime get createdAt;
  @override
  @JsonKey(
      name: 'changed_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  DateTime get changedAt;
  @override
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy;
  @override
  @JsonKey(ignore: true)
  _$$_GlobalTaskCopyWith<_$_GlobalTask> get copyWith =>
      throw _privateConstructorUsedError;
}
