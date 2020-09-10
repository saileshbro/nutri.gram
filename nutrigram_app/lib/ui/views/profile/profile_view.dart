import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/components/list_button.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        key: const PageStorageKey("PROFILE-PAGE-STORAGE-KEY"),
        children: [
          llHeightSpan,
          Padding(
            padding: lXPadding,
            child: Column(
              children: <Widget>[
                const CustomNavBar(
                  navBarItemTitle: "Profile",
                  blackString: "Update your ",
                  blueString: "profile",
                  isProfilePage: true,
                ),
                llHeightSpan,
                const _ProfileTop(
                  imageUrl:
                      "https://th.bing.com/th/id/OIP.t7coTbCbSZ8gixh06SwCOgHaE8?pid=Api&rs=1",
                  phoneNumber: "9860934053",
                  totalScans: '100',
                  saved: '76',
                  name: "Sarayu",
                  totalCalories: '5000 kcal',
                ),
                lHeightSpan,
                ListButton(
                  icon: Icons.edit,
                  label: "Edit Profile",
                  onPressed: () => showCustomBottomSheet(
                    context,
                    child: _UpdateProfileForm(),
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
    );
  }
}

class _ProfileTop extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String phoneNumber;
  final String totalScans;
  final String saved;
  final String totalCalories;

  const _ProfileTop({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.phoneNumber,
    @required this.totalScans,
    @required this.saved,
    @required this.totalCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        imageUrl,
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
                        name,
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
                              text: phoneNumber,
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
            ],
          ),
          llHeightSpan,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    totalScans,
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
                    saved,
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
                    totalCalories,
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
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = useTextEditingController();
    final TextEditingController _phoneController = useTextEditingController();
    final TextEditingController _newPasswordController =
        useTextEditingController();
    final TextEditingController _confirmPasswordController =
        useTextEditingController();
    final FocusNode _nameFocusNode = useFocusNode();
    final FocusNode _phoneFocusNode = useFocusNode();
    final FocusNode _newPasswordFocusNode = useFocusNode();
    final FocusNode _confirmPasswordFocusNode = useFocusNode();
    return Container(
      alignment: Alignment.bottomCenter,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.65),
      padding: sXPagePadding.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              },
              textInputType: TextInputType.number,
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
              controller: _newPasswordController,
              textInputType: TextInputType.number,
              focusNode: _newPasswordFocusNode,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
              },
              prefixIcon: const Icon(
                Icons.vpn_key,
              ),
              hintText: "New password",
            ),
            mHeightSpan,
            DTextField(
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              textInputType: TextInputType.number,
              prefixIcon: const Icon(
                Icons.lock,
              ),
              hintText: "Confirm new password",
            ),
            mHeightSpan,
            DRaisedButton(
              title: "Update Profile",
              onPressed: () {},
              loading: false,
            ),
          ],
        ),
      ),
    );
  }
}
