// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_all_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchAllTasksResponse _$PatchAllTasksResponseFromJson(
        Map<String, dynamic> json) =>
    PatchAllTasksResponse(
      (json['list'] as List<dynamic>)
          .map((e) => GlobalTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatchAllTasksResponseToJson(
        PatchAllTasksResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
