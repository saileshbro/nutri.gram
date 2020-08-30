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
          sHeightSpan,
          const HealthTipsCard()
        ],
      ),
    );
  }
}

class HealthTipsCard extends StatelessWidget {
  const HealthTipsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shadowColor: kPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/illustrations/image 14.png",
            height: 160,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
          sHeightSpan,
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "How drinking coffee can ruin your health",
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                sHeightSpan,
                Text(
                  "Read more",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          sHeightSpan,
        ],
      ),
    );
  }
}
