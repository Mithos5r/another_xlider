part of xlider;

class XliderValues {
  final XliderRangeValues? range;
  final XliderRangeValues? values;
  final XliderRangeValues? distances;
  final List<XliderFixedValue>? fixedValues;

  XliderValues({
    this.range,
    this.values,
    this.fixedValues,
    this.distances,
  }) : assert(
            fixedValues != null ||
                (range?.max != null && (range?.min ?? 0) <= range!.max!),
            "Min and Max are required if fixedValues is null");

  @override
  String toString() {
    return 'XliderValues(range: $range, values: $values, distances: $distances, fixedValues: $fixedValues)';
  }

  XliderValues copyWith({
    XliderRangeValues? range,
    XliderRangeValues? values,
    XliderRangeValues? distances,
    List<XliderFixedValue>? fixedValues,
  }) {
    return XliderValues(
      range: range ?? this.range,
      values: values ?? this.values,
      distances: distances ?? this.distances,
      fixedValues: fixedValues ?? this.fixedValues,
    );
  }

  @override
  bool operator ==(covariant XliderValues other) {
    if (identical(this, other)) return true;

    return other.range == range &&
        other.values == values &&
        other.distances == distances &&
        listEquals(other.fixedValues, fixedValues);
  }

  @override
  int get hashCode {
    return range.hashCode ^
        values.hashCode ^
        distances.hashCode ^
        fixedValues.hashCode;
  }
}
