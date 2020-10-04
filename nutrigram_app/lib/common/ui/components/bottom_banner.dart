import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class BottomBanner extends StatelessWidget {
  final String bannerText;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool loading;
  BottomBanner({
    @required this.onPressed,
    this.backgroundColor = Colors.white,
    this.bannerText,
    this.buttonLabel,
    this.loading = false,
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
        children: <Widget>[
          if (loading)
            Container(
              height: 36,
              width: 36,
              padding: const EdgeInsets.all(8),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            )
          else ...[
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
          ]
        ],
      ),
    );
  }
}
