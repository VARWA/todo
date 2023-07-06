import 'package:get_it/get_it.dart';
import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/repository/data_client.dart';

import '../data/remote_data/dio_handler.dart';

GetIt locator = GetIt.instance;

void setUpGetIt() {
  GetIt.instance.registerSingleton<DBHelper>(DBHelper());
  GetIt.instance.registerLazySingleton<DioHelper>(() => DioHelper());
  GetIt.instance.registerSingleton<DataClient>(DataClient());
}
