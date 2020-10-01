import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/ui/misc/indicator_effect.dart';
import 'package:nutrigram_app/common/ui/misc/indicator_painter.dart';
import 'package:nutrigram_app/common/ui/misc/worm_painter.dart';

class CustomWormEffect extends IndicatorEffect {
  const CustomWormEffect({
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotColor != null),
        super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  @override
  IndicatorPainter buildPainter({int count, double offset, bool isRTL}) {
    return WormPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
