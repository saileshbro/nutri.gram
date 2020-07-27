import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class DRaisedButton extends StatelessWidget {
  final bool loading;
  final String title;
  final Function onPressed;

  const DRaisedButton({
    @required this.title,
    @required this.loading,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPressed,
      child: InkWell(
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: getBoxShadow(context, kPrimaryColor)),
          child: !loading
              ? Text(
                  title,
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: kScaffoldBackgroundColor,
                      ),
                )
              : Container(
                  height: 36,
                  width: 36,
                  padding: const EdgeInsets.all(8),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}
