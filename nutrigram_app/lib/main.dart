import 'package:flutter/material.dart';
<<<<<<< HEAD
import '';

void main() {
=======
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
>>>>>>> frontend
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Flutter Demo',
=======
      title: appName,
>>>>>>> frontend
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
<<<<<<< HEAD
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF000000),
                  Color(0xFF000000),
                  Color(0xFF000000),
                ]),
            image: DecorationImage(
                image: AssetImage('assets/images/onboard1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(1), BlendMode.hue)),
          ),
        ),
        Positioned(
          top: 100,
          child: Image.asset(
            'assets/images/nutri-onboard1.png',
          ),
        ),
        SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 250,
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: Colors.red,
                  child: new Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red),
                  ),
                  color: Colors.white,
                  child: new Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    ));
=======
      initialRoute: Routes.startUpView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
>>>>>>> frontend
  }
}
