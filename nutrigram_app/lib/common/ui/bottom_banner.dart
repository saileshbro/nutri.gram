import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class BottomBanner extends StatelessWidget {
  final String bannerText;
  final String buttonLabel;
  final Function onPressed;
  final Color backgroundColor;

  BottomBanner({
    @required this.onPressed,
    this.backgroundColor = Colors.white,
    this.bannerText,
    this.buttonLabel,
  }) : assert(bannerText != null ||
            bannerText.isNotEmpty ||
            buttonLabel != null ||
            buttonLabel.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            bannerText,
            style: Theme.of(context).textTheme.button,
          ),
          RawMaterialButton(
            constraints: const BoxConstraints(),
            onPressed: onPressed,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: sPadding,
            child: Text(
              buttonLabel,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: kPrimaryColor),
            ),
          )
        ],
      ),
    );
  }
}
