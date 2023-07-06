import 'package:json_annotation/json_annotation.dart';
import 'package:todo/repository/entity/global_task.dart';

part 'get_all_tasks_response.g.dart';

@JsonSerializable(createToJson: false)
class GetAllTasksResponse {
  final String status;
  final List<GlobalTask> list;
  final int revision;

  GetAllTasksResponse({
    required this.status,
    required this.list,
    required this.revision,
  });

  factory GetAllTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllTasksResponseFromJson(json);

  //Map<String, dynamic> toJson() => _$GetAllTasksResponseToJson(this);
}
