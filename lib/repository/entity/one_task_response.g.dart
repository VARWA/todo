// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OneTaskResponse _$$_OneTaskResponseFromJson(Map<String, dynamic> json) =>
    _$_OneTaskResponse(
      status: json['status'] as String,
      element: GlobalTask.fromJson(json['element'] as Map<String, dynamic>),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$$_OneTaskResponseToJson(_$_OneTaskResponse instance) =>
    <String, dynamic>{
      'element': instance.element.toJson(),
    };
