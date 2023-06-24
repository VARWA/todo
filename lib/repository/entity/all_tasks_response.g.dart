// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTasksResponse _$AllTasksResponseFromJson(Map<String, dynamic> json) =>
    AllTasksResponse(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => GlobalTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$AllTasksResponseToJson(AllTasksResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
