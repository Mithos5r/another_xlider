part of xlider;

class XliderDecorations {
  final BoxDecoration? backgroundDecoration;
  final BoxDecoration? foregroundDecoration;

 const XliderDecorations({
    this.backgroundDecoration,
    this.foregroundDecoration,
  });

  XliderDecorations copyWith({
    BoxDecoration? backgroundDecoration,
    BoxDecoration? foregroundDecoration,
  }) {
    return XliderDecorations(
      backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
    );
  }

  @override
  String toString() =>
      'XliderDecorations(backgroundDecoration: $backgroundDecoration, foregroundDecoration: $foregroundDecoration)';

  @override
  bool operator ==(covariant XliderDecorations other) {
    if (identical(this, other)) return true;

    return other.backgroundDecoration == backgroundDecoration &&
        other.foregroundDecoration == foregroundDecoration;
  }

  @override
  int get hashCode =>
      backgroundDecoration.hashCode ^ foregroundDecoration.hashCode;
}
