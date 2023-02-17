part of xlider;

class XliderTooltipBox {
  final BoxDecoration? decoration;
  final BoxDecoration? foregroundDecoration;
  final Matrix4? transform;

  const XliderTooltipBox({
    this.decoration,
    this.foregroundDecoration,
    this.transform,
  });

  XliderTooltipBox copyWith({
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
    Matrix4? transform,
  }) {
    return XliderTooltipBox(
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      transform: transform ?? this.transform,
    );
  }

  @override
  String toString() =>
      'XliderSliderTooltipBox(decoration: $decoration, foregroundDecoration: $foregroundDecoration, transform: $transform)';

  @override
  bool operator ==(covariant XliderTooltipBox other) {
    if (identical(this, other)) return true;

    return other.decoration == decoration &&
        other.foregroundDecoration == foregroundDecoration &&
        other.transform == transform;
  }

  @override
  int get hashCode =>
      decoration.hashCode ^ foregroundDecoration.hashCode ^ transform.hashCode;
}
