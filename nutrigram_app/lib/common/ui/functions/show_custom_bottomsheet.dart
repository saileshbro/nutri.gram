import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

void showCustomBottomSheet(
  BuildContext context, {
  required Widget child,
  VoidCallback? onDismiss,
  Color? barColor,
  bool isDismissible = true,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    builder: (BuildContext bc) => _buildBottomSheet(context, child, barColor),
  ).then((_) {
    if (onDismiss != null) onDismiss();
  });
}

Widget _buildBottomSheet(BuildContext context, Widget child, Color? barColor) {
  final double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: 16,
        bottom: bottomPadding > 0 ? bottomPadding : 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 72,
            height: 4,
            decoration: BoxDecoration(
              color: barColor ?? Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          lHeightSpan,
          child,
        ],
      ),
    ),
  );
}
