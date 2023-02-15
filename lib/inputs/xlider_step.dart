part of xlider;

class XliderStep {
  final double step;
  final bool isPercentRange;
  final List<XliderRangeStep>? rangeList;

  const XliderStep({
    this.step = 1,
    this.isPercentRange = true,
    this.rangeList,
  });



  @override
  String toString() => 'XliderStep(step: $step, isPercentRange: $isPercentRange, rangeList: $rangeList)';

  @override
  bool operator ==(covariant XliderStep other) {
    if (identical(this, other)) return true;
  
    return 
      other.step == step &&
      other.isPercentRange == isPercentRange &&
      listEquals(other.rangeList, rangeList);
  }

  @override
  int get hashCode => step.hashCode ^ isPercentRange.hashCode ^ rangeList.hashCode;

  XliderStep copyWith({
    double? step,
    bool? isPercentRange,
    List<XliderRangeStep>? rangeList,
  }) {
    return XliderStep(
      step: step ?? this.step,
      isPercentRange: isPercentRange ?? this.isPercentRange,
      rangeList: rangeList ?? this.rangeList,
    );
  }
}

class XliderRangeStep {
  final double? from;
  final double? to;
  final double? step;

  XliderRangeStep({
    this.from,
    this.to,
    this.step,
  }) : assert(from != null && to != null && step != null);



  @override
  String toString() => 'XliderRangeStep(from: $from, to: $to, step: $step)';

  XliderRangeStep copyWith({
    double? from,
    double? to,
    double? step,
  }) {
    return XliderRangeStep(
      from: from ?? this.from,
      to: to ?? this.to,
      step: step ?? this.step,
    );
  }

  @override
  bool operator ==(covariant XliderRangeStep other) {
    if (identical(this, other)) return true;
  
    return 
      other.from == from &&
      other.to == to &&
      other.step == step;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode ^ step.hashCode;
}
