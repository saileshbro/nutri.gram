import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_edge_detection/edge_detection.dart';

import 'package:nutrigram_app/common/ui/misc/edge_detection/edge_detection_shape/edge_painter.dart';
import 'package:nutrigram_app/common/ui/misc/edge_detection/edge_detection_shape/magnifier.dart';
import 'package:nutrigram_app/common/ui/misc/edge_detection/edge_detection_shape/touch_bubble.dart';

class EdgeDetectionShape extends StatefulWidget {
  const EdgeDetectionShape(
      {@required this.renderedImageSize,
      @required this.originalImageSize,
      @required this.edgeDetectionResult});

  final Size renderedImageSize;
  final Size originalImageSize;
  final EdgeDetectionResult edgeDetectionResult;

  @override
  _EdgeDetectionShapeState createState() => _EdgeDetectionShapeState();
}

class _EdgeDetectionShapeState extends State<EdgeDetectionShape> {
  double edgeDraggerSize;

  EdgeDetectionResult edgeDetectionResult;
  List<Offset> points;

  double renderedImageWidth;
  double renderedImageHeight;
  double top;
  double left;

  Offset currentDragPosition;

  @override
  void didChangeDependencies() {
    final double shortestSide = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    edgeDraggerSize = shortestSide / 12;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    edgeDetectionResult = widget.edgeDetectionResult;
    _calculateDimensionValues();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Magnifier(
        visible: currentDragPosition != null,
        position: currentDragPosition,
        child: Stack(
          children: [
            _getTouchBubbles(),
            CustomPaint(
                painter: EdgePainter(
                    points: points,
                    color: Theme.of(context).accentColor.withOpacity(0.5)))
          ],
        ));
  }

  void _calculateDimensionValues() {
    top = 0.0;
    left = 0.0;

    final double widthFactor =
        widget.renderedImageSize.width / widget.originalImageSize.width;
    final double heightFactor =
        widget.renderedImageSize.height / widget.originalImageSize.height;
    final double sizeFactor = min(widthFactor, heightFactor);

    renderedImageHeight = widget.originalImageSize.height * sizeFactor;
    top = (widget.renderedImageSize.height - renderedImageHeight) / 2;

    renderedImageWidth = widget.originalImageSize.width * sizeFactor;
    left = (widget.renderedImageSize.width - renderedImageWidth) / 2;
  }

  Offset _getNewPositionAfterDrag(
      Offset position, double renderedImageWidth, double renderedImageHeight) {
    return Offset(
        position.dx / renderedImageWidth, position.dy / renderedImageHeight);
  }

  Offset _clampOffset(Offset givenOffset) {
    final double absoluteX = givenOffset.dx * renderedImageWidth;
    final double absoluteY = givenOffset.dy * renderedImageHeight;

    return Offset(absoluteX.clamp(0.0, renderedImageWidth) / renderedImageWidth,
        absoluteY.clamp(0.0, renderedImageHeight) / renderedImageHeight);
  }

  Widget _getTouchBubbles() {
    points = [
      Offset(left + edgeDetectionResult.topLeft.dx * renderedImageWidth,
          top + edgeDetectionResult.topLeft.dy * renderedImageHeight),
      Offset(left + edgeDetectionResult.topRight.dx * renderedImageWidth,
          top + edgeDetectionResult.topRight.dy * renderedImageHeight),
      Offset(left + edgeDetectionResult.bottomRight.dx * renderedImageWidth,
          top + (edgeDetectionResult.bottomRight.dy * renderedImageHeight)),
      Offset(left + edgeDetectionResult.bottomLeft.dx * renderedImageWidth,
          top + edgeDetectionResult.bottomLeft.dy * renderedImageHeight),
      Offset(left + edgeDetectionResult.topLeft.dx * renderedImageWidth,
          top + edgeDetectionResult.topLeft.dy * renderedImageHeight),
    ];

    void onDragFinished() {
      currentDragPosition = null;
      setState(() {});
    }

    return SizedBox(
      width: widget.renderedImageSize.width,
      height: widget.renderedImageSize.height,
      child: Stack(
        children: [
          Positioned(
            left: points[0].dx - (edgeDraggerSize / 2),
            top: points[0].dy - (edgeDraggerSize / 2),
            child: TouchBubble(
                size: edgeDraggerSize,
                onDrag: (Offset position) {
                  setState(() {
                    currentDragPosition = Offset(points[0].dx, points[0].dy);
                    final Offset newTopLeft = _getNewPositionAfterDrag(
                        position, renderedImageWidth, renderedImageHeight);
                    edgeDetectionResult.topLeft =
                        _clampOffset(edgeDetectionResult.topLeft + newTopLeft);
                  });
                },
                onDragFinished: onDragFinished),
          ),
          Positioned(
            left: points[1].dx - (edgeDraggerSize / 2),
            top: points[1].dy - (edgeDraggerSize / 2),
            child: TouchBubble(
                size: edgeDraggerSize,
                onDrag: (position) {
                  setState(
                    () {
                      final Offset newTopRight = _getNewPositionAfterDrag(
                          position, renderedImageWidth, renderedImageHeight);
                      edgeDetectionResult.topRight = _clampOffset(
                          edgeDetectionResult.topRight + newTopRight);
                      currentDragPosition = Offset(points[1].dx, points[1].dy);
                    },
                  );
                },
                onDragFinished: onDragFinished),
          ),
          Positioned(
            left: points[2].dx - (edgeDraggerSize / 2),
            top: points[2].dy - (edgeDraggerSize / 2),
            child: TouchBubble(
                size: edgeDraggerSize,
                onDrag: (position) {
                  setState(() {
                    final Offset newBottomRight = _getNewPositionAfterDrag(
                        position, renderedImageWidth, renderedImageHeight);
                    edgeDetectionResult.bottomRight = _clampOffset(
                        edgeDetectionResult.bottomRight + newBottomRight);
                    currentDragPosition = Offset(points[2].dx, points[2].dy);
                  });
                },
                onDragFinished: onDragFinished),
          ),
          Positioned(
            left: points[3].dx - (edgeDraggerSize / 2),
            top: points[3].dy - (edgeDraggerSize / 2),
            child: TouchBubble(
                size: edgeDraggerSize,
                onDrag: (position) {
                  setState(() {
                    final Offset newBottomLeft = _getNewPositionAfterDrag(
                        position, renderedImageWidth, renderedImageHeight);
                    edgeDetectionResult.bottomLeft = _clampOffset(
                        edgeDetectionResult.bottomLeft + newBottomLeft);
                    currentDragPosition = Offset(points[3].dx, points[3].dy);
                  });
                },
                onDragFinished: onDragFinished),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
