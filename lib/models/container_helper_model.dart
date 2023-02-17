import 'dart:math';

import 'package:flutter/widgets.dart';

class ContainerHelperModel {
  const ContainerHelperModel({
    this.containerLeft = 0,
    this.containerTop = 0,
    this.containerHeight = 0,
    this.containerWidth = 0,
    this.constraintMaxHeight = 0,
    this.constraintMaxWidth = 0,
    this.containerHeightWithoutPadding,
    this.containerWidthWithoutPadding,
    this.containerSizeWithoutPadding,
  });

  final double containerLeft;
  final double containerTop;
  final double? containerWidthWithoutPadding;
  final double? containerHeightWithoutPadding;
  final double? containerSizeWithoutPadding;
  final double constraintMaxWidth;
  final double constraintMaxHeight;
  final double containerHeight;
  final double containerWidth;

  ContainerHelperModel setConstraintsAndContainer({
    required double constraintWidth,
    required double constraintHeight,
    required double handlersWidth,
    required double handlersHeight,
    required double sliderProperSize,
  }) {
    final double containerHeightWithoutPadding =
        constraintHeight - handlersHeight;
    final double containerWidthWithoutPadding = constraintWidth - handlersWidth;
    double? containerWidth;
    double? containerHeight;

    double layoutHeight = constraintHeight;
    if (layoutHeight == double.infinity) {
      layoutHeight = 0;
    }
    containerWidth = constraintWidth;
    containerHeight = [(sliderProperSize * 2), layoutHeight].reduce(max);

    return copyWith(
      constraintMaxHeight: constraintHeight,
      constraintMaxWidth: constraintWidth,
      containerWidthWithoutPadding: containerWidthWithoutPadding,
      containerHeightWithoutPadding: containerHeightWithoutPadding,
      containerSizeWithoutPadding: containerWidthWithoutPadding,
      containerHeight: containerHeight,
      containerWidth: containerWidth,
    );
  }

  ContainerHelperModel renderBoxInitialization(
      {required Size screenSize, required GlobalKey containerKey}) {
    double? newLeft;
    double? newTop;
    if (containerLeft <= 0 ||
        (screenSize.width - constraintMaxWidth) <= containerLeft) {
      RenderBox containerRenderBox =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      newLeft = containerRenderBox.localToGlobal(Offset.zero).dx;
    }
    if (containerTop <= 0 ||
        (screenSize.height - constraintMaxHeight) <= containerTop) {
      RenderBox containerRenderBox =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      newTop = containerRenderBox.localToGlobal(Offset.zero).dy;
    }
    return copyWith(containerLeft: newLeft, containerTop: newTop);
  }

  ContainerHelperModel copyWith({
    double? containerLeft,
    double? containerTop,
    double? containerWidthWithoutPadding,
    double? containerHeightWithoutPadding,
    double? containerSizeWithoutPadding,
    double? constraintMaxWidth,
    double? constraintMaxHeight,
    double? containerHeight,
    double? containerWidth,
  }) {
    return ContainerHelperModel(
      containerLeft: containerLeft ?? this.containerLeft,
      containerTop: containerTop ?? this.containerTop,
      containerWidthWithoutPadding:
          containerWidthWithoutPadding ?? this.containerWidthWithoutPadding,
      containerHeightWithoutPadding:
          containerHeightWithoutPadding ?? this.containerHeightWithoutPadding,
      containerSizeWithoutPadding:
          containerSizeWithoutPadding ?? this.containerSizeWithoutPadding,
      constraintMaxWidth: constraintMaxWidth ?? this.constraintMaxWidth,
      constraintMaxHeight: constraintMaxHeight ?? this.constraintMaxHeight,
      containerHeight: containerHeight ?? this.containerHeight,
      containerWidth: containerWidth ?? this.containerWidth,
    );
  }
}
