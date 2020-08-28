import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/custom_home_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.51,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: kGapColor,
              height: 10,
            ),
          )
        ],
      ),
    );
  }
}
