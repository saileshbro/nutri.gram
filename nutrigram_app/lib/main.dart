import 'package:flutter/material.dart' hide Router;
import 'package:logger/logger.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/theme/theme.dart';

import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.verbose;
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: kLightTheme,
      initialRoute: Routes.startUpView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
