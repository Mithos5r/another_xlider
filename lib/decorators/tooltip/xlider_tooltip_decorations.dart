part of xlider;

class XliderTooltipDecorations {
  final TextStyle? textStyle;
  final XliderTooltipBox? boxStyle;
  final XliderTooltipComplements leftComplements;
  final XliderTooltipComplements rightComplements;

  const XliderTooltipDecorations({
    this.textStyle,
    this.boxStyle,
    this.leftComplements = const XliderTooltipComplements(),
    this.rightComplements = const XliderTooltipComplements(),
  });

  @override
  String toString() {
    return 'XliderTooltipDecorations(textStyle: $textStyle, boxStyle: $boxStyle, leftDecoration: $leftComplements, rightDecoration: $rightComplements)';
  }

  XliderTooltipDecorations copyWith({
    TextStyle? textStyle,
    XliderTooltipBox? boxStyle,
    XliderTooltipComplements? leftDecoration,
    XliderTooltipComplements? rightDecoration,
  }) {
    return XliderTooltipDecorations(
      textStyle: textStyle ?? this.textStyle,
      boxStyle: boxStyle ?? this.boxStyle,
      leftComplements: leftDecoration ?? leftComplements,
      rightComplements: rightDecoration ?? rightComplements,
    );
  }

  @override
  bool operator ==(covariant XliderTooltipDecorations other) {
    if (identical(this, other)) return true;

    return other.textStyle == textStyle &&
        other.boxStyle == boxStyle &&
        other.leftComplements == leftComplements &&
        other.rightComplements == rightComplements;
  }

  @override
  int get hashCode {
    return textStyle.hashCode ^
        boxStyle.hashCode ^
        leftComplements.hashCode ^
        rightComplements.hashCode;
  }
}
