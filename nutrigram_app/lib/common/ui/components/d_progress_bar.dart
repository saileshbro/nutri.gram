import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'dart:math';

class DProgressBar extends StatelessWidget {
  final String title;
  final String value;
  final String valueRed;
  final double percent;

  const DProgressBar({
    Key key,
    this.title,
    this.value,
    this.valueRed = "",
    this.percent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        xsHeightSpan,
        xsHeightSpan,
        Container(
          height: 6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0xffe5e5e5).withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: percent.toInt(),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: _colors[Random().nextInt(_colors.length)],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Expanded(
                flex: (100 - (percent + 1.5).ceil()).clamp(0, 100),
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        mHeightSpan,
      ],
    );
  }

  static const List<Color> _colors = [
    Color(0xFF056676),
    Color(0xFFD54062),
    Color(0xFFDC5306),
    Color(0xFFA28089),
    Color(0xffda3f3a),
    Color(0xffc969b7),
    Color(0xff4f6c16),
    Color(0xffff184c),
    Color(0xff516be8),
    Color(0xffff7854),
    Color(0xff58de87),
    Color(0xffff4a67),
    Color(0xffff577d),
    Color(0xffffccdc),
    Color(0xff0a9cf5),
    Color(0xFFF5DB7E),
    Color(0xFFEE624A),
    Color(0xFF86899F),
    Color(0xFFBD461C),
  ];
}
