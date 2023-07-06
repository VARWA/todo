import 'package:json_annotation/json_annotation.dart';
import 'package:todo/repository/entity/parsers/datetime_parser.dart';

part 'global_task.g.dart';

@JsonSerializable()
class GlobalTask {
  final String id;
  final String text;
  final String importance;
  @JsonKey(
      fromJson: DateTimeParser.fromUnixToDatetimeWithNull,
      toJson: DateTimeParser.fromDatetimeToUnixWithNull)
  final DateTime? deadline;
  final bool done;
  final String? color;
  @JsonKey(
      name: 'created_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  final DateTime createdAt;
  @JsonKey(
      name: 'changed_at',
      fromJson: DateTimeParser.fromUnixToDatetime,
      toJson: DateTimeParser.fromDatetimeToUnix)
  final DateTime changedAt;
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  GlobalTask({
    required this.id,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
    required this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  factory GlobalTask.fromJson(Map<String, dynamic> json) =>
      _$GlobalTaskFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalTaskToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}