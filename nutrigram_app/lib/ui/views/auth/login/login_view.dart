import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/bottom_banner.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_viewmodel.dart';
import 'package:nutrigram_app/ui/views/auth/login/otp_request/otp_request_view.dart';
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
                              prefixIcon: const Icon(
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
                              prefixIcon: const Icon(
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
                                      child: OtpRequestView());
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
        disposeViewModel: false,
        viewModelBuilder: () => locator<LoginViewModel>());
  }
}
