part of xlider;

class XliderTrackBarConfiguration {
  final Widget? centralWidget;
  final bool activeTrackBarDraggable;

  final XliderTrackBar inactiveTrackBar;
  final XliderTrackBar activeTrackbar;

  const XliderTrackBarConfiguration({
    this.inactiveTrackBar = const XliderTrackBar(
      thickness: 3,
      color: Color(0xffe5e5e5),
    ),
    this.activeTrackbar = const XliderTrackBar(
      thickness: 3.5,
      color: Color.fromARGB(255, 58, 137, 234),
    ),
    this.centralWidget,
    this.activeTrackBarDraggable = true,
  });

  @override
  String toString() {
    return 'XliderTrackBarConfiguration(centralWidget: $centralWidget, activeTrackBarDraggable: $activeTrackBarDraggable, inactiveTrackBar: $inactiveTrackBar, activeTrackbar: $activeTrackbar)';
  }

  XliderTrackBarConfiguration copyWith({
    Widget? centralWidget,
    bool? activeTrackBarDraggable,
    XliderTrackBar? inactiveTrackBar,
    XliderTrackBar? activeTrackbar,
  }) {
    return XliderTrackBarConfiguration(
      centralWidget: centralWidget ?? this.centralWidget,
      activeTrackBarDraggable:
          activeTrackBarDraggable ?? this.activeTrackBarDraggable,
      inactiveTrackBar: inactiveTrackBar ?? this.inactiveTrackBar,
      activeTrackbar: activeTrackbar ?? this.activeTrackbar,
    );
  }

  @override
  bool operator ==(covariant XliderTrackBarConfiguration other) {
    if (identical(this, other)) return true;

    return other.centralWidget == centralWidget &&
        other.activeTrackBarDraggable == activeTrackBarDraggable &&
        other.inactiveTrackBar == inactiveTrackBar &&
        other.activeTrackbar == activeTrackbar;
  }

  @override
  int get hashCode {
    return centralWidget.hashCode ^
        activeTrackBarDraggable.hashCode ^
        inactiveTrackBar.hashCode ^
        activeTrackbar.hashCode;
  }
}
