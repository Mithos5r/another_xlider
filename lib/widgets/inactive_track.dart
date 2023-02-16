import 'package:flutter/widgets.dart';

import '../another_xlider.dart';
import '../models/container_helper_model.dart';

class InactiveTrack extends StatelessWidget {
  const InactiveTrack({
    super.key,
    required this.trackBar,
    required this.disabled,
    required this.containerHelperModel,
    required this.handlersPadding,
  });

  final XliderTrackBarConfiguration trackBar;

  final bool disabled;
  final ContainerHelperModel containerHelperModel;
  final double handlersPadding;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration boxDecoration =
        trackBar.inactiveTrackBar.decoration ?? const BoxDecoration();

    Color trackBarColor =
        boxDecoration.color ?? trackBar.inactiveTrackBar.color;
    if (disabled) {
      trackBarColor = trackBar.inactiveTrackBar.color;
    }

    double? top, bottom, left, width, height;
    top = left = width = height = 0;

    bottom = 0;
    left = handlersPadding;
    width = containerHelperModel.containerWidthWithoutPadding;
    height = trackBar.inactiveTrackBar.thickness;
    top = 0;

    final Widget marked = Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: trackBarColor,
            backgroundBlendMode: boxDecoration.backgroundBlendMode,
            shape: boxDecoration.shape,
            gradient: boxDecoration.gradient,
            border: boxDecoration.border,
            borderRadius: boxDecoration.borderRadius,
            boxShadow: boxDecoration.boxShadow,
            image: boxDecoration.image),
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
    );

    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: marked,
    );
  }
}
