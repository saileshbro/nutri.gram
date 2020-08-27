import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
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
    );
  }
}
