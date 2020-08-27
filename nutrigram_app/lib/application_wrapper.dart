import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class ApplicationWrapper extends StatefulWidget {
  final List<Widget> pages;
  final List<BottomNavigationBarItem> navigationMenus;

  const ApplicationWrapper(
      {Key key, @required this.pages, @required this.navigationMenus})
      : assert(pages != null),
        assert(navigationMenus != null),
        assert(navigationMenus.length == pages.length),
        super(key: key);

  @override
  _ApplicationWrapperState createState() => _ApplicationWrapperState();
}

class _ApplicationWrapperState extends State<ApplicationWrapper> {
  PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: currentIndex,
    );
    super.initState();
  }

  void changeIndex(int i) {
    setState(() {
      currentIndex = i;
      controller.animateToPage(
        i,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(boxShadow: getBoxShadow(context, kPrimaryColor)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          currentIndex: currentIndex,
          onTap: changeIndex,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kDisabledLightThemeColor,
          unselectedLabelStyle:
              const TextStyle(color: kDisabledLightThemeColor),
          items: widget.navigationMenus,
        ),
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.pages,
      ),
    );
  }
}
