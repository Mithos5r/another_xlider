// ignore_for_file: public_member_api_docs, sort_constructors_first
part of xlider;

class XliderTrackBar {
  final BoxDecoration? inactiveTrackBar;
  final BoxDecoration? activeTrackBar;
  final Color activeDisabledTrackBarColor;
  final Color inactiveDisabledTrackBarColor;
  final double activeTrackBarHeight;
  final double inactiveTrackBarHeight;
  final Widget? centralWidget;
  final bool activeTrackBarDraggable;

  const XliderTrackBar({
    this.inactiveTrackBar,
    this.activeTrackBar,
    this.activeDisabledTrackBarColor = const Color(0xffb5b5b5),
    this.inactiveDisabledTrackBarColor = const Color(0xffe5e5e5),
    this.activeTrackBarHeight = 3.5,
    this.inactiveTrackBarHeight = 3,
    this.centralWidget,
    this.activeTrackBarDraggable = true,
  }) : assert(activeTrackBarHeight > 0 && inactiveTrackBarHeight > 0);

  @override
  String toString() {
    return 'XliderTrackBar(inactiveTrackBar: $inactiveTrackBar, activeTrackBar: $activeTrackBar, activeDisabledTrackBarColor: $activeDisabledTrackBarColor, inactiveDisabledTrackBarColor: $inactiveDisabledTrackBarColor, activeTrackBarHeight: $activeTrackBarHeight, inactiveTrackBarHeight: $inactiveTrackBarHeight, centralWidget: $centralWidget, activeTrackBarDraggable: $activeTrackBarDraggable)';
  }

  XliderTrackBar copyWith({
    BoxDecoration? inactiveTrackBar,
    BoxDecoration? activeTrackBar,
    Color? activeDisabledTrackBarColor,
    Color? inactiveDisabledTrackBarColor,
    double? activeTrackBarHeight,
    double? inactiveTrackBarHeight,
    Widget? centralWidget,
    bool? activeTrackBarDraggable,
  }) {
    return XliderTrackBar(
      inactiveTrackBar: inactiveTrackBar ?? this.inactiveTrackBar,
      activeTrackBar: activeTrackBar ?? this.activeTrackBar,
      activeDisabledTrackBarColor:
          activeDisabledTrackBarColor ?? this.activeDisabledTrackBarColor,
      inactiveDisabledTrackBarColor:
          inactiveDisabledTrackBarColor ?? this.inactiveDisabledTrackBarColor,
      activeTrackBarHeight: activeTrackBarHeight ?? this.activeTrackBarHeight,
      inactiveTrackBarHeight:
          inactiveTrackBarHeight ?? this.inactiveTrackBarHeight,
      centralWidget: centralWidget ?? this.centralWidget,
      activeTrackBarDraggable:
          activeTrackBarDraggable ?? this.activeTrackBarDraggable,
    );
  }

  @override
  bool operator ==(covariant XliderTrackBar other) {
    if (identical(this, other)) return true;

    return other.inactiveTrackBar == inactiveTrackBar &&
        other.activeTrackBar == activeTrackBar &&
        other.activeDisabledTrackBarColor == activeDisabledTrackBarColor &&
        other.inactiveDisabledTrackBarColor == inactiveDisabledTrackBarColor &&
        other.activeTrackBarHeight == activeTrackBarHeight &&
        other.inactiveTrackBarHeight == inactiveTrackBarHeight &&
        other.centralWidget == centralWidget &&
        other.activeTrackBarDraggable == activeTrackBarDraggable;
  }

  @override
  int get hashCode {
    return inactiveTrackBar.hashCode ^
        activeTrackBar.hashCode ^
        activeDisabledTrackBarColor.hashCode ^
        inactiveDisabledTrackBarColor.hashCode ^
        activeTrackBarHeight.hashCode ^
        inactiveTrackBarHeight.hashCode ^
        centralWidget.hashCode ^
        activeTrackBarDraggable.hashCode;
  }
}
