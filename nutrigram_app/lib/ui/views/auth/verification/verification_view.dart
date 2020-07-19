import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/HelperWidget/busy_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerificationView extends StatefulWidget {
  final String phoneNumber;

  const VerificationView({Key key, @required this.phoneNumber})
      : super(key: key);

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  String pinCodeValue = '';
  TextEditingController pinEditingController;

  @override
  void initState() {
    pinEditingController = TextEditingController(
      text: pinCodeValue,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          AppBar(
//            brightness: Brightness.light,
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Image.asset(
                    verificationIllustration,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
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
          // ViewModelProvider<VerificationViewModel>.withConsumer(
          //   viewModel: VerificationViewModel(),
          //   builder: (BuildContext context, VerificationViewModel model, _) {
          Form(
            child: Column(
              children: <Widget>[
                Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: PinInputTextField(
                      pinLength: 4,
                      onChanged: (String value) {
                        setState(() {
                          pinCodeValue = value;
                        });
                      },
                      decoration: UnderlineDecoration(
                        color: kPrimaryColor,
                        textStyle: Theme.of(context).textTheme.headline3,
                        hintText: "8888",
                        // hintTextStyle:
                        //     Theme.of(context).textTheme.headline3.copyWith(
                        //           color: ThemeData.isDarkTheme(context) != null
                        //               ? kDisabledDarkThemeColor
                        //               : kDisabledLightThemeColor,
                        //         ),
                      ),
                      controller: pinEditingController,
                      autoFocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmit: (pin) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        debugPrint('submit pin:$pin');
                      },
                    ),
                  ),
                ),
                llHeightSpan,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43.0),
                  child: BusyButton(
                    onPressed: () {},
                    // onPressed: () {
                    //   model.verify(
                    //     code: int.tryParse(pinCodeValue, radix: 10),
                    //     phoneNumber: widget.phoneNumber,
                    //   );
                    // },
                    // busy: model.busy,
                    title: verify,
                  ),
                ),
                sHeightSpan,
                // ViewModelProvider<ResendVerificationViewModel>.withConsumer(
                //   builder: (context, model, _) {
                //     return model.busy
                //         ? Container(
                //             height: 36,
                //             width: 36,
                //             padding: EdgeInsets.all(8),
                //             child: CircularProgressIndicator(
                //               strokeWidth: 2,
                //               valueColor:
                //                   AlwaysStoppedAnimation<Color>(kPrimaryColor),
                //             ),
                //           ) :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43.0),
                  child: FlatButton(
                    // onPressed: () {
                    //   model.resendVerify(phoneNumber: widget.phoneNumber);
                    // },
                    onPressed: () {},
                    splashColor: Colors.transparent,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: didntReceive,
                            style: Theme.of(context).textTheme.button,
                          ),
                          TextSpan(
                            text: resend,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //         );
                  // },
                  // viewModel: ResendVerificationViewModel(),
                ),
              ],
            ),
          )
//            UiHelper.verticalSpace(16),
        ],
      ),
    );
  }
}
