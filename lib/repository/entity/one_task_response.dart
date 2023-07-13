import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/repository/entity/global_task.dart';

part 'one_task_response.freezed.dart';

part 'one_task_response.g.dart';
@freezed
class OneTaskResponse with _$OneTaskResponse {
  @JsonSerializable(explicitToJson: true)

  const factory OneTaskResponse({
    @JsonKey(includeToJson: false)
    required String status,
    required GlobalTask element,
    @JsonKey(includeToJson: false)
    required int revision,
  }) = _OneTaskResponse;

  factory OneTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$OneTaskResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$OneTaskResponseToJson(this);
}
