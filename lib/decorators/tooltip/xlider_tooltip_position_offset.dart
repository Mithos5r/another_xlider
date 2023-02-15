part of xlider;

class XliderTooltipPositionOffset {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  XliderTooltipPositionOffset({this.top, this.left, this.right, this.bottom});

  XliderTooltipPositionOffset copyWith({
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return XliderTooltipPositionOffset(
      top: top ?? this.top,
      left: left ?? this.left,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  @override
  bool operator ==(covariant XliderTooltipPositionOffset other) {
    if (identical(this, other)) return true;

    return other.top == top &&
        other.left == left &&
        other.right == right &&
        other.bottom == bottom;
  }

  @override
  int get hashCode {
    return top.hashCode ^ left.hashCode ^ right.hashCode ^ bottom.hashCode;
  }

  @override
  String toString() {
    return 'XliderTooltipPositionOffset(top: $top, left: $left, right: $right, bottom: $bottom)';
  }
}
