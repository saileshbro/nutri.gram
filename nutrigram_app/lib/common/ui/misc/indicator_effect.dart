import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/ui/misc/indicator_painter.dart';

abstract class IndicatorEffect {
  final double dotWidth;
  final double dotHeight;
  final double spacing;
  final double radius;
  final Color dotColor;
  final Color activeDotColor;
  final PaintingStyle paintStyle;
  final double strokeWidth;
  const IndicatorEffect({
    @required this.strokeWidth,
    @required this.dotWidth,
    @required this.dotHeight,
    @required this.spacing,
    @required this.radius,
    @required this.dotColor,
    @required this.paintStyle,
    @required this.activeDotColor,
  })  : assert(radius != null),
        assert(dotColor != null || paintStyle != null || strokeWidth != null),
        assert(activeDotColor != null),
        assert(dotWidth != null),
        assert(dotHeight != null),
        assert(spacing != null),
        assert(dotWidth >= 0 &&
            dotHeight >= 0 &&
            spacing >= 0 &&
            strokeWidth >= 0);
  IndicatorPainter buildPainter({int count, double offset, bool isRTL});
  Size calculateSize(int count) {
    return Size(dotWidth * count + (spacing * (count - 1)), dotHeight);
  }
}
