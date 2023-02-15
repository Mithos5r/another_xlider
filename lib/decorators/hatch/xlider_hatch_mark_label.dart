part of xlider;

class XliderHatchMarkLabel {
  final double? percent;
  final Widget? label;

  XliderHatchMarkLabel({
    this.percent,
    this.label,
  }) : assert((label == null && percent == null) ||
            (label != null && percent != null && percent >= 0));

  @override
  String toString() => 'XliderHatchMarkLabel(percent: $percent, label: $label)';

  XliderHatchMarkLabel copyWith({
    double? percent,
    Widget? label,
  }) {
    return XliderHatchMarkLabel(
      percent: percent ?? this.percent,
      label: label ?? this.label,
    );
  }

  @override
  bool operator ==(covariant XliderHatchMarkLabel other) {
    if (identical(this, other)) return true;

    return other.percent == percent && other.label == label;
  }

  @override
  int get hashCode => percent.hashCode ^ label.hashCode;
}
