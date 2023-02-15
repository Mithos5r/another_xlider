part of xlider;

class XliderTooltip {
  final Widget Function(dynamic value)? custom;
  final String Function(String value)? format;
  final TextStyle? textStyle;
  final XliderTooltipBox? boxStyle;
  final Widget? leftPrefix;
  final Widget? leftSuffix;
  final Widget? rightPrefix;
  final Widget? rightSuffix;
  final bool alwaysShowTooltip;
  final bool disabled;
  final bool disableAnimation;
  final XliderTooltipDirection direction;
  final XliderTooltipPositionOffset? positionOffset;

  const XliderTooltip({
    this.custom,
    this.format,
    this.textStyle,
    this.boxStyle,
    this.leftPrefix,
    this.leftSuffix,
    this.rightPrefix,
    this.rightSuffix,
    this.alwaysShowTooltip = false,
    this.disableAnimation = false,
    this.disabled = false,
    this.direction = XliderTooltipDirection.top,
    this.positionOffset,
  });

  @override
  String toString() {
    return '$textStyle-$boxStyle-$leftPrefix-$leftSuffix-$rightPrefix-$rightSuffix-$alwaysShowTooltip-$disabled-$disableAnimation-$direction-$positionOffset';
  }

  XliderTooltip copyWith({
    Widget Function(dynamic value)? custom,
    String Function(String value)? format,
    TextStyle? textStyle,
    XliderTooltipBox? boxStyle,
    Widget? leftPrefix,
    Widget? leftSuffix,
    Widget? rightPrefix,
    Widget? rightSuffix,
    bool? alwaysShowTooltip,
    bool? disabled,
    bool? disableAnimation,
    XliderTooltipDirection? direction,
    XliderTooltipPositionOffset? positionOffset,
  }) {
    return XliderTooltip(
      custom: custom ?? this.custom,
      format: format ?? this.format,
      textStyle: textStyle ?? this.textStyle,
      boxStyle: boxStyle ?? this.boxStyle,
      leftPrefix: leftPrefix ?? this.leftPrefix,
      leftSuffix: leftSuffix ?? this.leftSuffix,
      rightPrefix: rightPrefix ?? this.rightPrefix,
      rightSuffix: rightSuffix ?? this.rightSuffix,
      alwaysShowTooltip: alwaysShowTooltip ?? this.alwaysShowTooltip,
      disabled: disabled ?? this.disabled,
      disableAnimation: disableAnimation ?? this.disableAnimation,
      direction: direction ?? this.direction,
      positionOffset: positionOffset ?? this.positionOffset,
    );
  }

  @override
  bool operator ==(covariant XliderTooltip other) {
    if (identical(this, other)) return true;

    return other.custom == custom &&
        other.format == format &&
        other.textStyle == textStyle &&
        other.boxStyle == boxStyle &&
        other.leftPrefix == leftPrefix &&
        other.leftSuffix == leftSuffix &&
        other.rightPrefix == rightPrefix &&
        other.rightSuffix == rightSuffix &&
        other.alwaysShowTooltip == alwaysShowTooltip &&
        other.disabled == disabled &&
        other.disableAnimation == disableAnimation &&
        other.direction == direction &&
        other.positionOffset == positionOffset;
  }

  @override
  int get hashCode {
    return custom.hashCode ^
        format.hashCode ^
        textStyle.hashCode ^
        boxStyle.hashCode ^
        leftPrefix.hashCode ^
        leftSuffix.hashCode ^
        rightPrefix.hashCode ^
        rightSuffix.hashCode ^
        alwaysShowTooltip.hashCode ^
        disabled.hashCode ^
        disableAnimation.hashCode ^
        direction.hashCode ^
        positionOffset.hashCode;
  }
}
