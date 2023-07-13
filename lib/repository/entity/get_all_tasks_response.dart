import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/repository/entity/global_task.dart';

part 'get_all_tasks_response.freezed.dart';

part 'get_all_tasks_response.g.dart';

@freezed
class GetAllTasksResponse with _$GetAllTasksResponse {
  @JsonSerializable(explicitToJson: true)
  const factory GetAllTasksResponse({
    required String status,
    required List<GlobalTask> list,
    required int revision,
  }) = _GetAllTasksResponse;

  factory GetAllTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllTasksResponseFromJson(json);
}
