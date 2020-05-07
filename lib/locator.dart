
import 'package:get_it/get_it.dart';
import 'package:homesweethome/CRUDModel.dart';


GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => CRUDModel()) ;
}