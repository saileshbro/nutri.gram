import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/ui/views/advice/advice_view.dart';
import 'package:nutrigram_app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:nutrigram_app/ui/views/history/history_view.dart';
import 'package:nutrigram_app/ui/views/home/home_view.dart';
import 'package:nutrigram_app/ui/views/profile/profile_view.dart';
import 'package:nutrigram_app/ui/views/scan/scan_view.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, DashboardViewModel model, Widget child) =>
          Scaffold(
        bottomNavigationBar: Container(
          decoration:
              BoxDecoration(boxShadow: getBoxShadow(context, kPrimaryColor)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kDisabledLightThemeColor,
            unselectedLabelStyle:
                const TextStyle(color: kDisabledLightThemeColor),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text(
                  "Home",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                title: Text(
                  "History",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo_camera,
                ),
                title: Text(
                  "Scan",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.fastfood,
                ),
                title: Text(
                  "Advice",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text(
                  "Profile",
                ),
              ),
            ],
          ),
        ),
        body: PageTransitionSwitcher(
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: getViewForIndex(model),
        ),
      ),
      viewModelBuilder: () => locator<DashboardViewModel>(),
    );
  }

  Widget getViewForIndex(DashboardViewModel model) {
    switch (model.currentIndex) {
      case 0:
        return HomeView(
          goToScanPage: () => model.setIndex(2),
        );
      case 1:
        return HistoryView();
      case 2:
        return ScanView();
      case 3:
        return AdviceView();
      case 4:
        return ProfileView();
      default:
        return HomeView(
          goToScanPage: () => model.setIndex(2),
        );
    }
  }
}
