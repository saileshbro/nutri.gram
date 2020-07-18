import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/register/register_view.dart';
import 'package:nutrigram_app/ui/views/login/login_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  List<_OnboardingModel> onboardingItems = [
    _OnboardingModel(
      headLine: curious,
      baseLine: nutrientConcious,
      asset: onboardingAsset1,
    ),
    _OnboardingModel(
      headLine: scan,
      baseLine: whatToScan,
      asset: onboardingAsset2,
    ),
    _OnboardingModel(
      headLine: analyze,
      baseLine: analysis,
      asset: onboardingAsset3,
    ),
    _OnboardingModel(
      headLine: beHealthy,
      baseLine: healthNote,
      asset: onboardingAsset4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          lHeightSpan,
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: onboardingItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 41),
                  child: _OnboardingFront(
                    onboardingModel: onboardingItems[index],
                  ),
                );
              },
            ),
          ),
          llHeightSpan,
          SmoothPageIndicator(
            controller: _pageController,
            count: onboardingItems.length,
            effect: WormEffect(
              activeDotColor: kPrimaryColor,
              dotColor: kPrimaryColor,
              paintStyle: PaintingStyle.stroke,
              dotHeight: 10.0,
              dotWidth: 10.0,
              radius: 10.0,
              strokeWidth: 1.5,
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              boxShadow: getBoxShadow(
                context,
                kPrimaryColor,
              ),
            ),
            width: 112,
            child: FlatButton(
              color: kPrimaryColor,
              child: Icon(Entypo.arrow_long_right),
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => RegisterView()))
                    .then((onValue) {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.portraitUp,
                  ]);
                });
              },
            ),
          ),
          xlHeightSpan
        ],
      ),
    );
  }
}

class _OnboardingFront extends StatelessWidget {
  final _OnboardingModel onboardingModel;

  const _OnboardingFront({Key key, @required this.onboardingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            onboardingModel.asset,
            height: MediaQuery.of(context).size.width * 0.65,
          ),
          Column(
            children: <Widget>[
              xxlHeightSpan,
              Text(onboardingModel.headLine,
                  style: Theme.of(context).textTheme.headline4),
              lHeightSpan,
              Text(
                onboardingModel.baseLine,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _OnboardingModel {
  final String headLine;
  final String baseLine;
  final String asset;

  _OnboardingModel({
    @required this.headLine,
    @required this.baseLine,
    @required this.asset,
  });
}
