import 'package:get_it/get_it.dart';
import 'package:trashsmart/core/services/schedule.service.dart';
import 'package:trashsmart/core/services/products.service.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<ScheduleService>(() => new ScheduleService());
  locator.registerLazySingleton<ProductService>(() => new ProductService());
}
