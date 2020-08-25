import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/application_wrapper.dart';
import 'package:nutrigram_app/ui/views/Advice/advice_view.dart';
import 'package:nutrigram_app/ui/views/History/history_view.dart';
import 'package:nutrigram_app/ui/views/Profile/profile_view.dart';
import 'package:nutrigram_app/ui/views/Scan/scan_view.dart';
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
      navigationMenus: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: const Text(
            "Home",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
          ),
          title: const Text(
            "History",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.photo_camera,
          ),
          title: const Text(
            "Scan",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.fastfood,
          ),
          title: const Text(
            "Advice",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          title: const Text(
            "Profile",
          ),
        ),
      ],
    );
  }
}
