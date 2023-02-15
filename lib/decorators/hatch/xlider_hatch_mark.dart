part of xlider;

class XliderHatchMark {
  final bool disabled;
  final double density;
  final double? linesDistanceFromTrackBar;
  final double? labelsDistanceFromTrackBar;
  final List<XliderHatchMarkLabel>? labels;
  final XliderSizedBox? smallLine;
  final XliderSizedBox? bigLine;

  /// How many small lines to display between two big lines
  final int smallDensity;
  final XliderSizedBox? labelBox;
  final XliderHatchMarkAlignment linesAlignment;
  final bool? displayLines;

  XliderHatchMark(
      {this.disabled = false,
      this.density = 1,
      this.smallDensity = 4,
      this.linesDistanceFromTrackBar,
      this.labelsDistanceFromTrackBar,
      this.labels,
      this.smallLine,
      this.bigLine,
      this.linesAlignment = XliderHatchMarkAlignment.right,
      this.labelBox,
      this.displayLines})
      : assert(density > 0 && density <= 2),
        assert(smallDensity >= 0);

  @override
  String toString() {
    return 'XliderHatchMark(disabled: $disabled, density: $density, linesDistanceFromTrackBar: $linesDistanceFromTrackBar, labelsDistanceFromTrackBar: $labelsDistanceFromTrackBar, labels: $labels, smallLine: $smallLine, bigLine: $bigLine, smallDensity: $smallDensity, labelBox: $labelBox, displayLines: $displayLines)';
  }

  XliderHatchMark defaults({
    XliderSizedBox? smallLine,
    XliderSizedBox? bigLine,
    double? linesDistanceFromTrackBar,
    double? labelsDistanceFromTrackBar,
    XliderSizedBox? labelBox,
    bool? displayLines
  }) =>
      XliderHatchMark(
        smallLine: smallLine ??
            const XliderSizedBox(
              height: 5,
              width: 1,
              decoration: BoxDecoration(color: Colors.black45),
            ),
        linesDistanceFromTrackBar: linesDistanceFromTrackBar ?? 0,
        labelsDistanceFromTrackBar: labelsDistanceFromTrackBar ?? 0,
        bigLine: bigLine ??
            const XliderSizedBox(
              height: 9,
              width: 2,
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
            ),
        labelBox: labelBox ?? const XliderSizedBox(height: 50, width: 50),
        displayLines: displayLines ?? false,
      );

  XliderHatchMark copyWith({
    bool? disabled,
    double? density,
    double? linesDistanceFromTrackBar,
    double? labelsDistanceFromTrackBar,
    List<XliderHatchMarkLabel>? labels,
    XliderSizedBox? smallLine,
    XliderSizedBox? bigLine,
    int? smallDensity,
    XliderSizedBox? labelBox,
    bool? displayLines,
  }) {
    return XliderHatchMark(
      disabled: disabled ?? this.disabled,
      density: density ?? this.density,
      linesDistanceFromTrackBar:
          linesDistanceFromTrackBar ?? this.linesDistanceFromTrackBar,
      labelsDistanceFromTrackBar:
          labelsDistanceFromTrackBar ?? this.labelsDistanceFromTrackBar,
      labels: labels ?? this.labels,
      smallLine: smallLine ?? this.smallLine,
      bigLine: bigLine ?? this.bigLine,
      smallDensity: smallDensity ?? this.smallDensity,
      labelBox: labelBox ?? this.labelBox,
      displayLines: displayLines ?? this.displayLines,
    );
  }

  @override
  bool operator ==(covariant XliderHatchMark other) {
    if (identical(this, other)) return true;

    return other.disabled == disabled &&
        other.density == density &&
        other.linesDistanceFromTrackBar == linesDistanceFromTrackBar &&
        other.labelsDistanceFromTrackBar == labelsDistanceFromTrackBar &&
        listEquals(other.labels, labels) &&
        other.smallLine == smallLine &&
        other.bigLine == bigLine &&
        other.smallDensity == smallDensity &&
        other.labelBox == labelBox &&
        other.displayLines == displayLines;
  }

  @override
  int get hashCode {
    return disabled.hashCode ^
        density.hashCode ^
        linesDistanceFromTrackBar.hashCode ^
        labelsDistanceFromTrackBar.hashCode ^
        labels.hashCode ^
        smallLine.hashCode ^
        bigLine.hashCode ^
        smallDensity.hashCode ^
        labelBox.hashCode ^
        displayLines.hashCode;
  }
}
