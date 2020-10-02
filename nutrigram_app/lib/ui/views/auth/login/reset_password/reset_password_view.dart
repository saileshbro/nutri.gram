import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/auth/login/reset_password/reset_password_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends HookWidget {
  final String phone;

  const ResetPasswordView(this.phone);
  @override
  Widget build(BuildContext context) {
    final phoneNumbercontroller = useTextEditingController(
      text: phone,
    );
    final codeController = useTextEditingController();
    final passwordController = useTextEditingController();
    final phoneNumberFocusNode = useFocusNode();
    final otpFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => locator<ResetPasswordViewModel>(),
      builder: (
        BuildContext context,
        ResetPasswordViewModel model,
        Widget child,
      ) {
        return Padding(
          padding: sXPagePadding.add(EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom)),
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
                validator: model.validatePhone,
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
                  prefixIcon: const Icon(
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
                validator: model.validateOtp,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                style: Theme.of(context).textTheme.caption,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context)
                      .textTheme
                      .caption
                      .apply(color: kDisabledLightThemeColor),
                  prefixIcon: const Icon(
                    Feather.edit,
                  ),
                  hintText: otpCode,
                ),
              ),
              mHeightSpan,
              TextFormField(
                obscureText: model.isPasswordHidden,
                focusNode: passwordFocusNode,
                controller: passwordController,
                validator: model.validatePassword,
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
                  prefixIcon: const Icon(
                    Icons.lock_open,
                  ),
                  hintText: newPassword,
                  suffixIcon: Material(
                    type: MaterialType.transparency,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: model.hidePassword,
                      child: Icon(model.isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              mHeightSpan,
              DRaisedButton(
                title: changePassword,
                onPressed: () => model.changePassword(
                  phone,
                  passwordController.text,
                  codeController.text,
                ),
                loading: model.isBusy,
              ),
              mHeightSpan,
            ],
          ),
        );
      },
    );
  }
}
