import 'package:get_it/get_it.dart';
import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/repository/data_client.dart';
import 'package:todo/src/logger.dart';

import '../data/remote_data/server_handler.dart';
import '../firebase/firebase_worker.dart';
import '../src/flavor_mode.dart';

GetIt locator = GetIt.instance;

void setUpDI() {
  locator.registerSingleton<MyLogger>(MyLogger());
  locator.registerSingleton<FirebaseWorker>(FirebaseWorker());
  locator.registerSingleton<DBHandler>(DBHandler());
  locator.registerLazySingleton<ServerHandler>(() => ServerHandler());
  locator.registerSingleton<DataClient>(DataClient());
  locator.registerSingleton<FlavorMode>(FlavorMode());
}
