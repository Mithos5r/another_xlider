part of xlider;

class XliderTooltipPositionOffset {
  final double? top;
  final double? left;
  final double? right;

  XliderTooltipPositionOffset({this.top, this.left, this.right});

  XliderTooltipPositionOffset copyWith({
    double? top,
    double? left,
    double? right,
  }) {
    return XliderTooltipPositionOffset(
      top: top ?? this.top,
      left: left ?? this.left,
      right: right ?? this.right,
    );
  }

  @override
  bool operator ==(covariant XliderTooltipPositionOffset other) {
    if (identical(this, other)) return true;

    return other.top == top && other.left == left && other.right == right;
  }

  @override
  int get hashCode {
    return top.hashCode ^ left.hashCode ^ right.hashCode;
  }

  @override
  String toString() {
    return 'XliderTooltipPositionOffset(top: $top, left: $left, right: $right,)';
  }
}
