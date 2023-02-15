import 'package:flutter/widgets.dart';

import '../another_xlider.dart';

class HatchMarkHelperModal {
  HatchMarkHelperModal({
    required double handlersWidth,
    required double handlersHeight,
    required double constraintMaxWidth,
    required double constraintMaxHeight,
    required this.hatchMark,
    required this.percentaje,
    required this.handlersPadding,
    required this.containerHeight,
    required this.getPositioned,
    required this.containerWidth,
    required this.maxTrackBarHeight,
    required this.containerWidthWithoutPadding,
    required this.containerHeightWithoutPadding,
    required this.rtl,
  })  : distance = ((constraintMaxWidth - handlersWidth) / percentaje),
        linesAlignment =
            (hatchMark.linesAlignment == XliderHatchMarkAlignment.left)
                ? Alignment.bottomCenter
                : Alignment.topCenter;

  final double distance;
  final Alignment linesAlignment;
  final XliderHatchMark hatchMark;

  final double handlersPadding;
  final double containerHeight;
  final double containerWidth;
  final double containerWidthWithoutPadding;
  final double containerHeightWithoutPadding;
  final double percentaje;
  final double maxTrackBarHeight;
  final void Function(Positioned positioned) getPositioned;

  final bool rtl;

  void obtainPoints() {
    double barWidth, barHeight;
    double? linesTop, linesLeft, linesRight, linesBottom;
    Widget barLine;

    for (int p = 0; p <= percentaje; p++) {
      XliderSizedBox? barLineBox = hatchMark.smallLine;

      if (p % (hatchMark.smallDensity + 1) == 0) {
        barLineBox = hatchMark.bigLine;
      }
      barHeight = barLineBox!.height;
      barWidth = barLineBox.width;

      barLine = Align(
        alignment: linesAlignment,
        child: Container(
          decoration: barLineBox.decoration,
          foregroundDecoration: barLineBox.foregroundDecoration,
          transform: barLineBox.transform,
          height: barHeight,
          width: barWidth,
        ),
      );
      linesLeft = (p * distance) + handlersPadding - 0.75;
      if (hatchMark.linesAlignment == XliderHatchMarkAlignment.right) {
        linesTop = containerHeight / 2 + maxTrackBarHeight / 2 + 2;
        linesBottom = containerHeight / 2 - maxTrackBarHeight - 15;
      } else {
        linesTop = containerHeight / 2 - maxTrackBarHeight - 15;
        linesBottom = containerHeight / 2 + maxTrackBarHeight / 2 + 2;
      }
      if (hatchMark.linesAlignment == XliderHatchMarkAlignment.left) {
        linesBottom += hatchMark.linesDistanceFromTrackBar!;
      } else {
        linesTop += hatchMark.linesDistanceFromTrackBar!;
      }

      getPositioned(
        Positioned(
            top: linesTop,
            bottom: linesBottom,
            left: linesLeft,
            right: linesRight,
            child: barLine),
      );
    }
  }

  void obtainLabelPoints(List<XliderHatchMarkLabel> labels) {
    List<Widget> labelWidget = [];
    Widget? label;
    double labelBoxHalfSize;
    double? top, left, bottom, right;
    double? tr;
    for (XliderHatchMarkLabel markLabel in labels) {
      label = markLabel.label;
      tr = markLabel.percent;
      labelBoxHalfSize = 0;

      if (rtl) tr = 100 - tr!;

      labelBoxHalfSize = hatchMark.labelBox!.width / 2 - 0.5;

      labelWidget = [
        Container(
          width: hatchMark.labelBox!.width,
          decoration: hatchMark.labelBox!.decoration,
          foregroundDecoration: hatchMark.labelBox!.foregroundDecoration,
          transform: hatchMark.labelBox!.transform,
          child: Align(alignment: Alignment.center, child: label),
        )
      ];

      Widget bar;
      bar = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: labelWidget,
      );
      left = tr! * containerWidthWithoutPadding / 100 -
          0.5 +
          handlersPadding -
          labelBoxHalfSize;
      top = hatchMark.labelsDistanceFromTrackBar;
      bottom = 0;

      getPositioned(
        Positioned(
            top: top, bottom: bottom, left: left, right: right, child: bar),
      );
    }
  }
}
