// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneTaskResponse _$OneTaskResponseFromJson(Map<String, dynamic> json) =>
    OneTaskResponse(
      status: json['status'] as String,
      element: GlobalTask.fromJson(json['element'] as Map<String, dynamic>),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$OneTaskResponseToJson(OneTaskResponse instance) =>
    <String, dynamic>{
      'element': instance.element,
    };
