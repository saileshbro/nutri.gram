import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/bottom_banner.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_viewmodel.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:stacked/stacked.dart';

class VerificationView extends StatelessWidget {
  final String phoneNumber;

  const VerificationView({Key key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (VerificationViewModel model) =>
            model.phoneNumber = phoneNumber,
        builder: (BuildContext context, VerificationViewModel model,
                Widget child) =>
            Scaffold(
              appBar: AppBar(),
              bottomNavigationBar: BottomBanner(
                onPressed: model.resendCode,
                bannerText: didntReceive,
                buttonLabel: resend,
                loading:
                    model.busy(VerificationViewModel.resendVerificationBusy),
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                padding: sXPagePadding,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: mXPagePadding,
                        child: Image.asset(
                          verificationIllustration,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                  mHeightSpan,
                  Text(
                    verification,
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  mHeightSpan,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75.0),
                    child: Text(
                      enterTheVerification,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  lHeightSpan,
                  Form(
                    child: Column(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: PinInputTextField(
                              pinLength: 4,
                              onChanged: (String value) => model.otp = value,
                              decoration: UnderlineDecoration(
                                colorBuilder:
                                    const FixedColorBuilder(kPrimaryColor),
                                textStyle:
                                    Theme.of(context).textTheme.headline3,
                                hintText: "0000",
                              ),
                              keyboardType: TextInputType.number,
                              enabled: !model
                                  .busy(VerificationViewModel.verifyingBusy),
                            ),
                          ),
                        ),
                        xlHeightSpan,
                        DRaisedButton(
                          onPressed: model.verify,
                          loading:
                              model.busy(VerificationViewModel.verifyingBusy),
                          title: verify,
                        ),
                        mHeightSpan,
                      ],
                    ),
                  )
                ],
              ),
            ),
        disposeViewModel: false,
        viewModelBuilder: () => locator<VerificationViewModel>());
  }
}
