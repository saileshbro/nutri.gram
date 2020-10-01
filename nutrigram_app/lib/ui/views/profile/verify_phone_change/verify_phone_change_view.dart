import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/ui/views/profile/verify_phone_change/verify_phone_change_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class VerifyPhoneChangeView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyPhoneViewModel>.reactive(
      viewModelBuilder: () => locator<VerifyPhoneViewModel>(),
      builder: (
        BuildContext context,
        VerifyPhoneViewModel model,
        Widget child,
      ) {
        return Padding(
          padding: sXPagePadding.add(EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom)),
          child: Column(
            children: [
              _VerifyPhoneChangeForm(formKey),
              DRaisedButton(
                title: "Apply Update",
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    model.updatePhone();
                  }
                },
                loading: model.isBusy,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _VerifyPhoneChangeForm extends HookViewModelWidget<VerifyPhoneViewModel> {
  final GlobalKey<FormState> formKey;

  const _VerifyPhoneChangeForm(this.formKey);

  @override
  Widget buildViewModelWidget(
      BuildContext context, VerifyPhoneViewModel model) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Text(
            "OTP Code has been sent to your phone, use it and update your profile",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          mHeightSpan,
          DTextField(
            textInputType: TextInputType.number,
            validator: model.validateOtp,
            onChanged: model.onOtpChanged,
            prefixIcon: const Icon(
              Icons.phone_android,
            ),
            hintText: "OTP Code",
          ),
          mHeightSpan,
        ],
      ),
    );
  }
}
