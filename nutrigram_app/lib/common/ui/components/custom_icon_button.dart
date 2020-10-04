import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

class CustomIconButton extends StatelessWidget {
  final Color gradientColor;
  final Color color;
  final IconData icon;
  final bool isBig;
  final double radius;
  final double iconSize;
  final bool hasBoxShadow;
  final VoidCallback onPressed;
  final bool isBusy;
  const CustomIconButton({
    Key key,
    this.gradientColor,
    this.isBig = false,
    @required this.color,
    @required this.icon,
    @required this.onPressed,
    this.iconSize = 22,
    this.radius = 22,
    this.hasBoxShadow = true,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: hasBoxShadow ? getBoxShadow(context, color) : null,
            gradient: gradientColor != null
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      gradientColor,
                      color,
                    ],
                  )
                : null,
            color: color,
          ),
          child: isBusy
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(
                  icon,
                  size: iconSize,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
