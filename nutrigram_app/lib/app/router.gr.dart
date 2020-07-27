// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nutrigram_app/ui/views/startup/startup_view.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_view.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_view.dart';
import 'package:nutrigram_app/ui/views/onboarding/onboarding_view.dart';
import 'package:nutrigram_app/ui/views/home/home_view.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String onboardingView = '/onboarding-view';
  static const String homeView = '/home-view';
  static const String verificationView = '/verification-view';
  static const all = <String>{
    startUpView,
    loginView,
    registerView,
    onboardingView,
    homeView,
    verificationView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.verificationView, page: VerificationView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartUpView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    LoginView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegisterView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    OnboardingView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnboardingView(),
        settings: data,
      );
    },
    HomeView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    VerificationView: (RouteData data) {
      var args = data.getArgs<VerificationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            VerificationView(key: args.key, phoneNumber: args.phoneNumber),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//VerificationView arguments holder class
class VerificationViewArguments {
  final Key key;
  final String phoneNumber;
  VerificationViewArguments({this.key, @required this.phoneNumber});
}
