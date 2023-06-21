abstract class ImportanceValues {
  static const String high = '!! Высокий';
  static const String highGlobal = 'high';

  static const String low = 'Низкий';
  static const String lowGlobal = 'low';

  static const String basic = 'Нет';
  static const String basicGlobal = 'basic';



  static String convertFromLocalToGlobal(String value) => switch (value) {
        low => lowGlobal,
        basic => basicGlobal,
        high => highGlobal,
        _ => basicGlobal,
      };

  static String convertFromIntToString(String value) => switch (value) {
        lowGlobal => low,
        basicGlobal => basic,
        highGlobal => high,
        _ => low,
      };
}
