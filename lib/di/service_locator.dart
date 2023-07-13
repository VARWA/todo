import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/src/logger.dart';
import 'package:todo/repository/data_client.dart';

import '../data/remote_data/dio_handler.dart';
import '../firebase/firebase_worker.dart';

GetIt locator = GetIt.instance;

void setUpGetIt() {
  locator.registerSingleton<MyLogger>(MyLogger());
  locator.registerSingleton<FirebaseWorker>(FirebaseWorker());
  locator.registerSingleton<DBHelper>(DBHelper());
  locator.registerLazySingleton<DioHelper>(() => DioHelper());
  locator.registerSingleton<DataClient>(DataClient());
}
