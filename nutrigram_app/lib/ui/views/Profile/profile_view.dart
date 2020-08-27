import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          CustomNavBar(
            navBarItemTitle: "Profile",
            blackString: "Update your ",
            blueString: "profile",
            isProfilePage: true,
            backNeeded: true,
          ),
          llHeightSpan,
          ProfileTop(
            imageUrl:
                "https://th.bing.com/th/id/OIP.t7coTbCbSZ8gixh06SwCOgHaE8?pid=Api&rs=1",
            phoneNumber: "9860934053",
            totalScans: '100',
            saved: '76',
            name: "Sarayu",
            totalCalories: '5000 kcal',
          ),
          lHeightSpan,
        ],
      ),
    );
  }
}

class ProfileTop extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String phoneNumber;
  final String totalScans;
  final String saved;
  final String totalCalories;

  const ProfileTop({
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  sHeightSpan,
                  Text(
                    "Total Scans",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kDisabledLightThemeColor,
                        ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    saved,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  sHeightSpan,
                  Text(
                    "Saved",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kDisabledLightThemeColor,
                        ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    totalCalories,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  sHeightSpan,
                  Text(
                    "Total Calories",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kDisabledLightThemeColor,
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
