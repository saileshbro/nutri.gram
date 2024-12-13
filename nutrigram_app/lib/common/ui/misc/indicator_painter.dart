import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/misc/indicator_effect.dart';

abstract class IndicatorPainter extends CustomPainter {
  /// The raw offset from the [PageController].page
  final double _rawOffset;

  /// The adjusted offset based on the directionality.
  final double offset;

  /// The total number of pages.
  final int count;

  /// The visual effect for the indicator.
  final IndicatorEffect _effect;

  /// Paint for inactive dots.
  final Paint dotPaint;

  /// Radius for all dots.
  final Radius dotRadius;

  IndicatorPainter(
    this._rawOffset,
    this.count,
    this._effect, {
    required bool isRTL,
  })  : dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth,
        offset = isRTL ? (count - 1) - _rawOffset : _rawOffset;

  /// The distance between dot centers.
  double get distance => _effect.dotWidth + _effect.spacing;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint inactive dots
    for (int i = 0; i < count; i++) {
      final xPos = i * distance;
      final yPos = size.height / 2;
      final bounds = Rect.fromLTWH(
        xPos,
        yPos - _effect.dotHeight / 2,
        _effect.dotWidth,
        _effect.dotHeight,
      );
      final RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    // Repaint only when the offset changes
    return oldDelegate._rawOffset != _rawOffset;
  }
}
