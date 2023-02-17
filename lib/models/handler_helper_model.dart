import 'package:flutter/widgets.dart';

import '../another_xlider.dart';
import '../widgets/make_handler.dart';

class HandlerHelperModel {
  final double leftHandlerXPosition;
  final double rightHandlerXPosition;
  final double leftHandlerYPosition;
  final double rightHandlerYPosition;
  final double handlersPadding;
  final Widget leftHandler;
  final Widget rightHandler;
  final double handlersWidth;
  final double handlersHeight;
  final AnimationController? leftHandlerScaleAnimationController;
  final Animation<double>? leftHandlerScaleAnimation;
  final AnimationController? rightHandlerScaleAnimationController;
  final Animation<double>? rightHandlerScaleAnimation;

  const HandlerHelperModel({
    this.leftHandlerXPosition = 0,
    this.rightHandlerXPosition = 0,
    this.leftHandlerYPosition = 0,
    this.rightHandlerYPosition = 0,
    this.leftHandler = const SizedBox(),
    this.rightHandler = const SizedBox(),
    this.handlersPadding = 0,
    this.handlersWidth = 35,
    this.handlersHeight = 35,
    this.leftHandlerScaleAnimationController,
    this.leftHandlerScaleAnimation,
    this.rightHandlerScaleAnimationController,
    this.rightHandlerScaleAnimation,
  });

  void dispose() {
    leftHandlerScaleAnimationController?.dispose();
    rightHandlerScaleAnimationController?.dispose();
  }

  void stopHandlerLeftAnimation({required bool hasCustomReverseCurve}) =>
      _stopHandlerAnimation(
        animation: leftHandlerScaleAnimation,
        controller: leftHandlerScaleAnimationController,
        hasCustomReverseCurve: hasCustomReverseCurve,
      );
  void stopHandlerRightAnimation({required bool hasCustomReverseCurve}) =>
      _stopHandlerAnimation(
        animation: rightHandlerScaleAnimation,
        controller: rightHandlerScaleAnimationController,
        hasCustomReverseCurve: hasCustomReverseCurve,
      );

  void stopHandlerAnimation({required bool hasCustomReverseCurve}) {
    stopHandlerLeftAnimation(hasCustomReverseCurve: hasCustomReverseCurve);
    stopHandlerRightAnimation(hasCustomReverseCurve: hasCustomReverseCurve);
  }

  void _stopHandlerAnimation({
    Animation? animation,
    AnimationController? controller,
    required bool hasCustomReverseCurve,
  }) {
    if (hasCustomReverseCurve) {
      if (animation!.isCompleted) {
        controller!.reverse();
      } else {
        controller!.reset();
      }
    } else {
      controller!.reset();
    }
  }

  HandlerHelperModel setAnimations({
    required bool isInitialCall,
    required TickerProvider animationProvider,
    required XliderHandlerAnimation xliderHandlerAnimation,
  }) {
    final AnimationController leftHandlerAnimationController =
        AnimationController(
      duration: xliderHandlerAnimation.duration,
      vsync: animationProvider,
    );
    final AnimationController rightHandlerAnimationController =
        AnimationController(
      duration: xliderHandlerAnimation.duration,
      vsync: animationProvider,
    );

    final Animation<double> leftHandlerScaleAnimation =
        Tween(begin: 1.0, end: xliderHandlerAnimation.scale).animate(
            CurvedAnimation(
                parent: leftHandlerScaleAnimationController ??
                    leftHandlerAnimationController,
                reverseCurve: xliderHandlerAnimation.reverseCurve,
                curve: xliderHandlerAnimation.curve));
    final Animation<double> rightHandlerScaleAnimation =
        Tween(begin: 1.0, end: xliderHandlerAnimation.scale).animate(
            CurvedAnimation(
                parent: rightHandlerScaleAnimationController ??
                    rightHandlerAnimationController,
                reverseCurve: xliderHandlerAnimation.reverseCurve,
                curve: xliderHandlerAnimation.curve));

    return copyWith(
      rightHandlerScaleAnimationController:
          isInitialCall ? rightHandlerAnimationController : null,
      leftHandlerScaleAnimationController:
          isInitialCall ? leftHandlerAnimationController : null,
      leftHandlerScaleAnimation: leftHandlerScaleAnimation,
      rightHandlerScaleAnimation: rightHandlerScaleAnimation,
    );
  }

  HandlerHelperModel resetHandlerPositions() => copyWith(
        leftHandlerXPosition: 0,
        rightHandlerXPosition: 0,
        leftHandlerYPosition: 0,
        rightHandlerYPosition: 0,
      );

  HandlerHelperModel adjustRightHandlerPosition({
    required bool jump,
    required double upperPositionValue,
    required double posititonValue,
    required bool lockHandlers,
  }) {
    double leftHandlerXPosition = this.leftHandlerXPosition,
        rightHandlerXPosition = this.rightHandlerXPosition,
        leftHandlerYPosition = this.leftHandlerYPosition,
        rightHandlerYPosition = this.rightHandlerYPosition;
    if (!jump) {
      double position = upperPositionValue;

      rightHandlerXPosition =
          position < leftHandlerXPosition ? leftHandlerXPosition : position;
      if (lockHandlers) {
        position = posititonValue;
        leftHandlerXPosition =
            position > rightHandlerXPosition ? rightHandlerXPosition : position;
      }

      return copyWith(
        leftHandlerXPosition: leftHandlerXPosition,
        rightHandlerXPosition: rightHandlerXPosition,
        leftHandlerYPosition: leftHandlerYPosition,
        rightHandlerYPosition: rightHandlerYPosition,
      );
    }
    return this;
  }

  HandlerHelperModel adjustLeftHandlerPosition({
    required bool jump,
    required double lowerPositionValue,
    required double posititonValue,
    required bool lockHandlers,
    required double lockedHandlersDragOffset,
  }) {
    if (!jump) {
      double position = lowerPositionValue;
      double leftHandlerXPosition = this.leftHandlerXPosition,
          rightHandlerXPosition = this.rightHandlerXPosition,
          leftHandlerYPosition = this.leftHandlerYPosition,
          rightHandlerYPosition = this.rightHandlerYPosition;
      leftHandlerXPosition =
          position > rightHandlerXPosition ? rightHandlerXPosition : position;
      if (lockHandlers || lockedHandlersDragOffset > 0) {
        position = posititonValue;
        rightHandlerXPosition =
            position < leftHandlerXPosition ? leftHandlerXPosition : position;
      }

      return copyWith(
        leftHandlerXPosition: leftHandlerXPosition,
        rightHandlerXPosition: rightHandlerXPosition,
        leftHandlerYPosition: leftHandlerYPosition,
        rightHandlerYPosition: rightHandlerYPosition,
      );
    }
    return this;
  }

  HandlerHelperModel arrangeHandlersPosition({
    required bool dragging,
    required double lowerPositionByValue,
    required double upperPositionByValue,
  }) {
    if (!dragging) {
      return copyWith(
        handlersPadding: handlersWidth / 2,
        leftHandlerXPosition: lowerPositionByValue,
        rightHandlerXPosition: upperPositionByValue,
      );
    }
    return this;
  }

  HandlerHelperModel generateHandler({
    required XliderHandler? rightHandler,
    required bool isRangeSlider,
    required GlobalKey rightHandlerKey,
    required GlobalKey leftHandlerKey,
    required bool visibleTouchArea,
    required XliderHandler? handler,
    required double? touchSize,
    required bool rtl,
  }) {
    final rightWidgetHandler = MakeHandler(
      animation: rightHandlerScaleAnimation,
      id: rightHandlerKey,
      visibleTouchArea: visibleTouchArea,
      handlerData: rightHandler,
      width: handlersWidth,
      height: handlersHeight,
      handlerSide: XliderSide.right,
      touchSize: touchSize,
    );

    final leftWidgetHandler = MakeHandler(
        animation: leftHandlerScaleAnimation,
        id: leftHandlerKey,
        visibleTouchArea: visibleTouchArea,
        handlerData: handler,
        width: handlersWidth,
        height: handlersHeight,
        rtl: rtl,
        rangeSlider: isRangeSlider,
        touchSize: touchSize);

    return copyWith(
      rightHandler: !isRangeSlider ? leftWidgetHandler : rightWidgetHandler,
      leftHandler: leftWidgetHandler,
    );
  }

  HandlerHelperModel copyWith({
    double? leftHandlerXPosition,
    double? rightHandlerXPosition,
    double? leftHandlerYPosition,
    double? rightHandlerYPosition,
    double? handlersPadding,
    Widget? leftHandler,
    Widget? rightHandler,
    double? handlersWidth,
    double? handlersHeight,
    AnimationController? leftHandlerScaleAnimationController,
    Animation<double>? leftHandlerScaleAnimation,
    AnimationController? rightHandlerScaleAnimationController,
    Animation<double>? rightHandlerScaleAnimation,
  }) {
    return HandlerHelperModel(
      leftHandlerXPosition: leftHandlerXPosition ?? this.leftHandlerXPosition,
      rightHandlerXPosition:
          rightHandlerXPosition ?? this.rightHandlerXPosition,
      leftHandlerYPosition: leftHandlerYPosition ?? this.leftHandlerYPosition,
      rightHandlerYPosition:
          rightHandlerYPosition ?? this.rightHandlerYPosition,
      handlersPadding: handlersPadding ?? this.handlersPadding,
      leftHandler: leftHandler ?? this.leftHandler,
      rightHandler: rightHandler ?? this.rightHandler,
      handlersWidth: handlersWidth ?? this.handlersWidth,
      handlersHeight: handlersHeight ?? this.handlersHeight,
      leftHandlerScaleAnimationController:
          leftHandlerScaleAnimationController ??
              this.leftHandlerScaleAnimationController,
      leftHandlerScaleAnimation:
          leftHandlerScaleAnimation ?? this.leftHandlerScaleAnimation,
      rightHandlerScaleAnimationController:
          rightHandlerScaleAnimationController ??
              this.rightHandlerScaleAnimationController,
      rightHandlerScaleAnimation:
          rightHandlerScaleAnimation ?? this.rightHandlerScaleAnimation,
    );
  }
}
