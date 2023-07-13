// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetAllTasksResponse _$$_GetAllTasksResponseFromJson(
        Map<String, dynamic> json) =>
    _$_GetAllTasksResponse(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => GlobalTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$$_GetAllTasksResponseToJson(
        _$_GetAllTasksResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list.map((e) => e.toJson()).toList(),
      'revision': instance.revision,
    };
