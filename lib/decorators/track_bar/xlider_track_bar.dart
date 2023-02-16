part of xlider;

const Color test = Colors.transparent;

class XliderTrackBar {
  final double thickness;
  final Color color;
  final BoxDecoration? decoration;

  const XliderTrackBar({
    required this.thickness,
    required this.color,
    this.decoration,
  }) : assert(thickness > 1, 'Must be ticker than 1');

  @override
  String toString() =>
      'XliderTrackBar(height: $thickness, color: $color, activeTrackBar: $decoration)';

  XliderTrackBar copyWith({
    double? height,
    Color? color,
    BoxDecoration? activeTrackBar,
  }) {
    return XliderTrackBar(
      thickness: height ?? this.thickness,
      color: color ?? this.color,
      decoration: activeTrackBar ?? decoration,
    );
  }

  @override
  bool operator ==(covariant XliderTrackBar other) {
    if (identical(this, other)) return true;

    return other.thickness == thickness &&
        other.color == color &&
        other.decoration == decoration;
  }

  @override
  int get hashCode => thickness.hashCode ^ color.hashCode ^ decoration.hashCode;
}
