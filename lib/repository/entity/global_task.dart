import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/repository/entity/parsers/datetime_parser.dart';

part 'global_task.freezed.dart';

part 'global_task.g.dart';

@freezed
class GlobalTask with _$GlobalTask {
  @JsonSerializable()
  const factory GlobalTask({
    required String id,
    required String text,
    required String importance,
    @JsonKey(
        fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
        toJson: DateTimeParser.fromDatetimeToUnixWithNull)
    required DateTime? deadline,
    required bool done,
    required String? color,
    @JsonKey(
        name: 'created_at',
        fromJson: DateTimeParser.fromUnixToDatetime,
        toJson: DateTimeParser.fromDatetimeToUnix)
    required DateTime createdAt,
    @JsonKey(
        name: 'changed_at',
        fromJson: DateTimeParser.fromUnixToDatetime,
        toJson: DateTimeParser.fromDatetimeToUnix)
    required DateTime changedAt,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
  }) = _GlobalTask;

  factory GlobalTask.fromJson(Map<String, dynamic> json) =>
      _$GlobalTaskFromJson(json);
}
