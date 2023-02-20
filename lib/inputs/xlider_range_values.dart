part of xlider;

class XliderRangeValues {
  final double? min;
  final double? max;

  const XliderRangeValues({this.min, this.max})
      : assert(!(max != null && !((min ?? 0) <= (max))));

  bool get isComplete => (min != null && max != null);
  bool get isEmtpy => (min != null && max != null);

  @override
  String toString() => 'XliderRangeValues(min: $min, max: $max)';

  XliderRangeValues copyWith({
    double? min,
    double? max,
  }) {
    return XliderRangeValues(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  @override
  bool operator ==(covariant XliderRangeValues other) {
    if (identical(this, other)) return true;

    return other.min == min && other.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;
}
