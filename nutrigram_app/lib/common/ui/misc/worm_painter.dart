import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:nutrigram_app/common/ui/misc/indicator_painter.dart';

class WormPainter extends IndicatorPainter {
  final WormEffect effect;

  WormPainter({
    @required this.effect,
    @required int count,
    @required double offset,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL: isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    super.paint(canvas, size);
    final activeDotPaint = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    final worm = _calcBounds(offset.floor(), dotOffset * 2);
    canvas.drawRRect(worm, activeDotPaint);
  }

  RRect _calcBounds(num i, double dotOffset) {
    final xPos = i * distance;
    final yPos = (effect.dotHeight) / 2;
    double left = xPos as double;
    double right = xPos +
        effect.dotWidth +
        (dotOffset * (effect.dotWidth + effect.spacing)) as double;
    if (dotOffset > 1) {
      right = xPos + effect.dotWidth + (1 * (effect.dotWidth + effect.spacing))
          as double;
      left = xPos + ((effect.spacing + effect.dotWidth) * (dotOffset - 1))
          as double;
    }
    return RRect.fromLTRBR(
      left,
      yPos - effect.dotHeight / 2,
      right,
      yPos + effect.dotHeight / 2,
      dotRadius,
    );
  }
}
