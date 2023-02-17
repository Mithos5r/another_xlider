import 'package:flutter/widgets.dart';

import '../another_xlider.dart';

class TooltipHelperModel {
  const TooltipHelperModel({
    this.rightTooltipOpacity = 0,
    this.leftTooltipOpacity = 0,
    this.rightTooltipAnimationController,
    this.rightTooltipAnimation,
    this.leftTooltipAnimationController,
    this.leftTooltipAnimation,
    this.tooltipData = const XliderTooltip(),
  });

  final double rightTooltipOpacity;
  final double leftTooltipOpacity;

  final AnimationController? rightTooltipAnimationController;
  final AnimationController? leftTooltipAnimationController;
  final Animation<Offset>? rightTooltipAnimation;

  final Animation<Offset>? leftTooltipAnimation;

  final XliderTooltip tooltipData;

  void dispose() {
    rightTooltipAnimationController?.dispose();
    leftTooltipAnimationController?.dispose();
  }

  TooltipHelperModel hideTooltips() {
    if (!tooltipData.alwaysShowTooltip) {
      final refresh = copyWith(rightTooltipOpacity: 0, leftTooltipOpacity: 0);

      refresh.leftTooltipAnimationController?.reset();
      refresh.rightTooltipAnimationController?.reset();
      return refresh;
    }
    return this;
  }

  TooltipHelperModel startLeftAnimation({required bool lockHandlers}) {
    final refresh = copyWith(
        leftTooltipOpacity: 1, rightTooltipOpacity: lockHandlers ? 1 : null);
    refresh.leftTooltipAnimationController?.forward();

    if (lockHandlers) {
      refresh.rightTooltipAnimationController?.forward();
    }
    return refresh;
  }

  TooltipHelperModel startRightAnimation({required bool lockHandlers}) {
    final refresh = copyWith(
        leftTooltipOpacity: lockHandlers ? 1 : null, rightTooltipOpacity: 1);
    refresh.rightTooltipAnimationController?.forward();

    if (lockHandlers) {
      refresh.leftTooltipAnimationController?.forward();
    }
    return refresh;
  }

  TooltipHelperModel animationInstance({
    required bool isInitCall,
    required TickerProvider tickerProvider,
    required Offset animationStart,
    required Offset animationFinish,
  }) {
    AnimationController leftTooltipAnimationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: tickerProvider);
    AnimationController rightTooltipAnimationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: tickerProvider);
    final bool alwaysShowTooltip = (tooltipData.alwaysShowTooltip == true);

    final Animation<Offset> leftTooltipAnimation =
        Tween<Offset>(begin: animationStart, end: animationFinish).animate(
      CurvedAnimation(
          parent: this.leftTooltipAnimationController ??
              leftTooltipAnimationController,
          curve: Curves.fastOutSlowIn),
    );

    final Animation<Offset> rightTooltipAnimation =
        Tween<Offset>(begin: animationStart, end: animationFinish).animate(
      CurvedAnimation(
          parent: this.rightTooltipAnimationController ??
              rightTooltipAnimationController,
          curve: Curves.fastOutSlowIn),
    );

    return copyWith(
      rightTooltipOpacity: alwaysShowTooltip ? 1 : null,
      leftTooltipOpacity: alwaysShowTooltip ? 1 : null,
      leftTooltipAnimationController:
          isInitCall ? leftTooltipAnimationController : null,
      rightTooltipAnimationController:
          isInitCall ? rightTooltipAnimationController : null,
      leftTooltipAnimation: leftTooltipAnimation,
      rightTooltipAnimation: rightTooltipAnimation,
    );
  }

  TooltipHelperModel copyWith({
    double? rightTooltipOpacity,
    double? leftTooltipOpacity,
    AnimationController? rightTooltipAnimationController,
    Animation<Offset>? rightTooltipAnimation,
    AnimationController? leftTooltipAnimationController,
    Animation<Offset>? leftTooltipAnimation,
    XliderTooltip? tooltipData,
  }) {
    return TooltipHelperModel(
      rightTooltipOpacity: rightTooltipOpacity ?? this.rightTooltipOpacity,
      leftTooltipOpacity: leftTooltipOpacity ?? this.leftTooltipOpacity,
      rightTooltipAnimationController: rightTooltipAnimationController ??
          this.rightTooltipAnimationController,
      rightTooltipAnimation:
          rightTooltipAnimation ?? this.rightTooltipAnimation,
      leftTooltipAnimationController:
          leftTooltipAnimationController ?? this.leftTooltipAnimationController,
      leftTooltipAnimation: leftTooltipAnimation ?? this.leftTooltipAnimation,
      tooltipData: tooltipData ?? this.tooltipData,
    );
  }
}
