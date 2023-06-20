abstract class PriorityValue {
  static const String high = '!! Высокий';
  static const int highInInt = 2;

  static const String low = 'Низкий';
  static const int lowInInt = 1;

  static const String no = 'Нет';
  static const int noInInt = 0;



  static int convertFromStringToInt(String value) => switch (value) {
        low => lowInInt,
        no => noInInt,
        high => highInInt,
        _ => 0,
      };

  static String convertFromIntToString(int value) => switch (value) {
        lowInInt => low,
        noInInt => no,
        highInInt => high,
        _ => 'Нет',
      };
}
