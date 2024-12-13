import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/locator.config.dart';
import 'package:stacked_services/stacked_services.dart'; // Add this import

final GetIt locator = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
)
Future<void> setupLocator() async {
  locator.init();
  locator.registerLazySingleton(
    () => NavigationService(),
  ); // Register NavigationService
}
