import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/ui/views/profile/update_profile_form/update_profile_form_viewmodel.dart';
import 'package:nutrigram_app/ui/views/profile/verify_phone_change/verify_phone_change_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class UpdateProfileFormView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProfileFormViewModel>.reactive(
        builder: (BuildContext context, UpdateProfileFormViewModel model,
                Widget child) =>
            Container(
              alignment: Alignment.bottomCenter,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.75),
              padding: sXPagePadding.add(EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _UpdateProfileForm(formKey),
                    DRaisedButton(
                      title: "Update Profile",
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          final bool showVerificationBottomSheet =
                              await model.updateProfile();
                          if (showVerificationBottomSheet) {
                            showCustomBottomSheet(context,
                                child: VerifyPhoneChangeView());
                          }
                        }
                      },
                      loading: model.isBusy,
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => locator<UpdateProfileFormViewModel>());
  }
}

class _UpdateProfileForm
    extends HookViewModelWidget<UpdateProfileFormViewModel> {
  final GlobalKey<FormState> formKey;
  const _UpdateProfileForm(this.formKey) : super(reactive: true);
  @override
  Widget buildViewModelWidget(
      BuildContext context, UpdateProfileFormViewModel model) {
    final FocusNode _nameFocusNode = useFocusNode();
    final FocusNode _phoneFocusNode = useFocusNode();
    final TextEditingController _nameTextEditingController =
        useTextEditingController(text: model.name);
    final TextEditingController _phoneTextEditingController =
        useTextEditingController(text: model.phone);
    final FocusNode _newPasswordFocusNode = useFocusNode();
    final FocusNode _currentPasswordFocusNode = useFocusNode();
    final FocusNode _confirmPasswordFocusNode = useFocusNode();
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Update Profile",
            style: Theme.of(context).textTheme.button,
          ),
          sHeightSpan,
          Text(
            "OTP Code will be sent to you. after you update your phone number.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          mHeightSpan,
          DTextField(
            onChanged: model.onNameChanged,
            focusNode: _nameFocusNode,
            controller: _nameTextEditingController,
            validator: model.validateName,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_phoneFocusNode);
            },
            prefixIcon: const Icon(
              Icons.sentiment_very_satisfied,
            ),
            hintText: "Change name",
            label: "Change name",
          ),
          mHeightSpan,
          DTextField(
            onChanged: model.onPhoneChanged,
            textInputType: TextInputType.number,
            validator: model.validatePhone,
            controller: _phoneTextEditingController,
            focusNode: _phoneFocusNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            prefixIcon: const Icon(
              Icons.phone_android,
            ),
            hintText: "New phone number",
            label: "New phone number",
          ),
          llHeightSpan,
          Text(
            "Fill these fields to change your password.",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.caption,
          ),
          mHeightSpan,
          DTextField(
            onChanged: model.onCurrentPasswordChanged,
            validator: (val) {
              if (val.isEmpty) {
                return null;
              }
              return model.validatePassword(val);
            },
            focusNode: _currentPasswordFocusNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_newPasswordFocusNode);
            },
            prefixIcon: const Icon(
              Icons.vpn_key,
            ),
            password: true,
            hintText: "Current password",
          ),
          mHeightSpan,
          DTextField(
            onChanged: model.onNewPasswordChanged,
            validator: (val) {
              if (val.isEmpty) {
                return null;
              }
              return model.validatePassword(val);
            },
            focusNode: _newPasswordFocusNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
            },
            prefixIcon: const Icon(
              Icons.vpn_key,
            ),
            password: true,
            hintText: "New password",
          ),
          mHeightSpan,
          DTextField(
            focusNode: _confirmPasswordFocusNode,
            validator: (String val) {
              if (val != model.newPassword) {
                return "Confirm password didn't match!";
              }
              return null;
            },
            password: true,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            prefixIcon: const Icon(
              Icons.lock,
            ),
            hintText: "Confirm new password",
          ),
          mHeightSpan,
        ],
      ),
    );
  }
}
