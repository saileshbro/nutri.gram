// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i13;

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:nutrigram_app/datamodels/nutrient.dart' as _i12;
import 'package:nutrigram_app/ui/views/auth/login/login_view.dart' as _i3;
import 'package:nutrigram_app/ui/views/auth/register/register_view.dart' as _i6;
import 'package:nutrigram_app/ui/views/auth/verification/verification_view.dart'
    as _i9;
import 'package:nutrigram_app/ui/views/dashboard/dashboard_view.dart' as _i2;
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_view.dart'
    as _i4;
import 'package:nutrigram_app/ui/views/onboarding/onboarding_view.dart' as _i5;
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_view.dart'
    as _i1;
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_view.dart'
    as _i7;
import 'package:nutrigram_app/ui/views/startup/startup_view.dart' as _i8;

/// generated route for
/// [_i1.ChangeImageView]
class ChangeImageView extends _i10.PageRouteInfo<void> {
  const ChangeImageView({List<_i10.PageRouteInfo>? children})
      : super(
          ChangeImageView.name,
          initialChildren: children,
        );

  static const String name = 'ChangeImageView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i1.ChangeImageView();
    },
  );
}

/// generated route for
/// [_i2.DashboardView]
class DashboardView extends _i10.PageRouteInfo<void> {
  const DashboardView({List<_i10.PageRouteInfo>? children})
      : super(
          DashboardView.name,
          initialChildren: children,
        );

  static const String name = 'DashboardView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i2.DashboardView();
    },
  );
}

/// generated route for
/// [_i3.LoginView]
class LoginView extends _i10.PageRouteInfo<void> {
  const LoginView({List<_i10.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i3.LoginView();
    },
  );
}

/// generated route for
/// [_i4.NutrientInfoDisplayView]
class NutrientInfoDisplayView
    extends _i10.PageRouteInfo<NutrientInfoDisplayViewArgs> {
  NutrientInfoDisplayView({
    _i11.Key key,
    List<_i12.Nutrient> nutrients,
    String name = "Package Name",
    String date,
    String searchTerm,
    bool showSaveButton,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          NutrientInfoDisplayView.name,
          args: NutrientInfoDisplayViewArgs(
            key: key,
            nutrients: nutrients,
            name: name,
            date: date,
            searchTerm: searchTerm,
            showSaveButton: showSaveButton,
          ),
          initialChildren: children,
        );

  static const String name = 'NutrientInfoDisplayView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NutrientInfoDisplayViewArgs>(
          orElse: () => const NutrientInfoDisplayViewArgs());
      return _i4.NutrientInfoDisplayView(
        key: args.key,
        nutrients: args.nutrients,
        name: args.name,
        date: args.date,
        searchTerm: args.searchTerm,
        showSaveButton: args.showSaveButton,
      );
    },
  );
}

class NutrientInfoDisplayViewArgs {
  const NutrientInfoDisplayViewArgs({
    this.key,
    this.nutrients,
    this.name = "Package Name",
    this.date,
    this.searchTerm,
    this.showSaveButton,
  });

  final _i11.Key key;

  final List<_i12.Nutrient> nutrients;

  final String name;

  final String date;

  final String searchTerm;

  final bool showSaveButton;

  @override
  String toString() {
    return 'NutrientInfoDisplayViewArgs{key: $key, nutrients: $nutrients, name: $name, date: $date, searchTerm: $searchTerm, showSaveButton: $showSaveButton}';
  }
}

/// generated route for
/// [_i5.OnboardingView]
class OnboardingView extends _i10.PageRouteInfo<void> {
  const OnboardingView({List<_i10.PageRouteInfo>? children})
      : super(
          OnboardingView.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i5.OnboardingView();
    },
  );
}

/// generated route for
/// [_i6.RegisterView]
class RegisterView extends _i10.PageRouteInfo<void> {
  const RegisterView({List<_i10.PageRouteInfo>? children})
      : super(
          RegisterView.name,
          initialChildren: children,
        );

  static const String name = 'RegisterView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i6.RegisterView();
    },
  );
}

/// generated route for
/// [_i7.ScanPreviewView]
class ScanPreviewView extends _i10.PageRouteInfo<ScanPreviewViewArgs> {
  ScanPreviewView({
    _i11.Key key,
    _i13.File image,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ScanPreviewView.name,
          args: ScanPreviewViewArgs(
            key: key,
            image: image,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanPreviewView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScanPreviewViewArgs>(
          orElse: () => const ScanPreviewViewArgs());
      return _i7.ScanPreviewView(
        key: args.key,
        image: args.image,
      );
    },
  );
}

class ScanPreviewViewArgs {
  const ScanPreviewViewArgs({
    this.key,
    this.image,
  });

  final _i11.Key key;

  final _i13.File image;

  @override
  String toString() {
    return 'ScanPreviewViewArgs{key: $key, image: $image}';
  }
}

/// generated route for
/// [_i8.StartUpView]
class StartUpView extends _i10.PageRouteInfo<void> {
  const StartUpView({List<_i10.PageRouteInfo>? children})
      : super(
          StartUpView.name,
          initialChildren: children,
        );

  static const String name = 'StartUpView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i8.StartUpView();
    },
  );
}

/// generated route for
/// [_i9.VerificationView]
class VerificationView extends _i10.PageRouteInfo<VerificationViewArgs> {
  VerificationView({
    _i11.Key key,
    String phoneNumber,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          VerificationView.name,
          args: VerificationViewArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'VerificationView';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificationViewArgs>(
          orElse: () => const VerificationViewArgs());
      return _i9.VerificationView(
        key: args.key,
        phoneNumber: args.phoneNumber,
      );
    },
  );
}

class VerificationViewArgs {
  const VerificationViewArgs({
    this.key,
    this.phoneNumber,
  });

  final _i11.Key key;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerificationViewArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}
