import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/bottom_banner.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
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
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (BuildContext context, LoginViewModel model, Widget child) =>
            Scaffold(
              appBar: AppBar(),
              bottomNavigationBar: BottomBanner(
                onPressed: model.goToRegister,
                bannerText: dontHaveAccount,
                buttonLabel: register,
              ),
              body: ListView(
                padding: sXPagePadding,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: mXPagePadding,
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
                            DTextField(
                              textInputType: TextInputType.number,
                              focusNode: phoneFocusNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                              validator: model.validatePhone,
                              onChanged: (val) => model.phoneNo = val,
                              prefixIcon: Icon(
                                Icons.phone_android,
                              ),
                              enabled: !model.isBusy,
                              hintText: phoneNumber,
                            ),
                            mHeightSpan,
                            DTextField(
                              focusNode: passwordFocusNode,
                              validator: model.validatePassword,
                              password: model.isPasswordVisible,
                              enabled: !model.isBusy,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              onChanged: (val) => model.password = val,
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
                              prefixIcon: Icon(
                                Icons.lock_open,
                              ),
                              hintText: password,
                            ),
                            mHeightSpan,
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  showCustomBottomSheet(context,
                                      child: GetOTPBottomSheet());
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
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
                              child: DRaisedButton(
                                  title: login,
                                  loading: model.isBusy,
                                  onPressed: () {
                                    if (model.formKey.currentState.validate()) {
                                      model.login();
                                    }
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  mHeightSpan,
                ],
              ),
            ),
        viewModelBuilder: () => locator<LoginViewModel>());
  }
}

class ResetPasswordBottomSheet extends StatefulWidget {
  final String phone;

  const ResetPasswordBottomSheet({Key key, @required this.phone})
      : super(key: key);

  @override
  _ResetPasswordBottomSheetState createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
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
      padding: sXPagePadding.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
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
          DRaisedButton(
            title: changePassword,
            onPressed: () {},
            loading: false,
          ),
          mHeightSpan,
        ],
      ),
    );
  }
}

class GetOTPBottomSheet extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sXPagePadding.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        children: <Widget>[
          Text(
            forgotPassword,
            style: Theme.of(context).textTheme.button,
          ),
          mHeightSpan,
          DTextField(
            controller: _controller,
            textInputType: TextInputType.number,
            prefixIcon: Icon(
              Icons.phone_android,
            ),
            hintText: phoneNumber,
          ),
          mHeightSpan,
          DRaisedButton(
            title: requestNewPassword,
            onPressed: () {},
            loading: false,
          ),
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
