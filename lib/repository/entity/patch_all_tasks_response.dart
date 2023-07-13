import 'package:freezed_annotation/freezed_annotation.dart';

import 'global_task.dart';

part 'patch_all_tasks_response.freezed.dart';

part 'patch_all_tasks_response.g.dart';

@freezed
class PatchAllTasksResponse with _$PatchAllTasksResponse {
  @JsonSerializable()
  factory PatchAllTasksResponse(List<GlobalTask> list) = _PatchAllTasksResponse;

  factory PatchAllTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$PatchAllTasksResponseFromJson(json);
}
