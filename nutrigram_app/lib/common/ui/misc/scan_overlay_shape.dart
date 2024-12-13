import 'package:flutter/material.dart';

class ScanOverlayShape extends ShapeBorder {
  const ScanOverlayShape({
    this.overlayColor = const Color.fromRGBO(255, 255, 255, 85),
    this.cutOutPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 90),
    this.cutOutRadius = const Radius.circular(8),
  });

  final Color overlayColor;
  final EdgeInsetsGeometry cutOutPadding;
  final Radius cutOutRadius;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect, textDirection: textDirection), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final boxPaint = Paint()
      ..color = overlayColor.withOpacity(1)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final padding = cutOutPadding.resolve(textDirection);
    final cutOutRect = Rect.fromLTRB(
      rect.left + padding.left,
      rect.top + padding.top,
      rect.right - padding.right,
      rect.bottom - padding.bottom,
    );

    canvas
      ..saveLayer(rect, Paint())
      ..drawRect(rect, backgroundPaint)
      ..drawRRect(
        RRect.fromRectAndRadius(cutOutRect, cutOutRadius),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return ScanOverlayShape(
      overlayColor: overlayColor,
      cutOutPadding: cutOutPadding * t,
      cutOutRadius: Radius.elliptical(
        cutOutRadius.x * t,
        cutOutRadius.y * t,
      ),
    );
  }
}
