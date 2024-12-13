import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/custom_icon_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class CustomNavBar extends StatelessWidget {
  final String navBarItemTitle;
  final String blackString;
  final String blueString;
  final bool backNeeded;
  final bool isProfilePage;
  final bool isSecondary;
  final VoidCallback? onActionPressed;

  const CustomNavBar({
    required this.navBarItemTitle,
    required this.blackString,
    required this.blueString,
    this.isSecondary = false,
    this.backNeeded = false,
    this.isProfilePage = false,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (backNeeded)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  sWidthSpan,
                ],
              )
            else
              const SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  navBarItemTitle,
                  style: isSecondary
                      ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          )
                      : Theme.of(context).textTheme.headlineMedium,
                ),
                xxsHeightSpan,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: blackString,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: blueString,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isProfilePage)
          CustomIconButton(
            color: kPrimaryColor,
            gradientColor: Colors.blue,
            icon: Icons.exit_to_app,
            onPressed: onActionPressed ?? () {},
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
