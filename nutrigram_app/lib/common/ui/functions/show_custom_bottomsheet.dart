import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

void showCustomBottomSheet(
  BuildContext context, {
  Widget child,
  Function onDismiss,
  Color barColor = kDisabledDarkThemeColor,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 72,
                  height: 4,
                  decoration: BoxDecoration(
                      color: barColor, borderRadius: BorderRadius.circular(5)),
                ),
                lHeightSpan,
                child
              ],
            ),
          ),
        );
      }).then((_) {
    if (onDismiss != null) onDismiss();
  });
}
