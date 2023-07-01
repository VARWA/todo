// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllTasksResponse _$GetAllTasksResponseFromJson(Map<String, dynamic> json) =>
    GetAllTasksResponse(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => GlobalTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );
