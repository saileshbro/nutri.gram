import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (StartUpViewModel model) => model.handleStartupViewLogic(),
      builder: (BuildContext context, StartUpViewModel model, Widget child) =>
          const Scaffold(
        body: Center(
          child: Text("Splash Screen Here"),
        ),
      ),
      viewModelBuilder: () => locator<StartUpViewModel>(),
    );
  }
}
