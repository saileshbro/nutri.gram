import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/bottom_banner.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, RegisterViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomBanner(
          onPressed: model.onLoginPressed,
          bannerText: alreadyHaveAnAccount,
          buttonLabel: login,
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
                    registerIllustration,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                mHeightSpan,
                Text(
                  register,
                  style: Theme.of(context).textTheme.headline4,
                ),
                lHeightSpan,
                Form(
                  key: model.formKey,
                  child: Column(
                    children: <Widget>[
                      DTextField(
                          textCapitalization: TextCapitalization.words,
                          focusNode: nameFocusNode,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(phoneFocusNode);
                          },
                          validator: model.validateName,
                          onChanged: (val) => model.name = val,
                          hintText: fullName,
                          prefixIcon: const Icon(
                            Icons.perm_identity,
                          ),
                          enabled: !model.isBusy),
                      mHeightSpan,
                      DTextField(
                        focusNode: phoneFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        validator: model.validatePhone,
                        onChanged: (val) => model.phoneNo = val,
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(
                          Icons.phone_android,
                        ),
                        enabled: !model.isBusy,
                        hintText: phoneNumber,
                      ),
                      mHeightSpan,
                      DTextField(
                        focusNode: passwordFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        onChanged: (val) => model.password = val,
                        validator: model.validatePassword,
                        enabled: !model.isBusy,
                        password: model.isPasswordVisible,
                        prefixIcon: const Icon(
                          Icons.lock_open,
                        ),
                        suffixIcon: Material(
                          type: MaterialType.transparency,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: model.changePasswordVisibility,
                            child: Icon(model.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        hintText: password,
                      ),
                      llHeightSpan,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: getBoxShadow(
                            context,
                            kPrimaryColor,
                          ),
                        ),
                        width: double.infinity,
                        child: DRaisedButton(
                          loading: model.isBusy,
                          title: register,
                          onPressed: () {
                            if (model.formKey.currentState.validate()) {
                              model.register();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mHeightSpan,
          ],
        ),
      ),
      viewModelBuilder: () => locator<RegisterViewModel>(),
      disposeViewModel: false,
    );
  }
}
