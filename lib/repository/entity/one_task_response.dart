import 'package:json_annotation/json_annotation.dart';
import 'package:todo/repository/entity/global_task.dart';

part 'one_task_response.g.dart';
@JsonSerializable()
class OneTaskResponse {
  @JsonKey(includeToJson: false)
  final String status;
  final GlobalTask element;
  @JsonKey(includeToJson: false)
  final int revision;

  OneTaskResponse({
    required this.status,
    required this.element,
    required this.revision,
  });
  factory OneTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$OneTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OneTaskResponseToJson(this);
}
