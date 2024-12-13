import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/misc/indicator_painter.dart';
import 'package:nutrigram_app/common/ui/misc/worm_effect.dart';

class WormPainter extends IndicatorPainter {
  final CustomWormEffect effect;

  WormPainter({
    required this.effect,
    required int count,
    required double offset,
    required bool isRTL,
  }) : super(offset, count, effect, isRTL: isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint static dots
    super.paint(canvas, size);

    // Paint active worm
    final activeDotPaint = Paint()
      ..color = effect.activeDotColor
      ..style = PaintingStyle.fill;

    final currentIndex = offset.floor();
    final dotOffset = offset - currentIndex;

    final wormBounds = _calculateWormBounds(currentIndex, dotOffset);
    canvas.drawRRect(wormBounds, activeDotPaint);
  }

  RRect _calculateWormBounds(int index, double dotOffset) {
    final xPos = index * distance;
    final yPos = effect.dotHeight / 2;

    // Dynamically adjust worm bounds
    final left = xPos + dotOffset * effect.spacing;
    final right = left + effect.dotWidth + (dotOffset * effect.spacing);

    return RRect.fromLTRBR(
      left,
      yPos - effect.dotHeight / 2,
      right,
      yPos + effect.dotHeight / 2,
      dotRadius,
    );
  }
}
