import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/custom_home_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
          Container(
            height: 270,
            padding: sPadding,
            child: Swiper(
              itemCount: 10,
              viewportFraction: 0.8,
              scale: 0.9,
              fade: 0.4,
              loop: false,
              itemBuilder: (_, __) => const HealthTipsCard(),
            ),
          ),
          // Spacer()
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
    return Container(
      margin: sPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(23, 138, 232, 0.27),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
