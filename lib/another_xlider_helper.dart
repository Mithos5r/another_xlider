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
    required List<double> values,
    required List<XliderFixedValue>? fixedValues,
    required double? widgetMax,
    required double? widgetMin,
  }) {
    // if (widgetMax == null && widgetMin == null) {
    //   throw 'Error interno';
    // }
    if (isRangeSlider && values.length < 2) {
      throw 'when range mode is true, slider needs both lower and upper values';
    }

    if (fixedValues == null) {
      if (values[0] < widgetMin!) {
        throw 'Lower value should be greater than min';
      }

      if (isRangeSlider) {
        if (values[1] > widgetMax!) {
          throw 'Upper value should be smaller than max';
        }
      }
    } else {
      if (!(values[0] >= 0 && values[0] <= 100)) {
        throw 'When using fixedValues, you should set values within the range of fixedValues';
      }

      if (isRangeSlider && values.length > 1) {
        if (!(values[1] >= 0 && values[1] <= 100)) {
          throw 'When using fixedValues, you should set values within the range of fixedValues';
        }
      }
    }

    if (isRangeSlider == true) {
      if (values[0] > values[1]) {
        throw 'Lower value must be smaller than upper value';
      }
    }
  }
}
