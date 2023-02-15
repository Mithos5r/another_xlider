import 'package:flutter/material.dart' show Icons, Colors;
import 'package:flutter/widgets.dart';

import '../another_xlider.dart';

class MakeHandler extends StatelessWidget {
  final double? width;
  final double? height;
  final GlobalKey? id;
  final XliderHandler? handlerData;
  final bool? visibleTouchArea;
  final Animation? animation;
  final int? handlerIndex;
  final bool rtl;
  final bool rangeSlider;
  final double? touchSize;

  const MakeHandler(
      {Key? key,
      this.id,
      this.handlerData,
      this.visibleTouchArea,
      this.width,
      this.height,
      this.animation,
      this.rtl = false,
      this.rangeSlider = false,
      this.handlerIndex,
      this.touchSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double touchOpacity = (visibleTouchArea == true) ? 1 : 0;

    double localWidth, localHeight;
    localHeight = height! + (touchSize! * 2);
    localWidth = width! + (touchSize! * 2);

    XliderHandler handler = handlerData ?? XliderHandler();

    if (handlerIndex == 2) {
      handler.child ??= const Icon(Icons.chevron_left, color: Colors.black45);
    } else {
      IconData hIcon = Icons.chevron_right;
      if (rtl && !rangeSlider) {
        hIcon = Icons.chevron_left;
      }
      handler.child ??= Icon(hIcon, color: Colors.black45);
    }

    handler.decoration ??= const BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.black26,
          blurRadius: 2,
          spreadRadius: 0.2,
          offset: Offset(0, 1))
    ], color: Colors.white, shape: BoxShape.circle);

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
