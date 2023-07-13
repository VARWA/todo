// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_all_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PatchAllTasksResponse _$$_PatchAllTasksResponseFromJson(
        Map<String, dynamic> json) =>
    _$_PatchAllTasksResponse(
      (json['list'] as List<dynamic>)
          .map((e) => GlobalTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PatchAllTasksResponseToJson(
        _$_PatchAllTasksResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
