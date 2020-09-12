import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/change_image.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/components/icon_button.dart';
import 'package:nutrigram_app/common/ui/components/list_button.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      builder: (BuildContext ctx, ProfileViewModel model, Widget child) =>
          MediaQuery.removePadding(
        removeTop: true,
        context: ctx,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          key: const PageStorageKey("PROFILE-PAGE-STORAGE-KEY"),
          children: [
            llHeightSpan,
            Padding(
              padding: lXPadding,
              child: Column(
                children: <Widget>[
                  CustomNavBar(
                    navBarItemTitle: "Profile",
                    blackString: "Update your ",
                    blueString: "profile",
                    isProfilePage: true,
                    onActionPressed: model.logout,
                  ),
                  llHeightSpan,
                  _ProfileTop(),
                  lHeightSpan,
                  ListButton(
                    icon: Icons.edit,
                    label: "Edit Profile",
                    onPressed: () => showCustomBottomSheet(
                      ctx,
                      child: _UpdateProfileForm(model),
                    ),
                  ),
                  mHeightSpan,
                  ListButton(
                    icon: Icons.history,
                    label: "See scan history",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            lHeightSpan,
            Container(
              width: double.infinity,
              color: kGapColor,
              height: 10,
            ),
            sHeightSpan,
            Padding(
              padding: lXPadding,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CustomNavBar(
                    navBarItemTitle: "Your intake till now",
                    blackString: "Visualize ",
                    blueString: "your intake",
                    isSecondary: true,
                  ),
                  lHeightSpan,
                  const Center(child: Text("Graph Here")),
                ],
              ),
            ),
            lHeightSpan,
          ],
        ),
      ),
    );
  }
}

class _ProfileTop extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: sXPadding,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: getBoxShadow(context, kPrimaryColor)),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        model.imageUrl,
                      ),
                      backgroundColor: kPrimaryColor,
                      maxRadius: 42.0,
                    ),
                  ),
                  lWidthSpan,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.namme,
                        style: Theme.of(context).textTheme.button,
                      ),
                      xsHeightSpan,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: phoneNum,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            TextSpan(
                              text: model.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kPrimaryColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              CustomIconButton(
                color: kPrimaryColor,
                gradientColor: Colors.blue,
                icon: Icons.add_photo_alternate,
                iconSize: 25,
                radius: 27,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ModifyImage()));
                },
              )
            ],
          ),
          llHeightSpan,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    model.totalScans,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    "Total Scans",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kPrimaryLightTextColor,
                        ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    model.totalSaved,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    "Saved",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kPrimaryLightTextColor,
                        ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    model.totalCalories,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    "Total Calories",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kPrimaryLightTextColor,
                        ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _UpdateProfileForm extends HookWidget {
  final ProfileViewModel model;
  const _UpdateProfileForm(this.model);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController =
        useTextEditingController(text: model.namme);
    final TextEditingController _phoneController =
        useTextEditingController(text: model.phone);
    final TextEditingController _newPasswordController =
        useTextEditingController();
    final TextEditingController _currentPasswordController =
        useTextEditingController();
    final TextEditingController _confirmPasswordController =
        useTextEditingController();
    final FocusNode _nameFocusNode = useFocusNode();
    final FocusNode _phoneFocusNode = useFocusNode();
    final FocusNode _newPasswordFocusNode = useFocusNode();
    final FocusNode _currentPasswordFocusNode = useFocusNode();
    final FocusNode _confirmPasswordFocusNode = useFocusNode();
    return Container(
      alignment: Alignment.bottomCenter,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      padding: sXPagePadding.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
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
                controller: _nameController,
                focusNode: _nameFocusNode,
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
                controller: _phoneController,
                textInputType: TextInputType.number,
                validator: model.validatePhone,
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
                controller: _currentPasswordController,
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
                controller: _newPasswordController,
                validator: (val) {
                  if (val.isEmpty) {
                    return null;
                  }
                  return model.validatePassword(val);
                },
                focusNode: _newPasswordFocusNode,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(_confirmPasswordFocusNode);
                },
                prefixIcon: const Icon(
                  Icons.vpn_key,
                ),
                password: true,
                hintText: "New password",
              ),
              mHeightSpan,
              DTextField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                validator: (String val) {
                  if (val != _newPasswordController.text) {
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
              DRaisedButton(
                title: "Update Profile",
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    final bool showVerificationBottomSheet =
                        await model.updateProfile(
                      currentPassword: _currentPasswordController.text,
                      name: _nameController.text,
                      password: _newPasswordController.text,
                      phone: _phoneController.text,
                    );
                    if (showVerificationBottomSheet) {
                      showCustomBottomSheet(context,
                          child: _VerifyPhoneChange(model));
                    }
                  }
                },
                loading: model.isBusy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerifyPhoneChange extends HookWidget {
  final ProfileViewModel model;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  const _VerifyPhoneChange(this.model);
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = useTextEditingController();
    return Padding(
      padding: sXPagePadding.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "OTP Code has been sent to your phone, use it and update your profile",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            mHeightSpan,
            DTextField(
              controller: _controller,
              textInputType: TextInputType.number,
              validator: model.validateOtp,
              prefixIcon: const Icon(
                Icons.phone_android,
              ),
              hintText: "OTP Code",
            ),
            mHeightSpan,
            DRaisedButton(
              title: "Apply Update",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  model.updatePhone(_controller.text);
                }
              },
              loading: model.isBusy,
            ),
          ],
        ),
      ),
    );
  }
}
