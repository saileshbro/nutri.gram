import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/icon_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class NavBarItemAppBar extends StatelessWidget {
  final String navBarItemTitle;
  final String blackString;
  final String blueString;
  final bool backNeeded;
  final bool isProfilePage;

  const NavBarItemAppBar({
    Key key,
    @required this.navBarItemTitle,
    @required this.blackString,
    @required this.blueString,
    this.backNeeded = false,
    this.isProfilePage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 24, top: MediaQuery.of(context).padding.top),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (backNeeded)
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          else
            const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              lHeightSpan,
              Text(
                navBarItemTitle,
                style: Theme.of(context).textTheme.headline4,
              ),
              sHeightSpan,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: blackString,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextSpan(
                      text: blueString,
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
          if (isProfilePage)
            CustomIconButton(
              color: Colors.amber,
              gradientColor: Colors.blue,
              icon: Icons.exit_to_app,
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
