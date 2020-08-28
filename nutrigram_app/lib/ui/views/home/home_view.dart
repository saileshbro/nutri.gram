import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/custom_home_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class HomeView extends StatelessWidget {
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
                  navBarItemTitle: "Welcome",
                  blackString: "Be conscious about ",
                  blueString: "what you eat!",
                ),
                mHeightSpan,
                CustomHomeCard(),
              ],
            ),
          ),
          sHeightSpan,
          Container(
            width: double.infinity,
            color: kGapColor,
            height: 10,
          ),
          sHeightSpan,
          const Padding(
            padding: lXPadding,
            child: CustomNavBar(
              navBarItemTitle: "Health Tips",
              blackString: "We care about your ",
              blueString: "intake and health",
              isSecondary: true,
            ),
          ),
        ],
      ),
    );
  }
}
