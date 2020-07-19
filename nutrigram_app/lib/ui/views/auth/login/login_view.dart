import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nutrigram_app/common/HelperWidget/bottom_banner.dart';
import 'package:nutrigram_app/common/HelperWidget/busy_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FocusNode phoneFocusNode;
  FocusNode passwordFocusNode;
  bool obscureText = true;

  TextEditingController _phoneNumberController, _passwordController;

  @override
  void initState() {
    phoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    _phoneNumberController = TextEditingController(text: "12345");
    _passwordController = TextEditingController(text: "user123");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomBanner(
        onPressed: () {},
        bannerText: "Don't have an account?",
        buttonLabel: "Register",
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Navigator.canPop(context) ? AppBar() : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Image.asset(
                    loginIllustration,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                sHeightSpan,
                Text(
                  welcome,
                  style: Theme.of(context).textTheme.headline4,
                ),
                sHeightSpan,
                Text(
                  afterLogin,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                lHeightSpan,
                Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.number,
                        focusNode: phoneFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        style: Theme.of(context).textTheme.caption,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .apply(color: kDisabledLightThemeColor),
                          prefixIcon: Icon(
                            Icons.phone_android,
                          ),
                          hintText: phoneNumber,
                        ),
                      ),
                      mHeightSpan,
                      TextFormField(
                        controller: _passwordController,
                        focusNode: passwordFocusNode,
                        style: Theme.of(context).textTheme.caption,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .apply(color: kDisabledLightThemeColor),
                          prefixIcon: Icon(
                            Icons.lock_open,
                          ),
                          suffixIcon: Material(
                            type: MaterialType.transparency,
                            shape: CircleBorder(),
                            child: InkWell(
                              customBorder: CircleBorder(),
                              child: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          hintText: password,
                        ),
                      ),
                      mHeightSpan,
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // showBottomSheet(
                            //   context,
                            //   child: ForgotPasswordBottomSheet(),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              forgotPassword,
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      ),
                      mHeightSpan,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: getBoxShadow(
                            context,
                            kPrimaryColor,
                          ),
                        ),
                        width: double.infinity,
                        child: BusyButton(title: login, onPressed: () {}),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          mHeightSpan,
        ],
      ),
    );
  }
}

class ChangePasswordBottomSheet extends StatefulWidget {
  final String phone;

  const ChangePasswordBottomSheet({Key key, @required this.phone})
      : super(key: key);

  @override
  _ChangePasswordBottomSheetState createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  TextEditingController phoneNumbercontroller,
      codeController,
      passwordController;
  FocusNode phoneNumberFocusNode, otpFocusNode, passwordFocusNode;
  bool obscureText = true;

  @override
  void initState() {
    phoneNumbercontroller = TextEditingController(
      text: widget.phone,
    );
    codeController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberFocusNode = FocusNode();
    otpFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            forgotPassword,
            style: Theme.of(context).textTheme.button,
          ),
          sHeightSpan,
          Text(
            forgotPasswordMsg,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          sHeightSpan,
          TextFormField(
            focusNode: phoneNumberFocusNode,
            controller: phoneNumbercontroller,
            keyboardType: TextInputType.number,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(otpFocusNode);
            },
            style: Theme.of(context).textTheme.caption,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: kDisabledLightThemeColor),
              prefixIcon: Icon(
                Icons.phone_android,
              ),
              hintText: phoneNumber,
            ),
          ),
          mHeightSpan,
          TextFormField(
            focusNode: otpFocusNode,
            controller: codeController,
            keyboardType: TextInputType.number,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            style: Theme.of(context).textTheme.caption,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: kDisabledLightThemeColor),
              prefixIcon: Icon(
                Feather.edit,
              ),
              hintText: otpCode,
            ),
          ),
          mHeightSpan,
          TextFormField(
            obscureText: obscureText,
            focusNode: passwordFocusNode,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            style: Theme.of(context).textTheme.caption,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: kDisabledLightThemeColor),
              prefixIcon: Icon(
                Icons.lock_open,
              ),
              hintText: newPassword,
              suffixIcon: Material(
                type: MaterialType.transparency,
                shape: CircleBorder(),
                child: InkWell(
                  customBorder: CircleBorder(),
                  child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
          ),
          mHeightSpan,
          BusyButton(
            title: changePassword,
            onPressed: () {},
          ),
          mHeightSpan,
        ],
      ),
    );
  }
}

class ForgotPasswordBottomSheet extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        children: <Widget>[
          Text(
            forgotPassword,
            style: Theme.of(context).textTheme.button,
          ),
          mHeightSpan,
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.caption,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.caption,
              prefixIcon: Icon(
                Icons.phone_android,
              ),
              hintText: phoneNumber,
            ),
          ),
          mHeightSpan,
          BusyButton(
            title: requestNewPassword,
            onPressed: () {},
          ),
          mHeightSpan,
        ],
      ),
    );
  }

  //change password
  // _changePassword(context) {
  //   return showBottomSheet(
  //     context,
  //     child: ChangePasswordBottomSheet(
  //       phone: _controller.text,
  //     ),
  //   );
  // }
}
