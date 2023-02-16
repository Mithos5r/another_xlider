import 'package:flutter/widgets.dart';

import '../another_xlider.dart';
import '../models/container_helper_model.dart';
import '../models/handler_helper_model.dart';

class ActiveTrack extends StatelessWidget {
  const ActiveTrack({
    super.key,
    required this.trackBar,
    required this.disabled,
    required this.containerHelperModel,
    required this.handlerHelperModel,
    required this.touchSize,
    required this.isRangeSlider,
    required this.isCenterOrigen,
    required this.isRtl,
  });

  final XliderTrackBarConfiguration trackBar;

  final bool disabled;
  final double touchSize;
  final ContainerHelperModel containerHelperModel;
  final HandlerHelperModel handlerHelperModel;
  final bool isRangeSlider, isCenterOrigen, isRtl;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration? boxDecoration = trackBar.activeTrackbar.decoration;

    Color trackBarColor = boxDecoration?.color ?? trackBar.activeTrackbar.color;
    if (disabled) {
      trackBarColor = trackBar.inactiveTrackBar.color;
    }

    double? top, bottom, left, right, width, height;
    top = left = width = height = 0;
    right = bottom = null;
    bottom = 0;
    height = trackBar.activeTrackbar.thickness;
    if (!isCenterOrigen || isRangeSlider) {
      width = handlerHelperModel.rightHandlerXPosition -
          handlerHelperModel.leftHandlerXPosition;
      left = handlerHelperModel.leftHandlerXPosition +
          handlerHelperModel.handlersWidth / 2 +
          touchSize;

      if (isRtl == true && isRangeSlider == false) {
        left = null;
        right = handlerHelperModel.handlersWidth / 2;
        width = containerHelperModel.containerWidthWithoutPadding! -
            handlerHelperModel.rightHandlerXPosition -
            touchSize;
      }
    } else {
      right = 0;
      width = trackBar.activeTrackbar.thickness;

      if (!isCenterOrigen || isRangeSlider) {
        height = handlerHelperModel.rightHandlerYPosition -
            handlerHelperModel.leftHandlerYPosition;
        top = handlerHelperModel.leftHandlerYPosition +
            handlerHelperModel.handlersHeight / 2 +
            touchSize;
        if (isRtl == true && isRangeSlider == false) {
          top = null;
          bottom = handlerHelperModel.handlersHeight / 2;
          height = containerHelperModel.containerHeightWithoutPadding! -
              handlerHelperModel.rightHandlerYPosition -
              touchSize;
        }
      } else {
        if (containerHelperModel.containerHeightWithoutPadding! / 2 -
                touchSize >
            handlerHelperModel.rightHandlerYPosition) {
          height = containerHelperModel.containerHeightWithoutPadding! / 2 -
              handlerHelperModel.rightHandlerYPosition -
              touchSize;
          top = handlerHelperModel.rightHandlerYPosition +
              handlerHelperModel.handlersHeight / 2 +
              touchSize;
        } else {
          top = containerHelperModel.containerHeightWithoutPadding! / 2 +
              handlerHelperModel.handlersPadding;
          height = handlerHelperModel.rightHandlerYPosition +
              touchSize -
              containerHelperModel.containerHeightWithoutPadding! / 2;
        }
      }
    }

    width = ((width) < 0) ? 0 : width;
    height = ((height) < 0) ? 0 : height;

    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Center(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: trackBarColor,
            backgroundBlendMode: boxDecoration?.backgroundBlendMode,
            shape: boxDecoration?.shape ?? BoxShape.rectangle,
            gradient: boxDecoration?.gradient,
            border: boxDecoration?.border,
            borderRadius: boxDecoration?.borderRadius,
            boxShadow: boxDecoration?.boxShadow,
            image: boxDecoration?.image,
          ),
        ),
      ),
    );
  }
}
