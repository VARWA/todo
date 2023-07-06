// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:todo/di/service_locator.dart';
// import 'package:todo/repository/data_client.dart';
// import 'package:todo/repository/entity/get_all_tasks_response.dart';
//
// import 'data/json_serializable_test.dart';
// import 'result/formatted_data.dart';
//
// void main() {
//   loadDependencies() async {
//     await dotenv.load(fileName: ".env");
//     setUpGetIt();
//   }
//
//   loadDependencies();
//   group(
//       'Let\' test the app',
//   ()
//   {
//     test('Test converter to Task from Json', () async {
//       var dioAnswer = GetAllTasksResponse.fromJson(jsonData);
//       final DataClient dataClient = DataClient();
//       List formattedData =
//           dataClient.getFormattedTasksFromDioAnswer(dioAnswer: dioAnswer);
// var trueResult = resultData;
//       expect(trueResult == formattedData, );
//     },
//     );
//   }
