part of xlider;

class XliderHandlerAnimation {
  final Curve curve;
  final Curve? reverseCurve;
  final Duration duration;
  final double scale;

  const XliderHandlerAnimation({
    this.curve = Curves.elasticOut,
    this.reverseCurve,
    this.duration = const Duration(milliseconds: 700),
    this.scale = 1.3,
  });

  @override
  String toString() {
    return 'XliderHandlerAnimation(curve: $curve, reverseCurve: $reverseCurve, duration: $duration, scale: $scale)';
  }

  XliderHandlerAnimation copyWith({
    Curve? curve,
    Curve? reverseCurve,
    Duration? duration,
    double? scale,
  }) {
    return XliderHandlerAnimation(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      scale: scale ?? this.scale,
    );
  }

  @override
  bool operator ==(covariant XliderHandlerAnimation other) {
    if (identical(this, other)) return true;

    return other.curve == curve &&
        other.reverseCurve == reverseCurve &&
        other.duration == duration &&
        other.scale == scale;
  }

  @override
  int get hashCode {
    return curve.hashCode ^
        reverseCurve.hashCode ^
        duration.hashCode ^
        scale.hashCode;
  }
}
