import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/extensions/string.dart';
import 'package:nutrigram_app/common/ui/components/custom_icon_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/history.dart';

class HistoryCard extends StatelessWidget {
  final History history;
  final VoidCallback onDeletePressed;
  final Function onPressed;
  const HistoryCard({
    Key key,
    @required this.history,
    this.onDeletePressed,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: mPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 8,
              color: kPrimaryColor.withOpacity(0.27),
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    history.foodName.allWordsCapitilize(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  mHeightSpan,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        history.createdAt,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        history.searchTerm,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            mWidthSpan,
            CustomIconButton(
              color: Colors.red,
              icon: Icons.delete_forever,
              onPressed: onDeletePressed,
              hasBoxShadow: false,
            ),
          ],
        ),
      ),
    );
  }
}
