import 'package:flutter/widgets.dart';

import '../xlider.dart';
import '../models/tooltip_helper_model.dart';

class Tooltip extends StatelessWidget {
  const Tooltip({
    super.key,
    required this.side,
    required this.value,
    required this.opacity,
    required this.tooltipHelperModel,
    required this.isRangeSlider,
    required this.tooltip,
    required this.leftTooltipKey,
    required this.rightTooltipKey,
    required this.animation,
  });

  final XliderSide side;
  final double value;
  final double opacity;
  final Animation<Offset> animation;
  final TooltipHelperModel tooltipHelperModel;
  final bool isRangeSlider;
  final GlobalKey leftTooltipKey, rightTooltipKey;
  final XliderTooltip? tooltip;

  @override
  Widget build(BuildContext context) {
    if (tooltipHelperModel.tooltipData.disabled) {
      return const SizedBox();
    }

    Widget? prefix;
    Widget? suffix;

    if (side == XliderSide.left) {
      if (!isRangeSlider) {
        return const SizedBox();
      }
      prefix =
          tooltipHelperModel.tooltipData.decorations.leftComplements.prefix;
      suffix =
          tooltipHelperModel.tooltipData.decorations.leftComplements.suffix;
    } else {
      prefix =
          tooltipHelperModel.tooltipData.decorations.rightComplements.prefix;
      suffix =
          tooltipHelperModel.tooltipData.decorations.rightComplements.suffix;
    }
    String numberFormat = value.toString();
    if (tooltipHelperModel.tooltipData.format != null) {
      numberFormat = tooltipHelperModel.tooltipData.format!(numberFormat);
    }

    List<Widget> children = [
      if (prefix != null) prefix,
      Text(
        numberFormat,
        style: tooltipHelperModel.tooltipData.decorations.textStyle,
      ),
      if (suffix != null) suffix,
    ];

    Widget tooltipHolderWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    if (tooltipHelperModel.tooltipData.direction ==
        XliderTooltipDirection.top) {
      tooltipHolderWidget = Row(
        mainAxisSize: MainAxisSize.max,
        children: children,
      );
    }

    final XliderTooltip? customTooltip = tooltip;

    Widget tooltipWidget = IgnorePointer(
      child: Center(
        child: FittedBox(
          child: Container(
            key: (side == XliderSide.left) ? leftTooltipKey : rightTooltipKey,
            child: (customTooltip != null && customTooltip.custom != null)
                ? customTooltip.custom!(value)
                : Container(
                    padding: const EdgeInsets.all(8),
                    decoration: tooltipHelperModel
                        .tooltipData.decorations.boxStyle?.decoration,
                    foregroundDecoration: tooltipHelperModel
                        .tooltipData.decorations.boxStyle?.foregroundDecoration,
                    transform: tooltipHelperModel
                        .tooltipData.decorations.boxStyle?.transform,
                    child: tooltipHolderWidget,
                  ),
          ),
        ),
      ),
    );

    double? top, right, bottom, left;
    switch (tooltipHelperModel.tooltipData.direction) {
      case XliderTooltipDirection.top:
        top = 0;
        break;
      case XliderTooltipDirection.left:
        left = 0;
        break;
      case XliderTooltipDirection.right:
        right = 0;
        break;
    }

    if (tooltipHelperModel.tooltipData.positionOffset != null) {
      if (tooltipHelperModel.tooltipData.positionOffset!.top != null) {
        top = (top ?? 0) + tooltipHelperModel.tooltipData.positionOffset!.top!;
      }
      if (tooltipHelperModel.tooltipData.positionOffset!.left != null) {
        left =
            (left ?? 0) + tooltipHelperModel.tooltipData.positionOffset!.left!;
      }
      if (tooltipHelperModel.tooltipData.positionOffset!.right != null) {
        right = (right ?? 0) +
            tooltipHelperModel.tooltipData.positionOffset!.right!;
      }
    }

    tooltipWidget = SlideTransition(position: animation, child: tooltipWidget);

    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Opacity(
        opacity: opacity,
        child: Center(child: tooltipWidget),
      ),
    );
  }
}
