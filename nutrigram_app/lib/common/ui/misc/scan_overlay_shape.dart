import 'dart:ui';

import 'package:flutter/material.dart';

class ScanOverlayShape extends ShapeBorder {
  const ScanOverlayShape({
    this.overlayColor = const Color.fromRGBO(255, 255, 255, 85),
  });

  final Color overlayColor;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final width = rect.width;
    final height = rect.height;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final boxPaint = Paint()
      ..color = overlayColor.withOpacity(1)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + 16,
      rect.top + 90,
      width - 2 * 16,
      height * 0.76,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          const Radius.circular(8),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return ScanOverlayShape(
      overlayColor: overlayColor,
    );
  }
}
