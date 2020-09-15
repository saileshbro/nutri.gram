// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_view.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_view.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_view.dart';
import 'package:nutrigram_app/ui/views/dashboard/dashbord_view.dart';
import 'package:nutrigram_app/ui/views/onboarding/onboarding_view.dart';
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_view.dart';
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_view.dart';
import 'package:nutrigram_app/ui/views/startup/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String onboardingView = '/onboarding-view';
  static const String verificationView = '/verification-view';
  static const String changeImageView = '/change-image-view';
  static const String scanPreviewView = '/scan-preview-view';
  static const String dashboardView = '/dashboard-view';
  static const all = <String>{
    startUpView,
    loginView,
    registerView,
    onboardingView,
    verificationView,
    changeImageView,
    scanPreviewView,
    dashboardView,
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
    RouteDef(Routes.verificationView, page: VerificationView),
    RouteDef(Routes.changeImageView, page: ChangeImageView),
    RouteDef(Routes.scanPreviewView, page: ScanPreviewView),
    RouteDef(Routes.dashboardView, page: DashboardView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    OnboardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnboardingView(),
        settings: data,
      );
    },
    VerificationView: (data) {
      final args = data.getArgs<VerificationViewArguments>(
        orElse: () => VerificationViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerificationView(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
        settings: data,
      );
    },
    ChangeImageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangeImageView(),
        settings: data,
      );
    },
    ScanPreviewView: (data) {
      final args = data.getArgs<ScanPreviewViewArguments>(
        orElse: () => ScanPreviewViewArguments(),
      );
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ScanPreviewView(
          key: args.key,
          image: args.image,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    DashboardView: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DashboardView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// VerificationView arguments holder class
class VerificationViewArguments {
  final Key key;
  final String phoneNumber;
  VerificationViewArguments({this.key, this.phoneNumber});
}

/// ScanPreviewView arguments holder class
class ScanPreviewViewArguments {
  final Key key;
  final File image;
  ScanPreviewViewArguments({this.key, this.image});
}
