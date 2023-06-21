// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// abstract class MyDateCounter {
//   static int timeNowInSeconds() {
//     return DateTime.now().millisecondsSinceEpoch ~/ 1000;
//   }
//
//   static int timeSecondsFromDateTime(DateTime dateTime) {
//     return dateTime.millisecondsSinceEpoch ~/ 1000;
//   }
//
//   static DateTime timeDateTimeFromSeconds(int seconds) {
//     return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
//   }
//
//   static String timeFromSecondsToReview(int seconds) {
//     return DateFormat('d MMMM yyyy').format(timeDateTimeFromSeconds(seconds));
//   }
//
//   static bool timeEqualDateCheck(int firstSeconds, int secondSeconds) {
//     return DateUtils.isSameDay(timeDateTimeFromSeconds(firstSeconds),
//         timeDateTimeFromSeconds(secondSeconds));
//   }
// }
