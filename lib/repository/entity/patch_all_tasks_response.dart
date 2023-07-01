import 'package:json_annotation/json_annotation.dart';

import 'global_task.dart';

part 'patch_all_tasks_response.g.dart';

@JsonSerializable()
class PatchAllTasksResponse {
  final String status = 'ok';
  final List<GlobalTask> list;

  PatchAllTasksResponse(this.list);

  Map<String, dynamic> toJson() => _$PatchAllTasksResponseToJson(this);
}
