part of xlider;

class XliderHandler {
  BoxDecoration? decoration;
  BoxDecoration? foregroundDecoration;
  Matrix4? transform;
  Widget? child;
  bool disabled;
  double opacity;

  XliderHandler({
    this.child,
    this.decoration,
    this.foregroundDecoration,
    this.transform,
    this.disabled = false,
    this.opacity = 1,
  });

  @override
  String toString() {
    return 'XliderHandler(decoration: $decoration, foregroundDecoration: $foregroundDecoration, transform: $transform, child: $child, disabled: $disabled, opacity: $opacity)';
  }

  XliderHandler copyWith({
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
    Matrix4? transform,
    Widget? child,
    bool? disabled,
    double? opacity,
  }) {
    return XliderHandler(
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      transform: transform ?? this.transform,
      child: child ?? this.child,
      disabled: disabled ?? this.disabled,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  bool operator ==(covariant XliderHandler other) {
    if (identical(this, other)) return true;

    return other.decoration == decoration &&
        other.foregroundDecoration == foregroundDecoration &&
        other.transform == transform &&
        other.child == child &&
        other.disabled == disabled &&
        other.opacity == opacity;
  }

  @override
  int get hashCode {
    return decoration.hashCode ^
        foregroundDecoration.hashCode ^
        transform.hashCode ^
        child.hashCode ^
        disabled.hashCode ^
        opacity.hashCode;
  }
}
