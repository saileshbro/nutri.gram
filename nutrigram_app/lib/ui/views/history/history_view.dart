import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          llHeightSpan,
          Padding(
            padding: lXPadding,
            child: Column(
              children: const [
                CustomNavBar(
                  navBarItemTitle: "History",
                  blackString: "Go through your ",
                  blueString: "saved scans",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
