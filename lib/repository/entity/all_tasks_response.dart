import 'package:json_annotation/json_annotation.dart';
import 'package:todo/repository/entity/global_task.dart';

part 'all_tasks_response.g.dart';

@JsonSerializable()
class AllTasksResponse {
  @JsonKey(includeToJson: false)
  final String status;
  final List<GlobalTask> list;
  @JsonKey(includeToJson: false)
  final int revision;

  AllTasksResponse({
    required this.status,
    required this.list,
    required this.revision,
  });

  factory AllTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$AllTasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllTasksResponseToJson(this);
}
