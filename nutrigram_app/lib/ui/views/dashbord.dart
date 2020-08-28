import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/application_wrapper.dart';
import 'package:nutrigram_app/ui/views/advice/advice_view.dart';
import 'package:nutrigram_app/ui/views/history/history_view.dart';
import 'package:nutrigram_app/ui/views/profile/profile_view.dart';
import 'package:nutrigram_app/ui/views/scan/scan_view.dart';
import 'package:nutrigram_app/ui/views/home/home_view.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ApplicationWrapper(
      pages: <Widget>[
        HomeView(),
        HistoryView(),
        ScanView(),
        AdviceView(),
        ProfileView(),
      ],
      navigationMenus: const [
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
    );
  }
}
