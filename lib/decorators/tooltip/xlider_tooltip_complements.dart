part of xlider;

class XliderTooltipComplements {
  final Widget? prefix;
  final Widget? suffix;

  const XliderTooltipComplements({this.prefix, this.suffix});

  @override
  String toString() =>
      'XliderTooltipDecorations(prefix: $prefix, suffix: $suffix)';

  XliderTooltipComplements copyWith({
    Widget? prefix,
    Widget? suffix,
  }) {
    return XliderTooltipComplements(
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
    );
  }

  @override
  bool operator ==(covariant XliderTooltipComplements other) {
    if (identical(this, other)) return true;

    return other.prefix == prefix && other.suffix == suffix;
  }

  @override
  int get hashCode => prefix.hashCode ^ suffix.hashCode;
}
