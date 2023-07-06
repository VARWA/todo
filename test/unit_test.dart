import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/data/remote_data/dio_handler.dart';
import 'package:todo/di/service_locator.dart';


void main() {
  group(
    'Let\' test the app',
    () {
      test(
        'Test data',
        () async {
          await dotenv.load(fileName: ".env");
          DioHelper dioHelper = locator<DioHelper>();
          dioHelper.getTasksList();

          }

      );
    },
  );
}
