part of xlider;

enum XliderTooltipDirection { top, left, right }

extension Resolve on Axis {
  T resolve<T>({
    required T onHorizontal,
    required T onVertical,
  }) {
    switch (this) {
      case Axis.horizontal:
        return onHorizontal;
      case Axis.vertical:
        return onVertical;
    }
  }
}
