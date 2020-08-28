import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';

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
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 240,
                color: homeCardColor,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Save Scan"),
                          sHeightSpan,
                          const Text("Visualize Intake"),
                          sHeightSpan,
                          DRaisedButton(
                            title: scan,
                            loading: false,
                            isSmall: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        homeIllustrationRight,
                        height: 200,
                        width: 200,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
