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
                const CustomNavBar(
                  navBarItemTitle: "Health Tips",
                  blackString: "We care about your ",
                  blueString: "intake and health",
                  isSecondary: true,
                ),
                lHeightSpan,
                Card(
                    margin: const EdgeInsets.all(10),
                    shadowColor: kPrimaryColor,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/illustrations/image 14.png",
                          height: 160,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                        sHeightSpan,
                        const Text(
                          "How drinking coffee can ruin your health",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                        sHeightSpan,
                        const Text(
                          "Read more",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        sHeightSpan,
                      ],
                    ))
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
