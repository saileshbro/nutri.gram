import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/icon_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class CustomNavBar extends StatelessWidget {
  final String navBarItemTitle;
  final String blackString;
  final String blueString;
  final bool backNeeded;
  final bool isProfilePage;
  final bool isSecondary;

  const CustomNavBar({
    Key key,
    @required this.navBarItemTitle,
    @required this.blackString,
    @required this.blueString,
    this.isSecondary = false,
    this.backNeeded = false,
    this.isProfilePage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 2,
        top: MediaQuery.of(context).padding.top + 10,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (backNeeded)
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              else
                const SizedBox(),
              sWidthSpan,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    navBarItemTitle,
                    style: isSecondary
                        ? Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w500,
                            )
                        : Theme.of(context).textTheme.headline4,
                  ),
                  xxsHeightSpan,
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
            ],
          ),
          if (isProfilePage)
            const CustomIconButton(
              color: kPrimaryColor,
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
