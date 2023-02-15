part of xlider;

class XliderFixedValue {
  final int? percent;
  final dynamic value;

  XliderFixedValue({this.percent, this.value})
      : assert(
            percent != null && value != null && percent >= 0 && percent <= 100);

  @override
  String toString() => 'XliderFixedValue(percent: $percent, value: $value)';

  XliderFixedValue copyWith({
    int? percent,
    dynamic value,
  }) {
    return XliderFixedValue(
      percent: percent ?? this.percent,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(covariant XliderFixedValue other) {
    if (identical(this, other)) return true;

    return other.percent == percent && other.value == value;
  }

  @override
  int get hashCode => percent.hashCode ^ value.hashCode;
}
