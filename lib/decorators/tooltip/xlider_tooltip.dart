part of xlider;

class XliderTooltip {
  final Widget Function(double value)? custom;
  final String Function(String value)? format;

  ///All decorations that will be on top of [custom]. It's possible to add prefix or suffix widgets
  final XliderTooltipDecorations decorations;

  ///Always will be display close to handler the tooltip. Dissable show animation
  final bool alwaysShowTooltip;

  //If disabled is true. No tooltip will be show
  final bool disabled;

  final bool disableAnimation;

  ///Where the tooltip it's showing
  final XliderTooltipDirection direction;

  ///How much or less are for the current position
  final XliderTooltipPositionOffset? positionOffset;

  const XliderTooltip({
    this.custom,
    this.format,
    this.decorations = const XliderTooltipDecorations(),
    this.alwaysShowTooltip = false,
    this.disableAnimation = false,
    this.disabled = false,
    this.direction = XliderTooltipDirection.top,
    this.positionOffset,
  });

  @override
  String toString() {
    return 'XliderTooltip(custom: $custom, format: $format, decorations: $decorations, alwaysShowTooltip: $alwaysShowTooltip, disabled: $disabled, disableAnimation: $disableAnimation, direction: $direction, positionOffset: $positionOffset)';
  }

  XliderTooltip copyWith({
    Widget Function(double value)? custom,
    String Function(String value)? format,
    XliderTooltipDecorations? decorations,
    bool? alwaysShowTooltip,
    bool? disabled,
    bool? disableAnimation,
    XliderTooltipDirection? direction,
    XliderTooltipPositionOffset? positionOffset,
  }) {
    return XliderTooltip(
      custom: custom ?? this.custom,
      format: format ?? this.format,
      decorations: decorations ?? this.decorations,
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
        other.decorations == decorations &&
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
        decorations.hashCode ^
        alwaysShowTooltip.hashCode ^
        disabled.hashCode ^
        disableAnimation.hashCode ^
        direction.hashCode ^
        positionOffset.hashCode;
  }
}
