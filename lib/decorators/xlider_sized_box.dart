part of xlider;

class XliderSizedBox {
  final BoxDecoration? decoration;
  final BoxDecoration? foregroundDecoration;
  final Matrix4? transform;
  final double width;
  final double height;

  const XliderSizedBox(
      {this.decoration,
      this.foregroundDecoration,
      this.transform,
      required this.height,
      required this.width})
      : assert(width > 0 && height > 0);

  @override
  String toString() {
    return 'XliderSizedBox(decoration: $decoration, foregroundDecoration: $foregroundDecoration, transform: $transform, width: $width, height: $height)';
  }

  XliderSizedBox copyWith({
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
    Matrix4? transform,
    double? width,
    double? height,
  }) {
    return XliderSizedBox(
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      transform: transform ?? this.transform,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  bool operator ==(covariant XliderSizedBox other) {
    if (identical(this, other)) return true;

    return other.decoration == decoration &&
        other.foregroundDecoration == foregroundDecoration &&
        other.transform == transform &&
        other.width == width &&
        other.height == height;
  }

  @override
  int get hashCode {
    return decoration.hashCode ^
        foregroundDecoration.hashCode ^
        transform.hashCode ^
        width.hashCode ^
        height.hashCode;
  }
}
