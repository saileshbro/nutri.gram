import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/custom_home_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          children: [
            const CustomNavBar(
              navBarItemTitle: "Welcome",
              blackString: "Be conscious about ",
              blueString: "what you eat!",
            ),
            lHeightSpan,
            const CustomHomeCard(),
          ],
        ),
      ),
    );
  }
}
