import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

class DProgressBar extends StatelessWidget {
  final String title;
  final String value;
  final double percent;
  final Color color;

  const DProgressBar({
    required this.title,
    required this.value,
    this.percent = 0.0,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        sHeightSpan,
        Container(
          height: 6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0xffe5e5e5).withOpacity(0.7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: (percent * 100).ceil().clamp(0, 100),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Expanded(
                flex: (100 - (percent * 100).ceil()).clamp(0, 100),
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        mHeightSpan,
      ],
    );
  }
}
