import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/custom_home_card.dart';
import 'package:nutrigram_app/common/ui/components/health_tips_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/ui/views/home/home_viewmodel.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel model, Widget child) =>
          Scaffold(
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
              child: Shimmer(
                enabled: model.isBusy,
                color: kGapColor,
                duration: const Duration(seconds: 2),
                child: Swiper(
                  key: const PageStorageKey("HOME-PAGE-TIPS-STORAGE-KEY"),
                  itemCount: model.healthTipList.length,
                  index: model.healthTipList.isNotEmpty ? 1 : 0,
                  controller: SwiperController(),
                  viewportFraction: 0.8,
                  scale: 0.9,
                  fade: 0.4,
                  loop: false,
                  itemBuilder: (BuildContext context, int index) =>
                      HealthTipsCard(
                    healthTip: model.healthTipList[index],
                  ),
                ),
              ),
            ),
            // Spacer()
          ],
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
      onModelReady: (model) => model.init(),
      disposeViewModel: false,
    );
  }
}
