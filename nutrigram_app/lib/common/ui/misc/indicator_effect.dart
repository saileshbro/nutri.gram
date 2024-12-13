import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/misc/indicator_painter.dart';

/// Abstract base class for indicator effects with customizable styling.
abstract class IndicatorEffect {
  /// Width of each dot.
  final double dotWidth;

  /// Height of each dot.
  final double dotHeight;

  /// Spacing between dots.
  final double spacing;

  /// Border radius for the dots.
  final double radius;

  /// Color of the inactive dots.
  final Color dotColor;

  /// Color of the active dot.
  final Color activeDotColor;

  /// Painting style (e.g., fill or stroke).
  final PaintingStyle paintStyle;

  /// Stroke width (applicable for `PaintingStyle.stroke`).
  final double strokeWidth;

  /// Constructor with required properties.
  const IndicatorEffect({
    required this.strokeWidth,
    required this.dotWidth,
    required this.dotHeight,
    required this.spacing,
    required this.radius,
    required this.dotColor,
    required this.paintStyle,
    required this.activeDotColor,
  })  : assert(dotWidth >= 0, 'Dot width must be non-negative.'),
        assert(dotHeight >= 0, 'Dot height must be non-negative.'),
        assert(spacing >= 0, 'Spacing must be non-negative.'),
        assert(strokeWidth >= 0, 'Stroke width must be non-negative.');

  /// Builds a painter for rendering the indicator.
  IndicatorPainter buildPainter({
    required int count,
    required double offset,
    bool isRTL = false,
  });

  /// Calculates the size required for the indicator.
  Size calculateSize(int count) {
    return Size(
      dotWidth * count + spacing * (count - 1),
      dotHeight,
    );
  }
}
