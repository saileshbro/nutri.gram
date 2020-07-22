import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/bottom_banner.dart';
import 'package:nutrigram_app/common/ui/busy_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomBanner(
          onPressed: () {},
          bannerText: "Don't have an account?",
          buttonLabel: "Register",
        ),
        body: ViewModelBuilder<LoginViewModel>.reactive(
            builder: (BuildContext context, LoginViewModel model,
                    Widget child) =>
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    if (Navigator.canPop(context))
                      AppBar()
                    else
                      const SizedBox.shrink(),
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
                            key: model.formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  focusNode: phoneFocusNode,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  },
                                  validator: model.validatePhone,
                                  onChanged: (val) => model.phoneNo = val,
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
                                  focusNode: passwordFocusNode,
                                  validator: model.validatePassword,
                                  style: Theme.of(context).textTheme.caption,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  onChanged: (val) => model.password = val,
                                  obscureText: model.isPasswordVisible,
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
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap: model.changePasswordVisibility,
                                        child: Icon(
                                          model.isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0),
                                      child: Text(
                                        forgotPassword,
                                        style:
                                            Theme.of(context).textTheme.button,
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
                                  child: BusyButton(
                                      title: login, onPressed: model.doLogin),
                                ),
                                FlatButton(
                                  splashColor: Colors.transparent,
                                  onPressed: () {},
                                  child: Text(
                                    dontHaveAccount,
                                    style: Theme.of(context).textTheme.button,
                                  ),
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
            viewModelBuilder: () => locator<LoginViewModel>()));
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
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
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
