import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/locator.config.dart';

final GetIt locator = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
)
Future<void> setupLocator() => $initGetIt(locator);
