part of xlider;

class XliderRangeValues {
  final double? min;
  final double? max;

  const XliderRangeValues({this.min, this.max})
      : assert(!(max != null && !((min ?? 0) <= (max))));

  bool get isComplete => (min != null && max != null);
  bool get isEmtpy => (min != null && max != null);
}
