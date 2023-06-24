abstract class DateTimeParser {
  static int fromDatetimeToUnix(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch ~/ 1000;

  static int? fromDatetimeToUnixWithNull(DateTime? dateTime) =>
      dateTime != null ? dateTime.millisecondsSinceEpoch ~/ 1000 : null;

  static DateTime fromUnixToDatetime(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  static DateTime? fromUnixToDatetimeWithNull(int? seconds) => seconds != null
      ? DateTime.fromMillisecondsSinceEpoch(seconds * 1000)
      : null;
}
