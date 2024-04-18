import 'package:flutter/material.dart' show Icons, Colors;
import 'package:flutter/widgets.dart';

import '../xlider.dart';

class MakeHandler extends StatelessWidget {
  final double? width;
  final double? height;
  final GlobalKey? id;
  final XliderHandler? handlerData;
  final bool? visibleTouchArea;
  final Animation? animation;
  final XliderSide? handlerSide;
  final bool rtl;
  final bool rangeSlider;
  final double? touchSize;

  const MakeHandler(
      {super.key,
      this.id,
      this.handlerData,
      this.visibleTouchArea,
      this.width,
      this.height,
      this.animation,
      this.rtl = false,
      this.rangeSlider = false,
      this.handlerSide = XliderSide.left,
      this.touchSize});

  @override
  Widget build(BuildContext context) {
    double touchOpacity = (visibleTouchArea == true) ? 1 : 0;

    double localWidth, localHeight;
    localHeight = height! + (touchSize! * 2);
    localWidth = width! + (touchSize! * 2);

    XliderHandler handler = handlerData ?? const XliderHandler();
    Widget? child;
    if (handlerSide == XliderSide.right) {
      child = const Icon(Icons.chevron_left, color: Colors.black45);
    } else {
      IconData hIcon = Icons.chevron_right;
      if (rtl && !rangeSlider) {
        hIcon = Icons.chevron_left;
      }
      child ??= Icon(hIcon, color: Colors.black45);
    }
    handler = handler.copyWith(child: handler.child ?? child);

    return Center(
      child: SizedBox(
        key: id,
        width: localWidth,
        height: localHeight,
        child: Stack(children: <Widget>[
          Opacity(
            opacity: touchOpacity,
            child: Container(
              color: Colors.black12,
              child: Container(),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: animation as Animation<double>,
              child: Opacity(
                opacity: handler.opacity,
                child: Container(
                  alignment: Alignment.center,
                  foregroundDecoration: handler.foregroundDecoration,
                  decoration: handler.decoration,
                  transform: handler.transform,
                  width: width,
                  height: height,
                  child: handler.child,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
