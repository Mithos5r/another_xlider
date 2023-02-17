part of xlider;

mixin XliderHatchMarkHelper<T extends StatefulWidget> on State<T> {
  void drawHatchMark({
    required XliderHatchMark hatchMark,
    required HatchMarkHelperModal helperModal,
  }) {

    if (hatchMark.displayLines!) {
      helperModal.obtainPoints();
    }
    final List<XliderHatchMarkLabel>? labels = hatchMark.labels;
    if (labels != null && labels.isNotEmpty) {
      helperModal.obtainLabelPoints(labels);
    }
  }
}
