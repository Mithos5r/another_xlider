part of xlider;

mixin XliderFunction<T extends StatefulWidget> on State<T> {
  ///Help to find the Size horizontal or vertical from activeTrackBartHeight
  /// and inactiveTrackBarHeigh
  double findProperSliderSize({
    required double activeTrackBarHeight,
    required double inactiveTrackBarHeight,
    required double? handlersHeight,
    required double? handlersWidth,
  }) {
    final List<double> sizes = [activeTrackBarHeight, inactiveTrackBarHeight];
    if (handlersHeight != null) {
      sizes.add(handlersHeight);
    }

    return sizes.reduce((value, element) => max(value, element));
  }

  void validations({
    required bool isRangeSlider,
    required XliderRangeValues values,
    required List<XliderFixedValue>? fixedValues,
    required double? widgetMax,
    required double? widgetMin,
  }) {
    final double valueMin = (values.min ?? 0);
    final double valueMax = (values.max ?? 0);

    if (fixedValues == null) {
      if (valueMin < widgetMin!) {
        throw 'Lower value should be greater than min';
      }

      if (isRangeSlider) {
        if ((values.max ?? 0) > widgetMax!) {
          throw 'Upper value should be smaller than max';
        }
      }
    } else {
      if (!(valueMax >= 0 && valueMin <= 100)) {
        throw 'When using fixedValues, you should set values within the range of fixedValues';
      }
    }
  }
}
