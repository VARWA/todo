// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GlobalTask _$$_GlobalTaskFromJson(Map<String, dynamic> json) =>
    _$_GlobalTask(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      deadline:
          DateTimeParser.fromUnixToDatetimeWithNull(json['deadline'] as int?),
      done: json['done'] as bool,
      color: json['color'] as String?,
      createdAt: DateTimeParser.fromUnixToDatetime(json['created_at'] as int),
      changedAt: DateTimeParser.fromUnixToDatetime(json['changed_at'] as int),
      lastUpdatedBy: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$$_GlobalTaskToJson(_$_GlobalTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': instance.importance,
      'deadline': DateTimeParser.fromDatetimeToUnixWithNull(instance.deadline),
      'done': instance.done,
      'color': instance.color,
      'created_at': DateTimeParser.fromDatetimeToUnix(instance.createdAt),
      'changed_at': DateTimeParser.fromDatetimeToUnix(instance.changedAt),
      'last_updated_by': instance.lastUpdatedBy,
    };
