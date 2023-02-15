part of xlider;

class XliderIgnoreSteps {
  final double? from;
  final double? to;

  XliderIgnoreSteps({this.from, this.to})
      : assert(from != null && to != null && from <= to);

  @override
  String toString() => 'XliderIgnoreSteps(from: $from, to: $to)';

  XliderIgnoreSteps copyWith({
    double? from,
    double? to,
  }) {
    return XliderIgnoreSteps(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  bool operator ==(covariant XliderIgnoreSteps other) {
    if (identical(this, other)) return true;

    return other.from == from && other.to == to;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
