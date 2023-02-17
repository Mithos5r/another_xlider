/// A material design slider and range slider with horizontal and vertical axis, rtl support and lots of options and customizations for flutter
library xlider;

import 'dart:math';

import 'package:another_xlider/models/hatch_mark_helper_modal.dart';
import 'package:another_xlider/widgets/active_track.dart';
import 'package:another_xlider/widgets/inactive_track.dart';
import 'package:another_xlider/widgets/tooltip.dart';
import 'package:another_xlider/xlider_drag_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, Icons;
import 'package:flutter/widgets.dart';

import 'models/container_helper_model.dart';
import 'models/handler_helper_model.dart';
import 'models/tooltip_helper_model.dart';

part 'another_xlider_hatch_mark_helper.dart';
part 'another_xlider_helper.dart';
part 'decorators/hatch/xlider_hatch_mark.dart';
part 'decorators/hatch/xlider_hatch_mark_aligment.dart';
part 'decorators/hatch/xlider_hatch_mark_label.dart';
part 'decorators/tooltip/xlider_tooltip.dart';
part 'decorators/tooltip/xlider_tooltip_box.dart';
part 'decorators/tooltip/xlider_tooltip_complements.dart';
part 'decorators/tooltip/xlider_tooltip_decorations.dart';
part 'decorators/tooltip/xlider_tooltip_position_offset.dart';
part 'decorators/track_bar/xlider_track_bar.dart';
part 'decorators/track_bar/xlider_track_bar_configuration.dart';
part 'decorators/xlider_decorations.dart';
part 'decorators/xlider_fixed_value.dart';
part 'decorators/xlider_ignore_steps.dart';
part 'decorators/xlider_sized_box.dart';
part 'handler/xlider_handler_animation.dart';
part 'inputs/xlider_handler.dart';
part 'inputs/xlider_handler_configuration.dart';
// inputs
part 'inputs/xlider_range_values.dart';
part 'inputs/xlider_step.dart';
part 'inputs/xlider_values.dart';
part 'xlider_side.dart';
part 'xlider_tooltip_direction.dart';

/*
* *
* * Written by Ali Azmoude <ali.azmoude@gmail.com>
* *
* *
* *
* * When I wrote this, only God and I understood what I was doing.
* * Now, God only knows "Karl Weierstrass"
* */

class Xlider extends StatefulWidget {
  ///Initial values for slider.
  ///
  ///If [xliderValues.values] has max and min then will be a range slider.
  final XliderValues? xliderValues;

  ///Configurator of handler information. Give you the change of
  ///lock, set height and width, and set all the params correctly of the handler
  final XliderHandlerConfiguration xliderHandlerConfiguration;

  ///Callback when drag started
  final Function(XliderSide handlerIndex, double lowerValue, double upperValue)?
      onDragStarted;

  ///Callback when user drop handler focus
  final Function(XliderSide handlerIndex, double lowerValue, double upperValue)?
      onDragCompleted;

  ///Callback action when user is dragging
  final Function(XliderSide handlerIndex, double lowerValue, double upperValue)?
      onDragging;

  ///It's will be false if [xliderValues.values] is not complete
  final bool rangeSlider;

  ///Change slider direction
  final XliderSide sliderDirection;

  ///It's will be true if [sliderDirection.right]
  final bool startAtRight;
  final bool jump;

  ///If true it's possible to tap in the slider and set the values. If it's false
  ///trackbar slider it's possible.
  final bool selectByTap;
  final List<XliderIgnoreSteps> ignoreSteps;

  ///Disable slider.
  ///
  ///If it's [disabled] slider doesn't work. Slider Color will be change
  final bool disabled;
  final double touchSize;

  ///Show the touchable area of the handlers
  final bool visibleTouchArea;

  final XliderTooltip? tooltip;
  final XliderTrackBarConfiguration trackBar;
  final XliderStep step;
  final XliderHatchMark? hatchMark;
  final bool centeredOrigin;

  final XliderDecorations decorations;

  Xlider({
    Key? key,
    this.xliderValues,
    this.xliderHandlerConfiguration = const XliderHandlerConfiguration(),
    this.onDragStarted,
    this.onDragCompleted,
    this.onDragging,
    this.sliderDirection = XliderSide.left,
    this.jump = false,
    this.ignoreSteps = const [],
    this.disabled = false,
    this.touchSize = 15,
    this.visibleTouchArea = false,
    this.tooltip,
    this.trackBar = const XliderTrackBarConfiguration(),
    this.selectByTap = true,
    this.step = const XliderStep(),
    this.hatchMark,
    this.centeredOrigin = false,
    this.decorations = const XliderDecorations(),
  })  : rangeSlider = xliderValues?.values?.isComplete ?? false,
        startAtRight = sliderDirection == XliderSide.right,
        assert((touchSize >= 5 && touchSize <= 50)),
        assert((ignoreSteps.isNotEmpty && step.rangeList == null) ||
            (ignoreSteps.isEmpty)),
        assert((step.rangeList != null &&
                xliderValues?.distances?.min == 0 &&
                xliderValues?.distances?.max == 0) ||
            ((xliderValues?.distances?.min ?? 0) > 0 &&
                step.rangeList == null) ||
            ((xliderValues?.distances?.max ?? 0) > 0 &&
                step.rangeList == null) ||
            (step.rangeList == null)),
        assert(centeredOrigin == false ||
            (centeredOrigin == true &&
                !(xliderValues?.values?.isComplete ?? false) &&
                xliderHandlerConfiguration.lock == false &&
                (xliderValues?.distances?.min ?? 0) == 0 &&
                (xliderValues?.distances?.max ?? 0) == 0)),
        assert(!xliderHandlerConfiguration.lock ||
            (!centeredOrigin &&
                (ignoreSteps.isEmpty) &&
                (xliderValues?.fixedValues == null ||
                    (xliderValues?.fixedValues?.isEmpty ?? false)) &&
                (xliderValues?.values?.isComplete ?? false) &&
                (xliderValues?.values?.isComplete ?? false) &&
                xliderHandlerConfiguration.lock &&
                step.rangeList == null)),
        assert(
            (xliderValues?.values?.isComplete ?? false) == false ||
                ((xliderValues?.values?.isComplete ?? false) == true &&
                    (xliderValues?.values?.isComplete ?? false)),
            "Range slider needs two values"),
        super(key: key);

  @override
  XliderState createState() => XliderState();
}

class XliderState extends State<Xlider>
    with TickerProviderStateMixin, XliderFunction, XliderHatchMarkHelper {
  bool _isInitCall = true;

  double _lowerValue = 0;
  double _upperValue = 0;
  double _outputLowerValue = 0;
  double _outputUpperValue = 0;

  double _realMin = 0;
  double _realMax = 0;

  late double _divisions;

  GlobalKey leftHandlerKey = GlobalKey();
  GlobalKey rightHandlerKey = GlobalKey();
  GlobalKey containerKey = GlobalKey();
  GlobalKey leftTooltipKey = GlobalKey();
  GlobalKey rightTooltipKey = GlobalKey();

  late List<Function> _positionedItems;

  int _decimalScale = 0;

  double xDragTmp = 0;
  double yDragTmp = 0;

  double? _widgetStep;
  double? _widgetMin;
  double? _widgetMax;
  List<XliderIgnoreSteps> _ignoreSteps = [];
  final List<XliderFixedValue> _fixedValues = [];

  final List<Positioned> _points = [];

  bool __dragging = false;

  double? __dAxis,
      __rAxis,
      __axisDragTmp,
      __axisPosTmp,
      __rightHandlerPosition,
      __leftHandlerPosition,
      __containerSizeWithoutHalfPadding;

  Orientation? oldOrientation;

  double __lockedHandlersDragOffset = 0;
  double? _distanceFromRightHandler, _distanceFromLeftHandler;
  double _handlersDistance = 0;

  bool _slidingByActiveTrackBar = false;
  bool _leftTapAndSlide = false;
  bool _rightTapAndSlide = false;
  bool _trackBarSlideOnDragStartedCalled = false;

  //! Nuevos
  ContainerHelperModel _containerHelperModel = const ContainerHelperModel();
  HandlerHelperModel _handlerHelperModel = const HandlerHelperModel();
  TooltipHelperModel _tooltipHelperModel = const TooltipHelperModel();

  @override
  void initState() {
    initMethod();

    super.initState();
  }

  @override
  void didUpdateWidget(Xlider oldWidget) {
    _isInitCall = false;

    initMethod();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tooltipHelperModel.dispose();
    _handlerHelperModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          oldOrientation ??= MediaQuery.of(context).orientation;
          final double sliderProperSize = findProperSliderSize(
            activeTrackBarHeight: widget.trackBar.activeTrackbar.thickness,
            inactiveTrackBarHeight: widget.trackBar.inactiveTrackBar.thickness,
            handlersHeight: _handlerHelperModel.handlersHeight,
            handlersWidth: _handlerHelperModel.handlersWidth,
          );
          _containerHelperModel =
              _containerHelperModel.setConstraintsAndContainer(
            constraintWidth: constraints.maxWidth,
            constraintHeight: constraints.maxHeight,
            handlersHeight: _handlerHelperModel.handlersHeight,
            handlersWidth: _handlerHelperModel.handlersWidth,
            sliderProperSize: sliderProperSize,
          );

          if (MediaQuery.of(context).orientation != oldOrientation) {
            _handlerHelperModel = _handlerHelperModel.resetHandlerPositions();

            _containerHelperModel =
                _containerHelperModel.renderBoxInitialization(
              screenSize: MediaQuery.of(context).size,
              containerKey: containerKey,
            );

            _handlerHelperModel = _handlerHelperModel.arrangeHandlersPosition(
              dragging: __dragging,
              lowerPositionByValue: getPositionByValue(_lowerValue),
              upperPositionByValue: getPositionByValue(_upperValue),
            );

            _drawHatchMark();

            oldOrientation = MediaQuery.of(context).orientation;
          }

          return ClipRRect(
            clipBehavior: Clip.none,
            child: Container(
              key: containerKey,
              height: _containerHelperModel.containerHeight,
              width: _containerHelperModel.containerWidth,
              foregroundDecoration: widget.decorations.foregroundDecoration,
              decoration: widget.decorations.backgroundDecoration,
              child: Stack(
                clipBehavior: Clip.none,
                children: drawHandlers(),
              ),
            ),
          );
        });
      },
    );
  }

  void _drawHatchMark() {
    final XliderHatchMark? hatchMark = widget.hatchMark;
    if (!(hatchMark == null || hatchMark.disabled)) {
      final XliderHatchMark defaultHatchMark = hatchMark.defaults(
        smallLine: hatchMark.smallLine,
        linesDistanceFromTrackBar: hatchMark.linesDistanceFromTrackBar,
        labelsDistanceFromTrackBar: hatchMark.labelsDistanceFromTrackBar,
        bigLine: hatchMark.bigLine,
        labelBox: hatchMark.labelBox,
        displayLines: hatchMark.displayLines,
      );
      drawHatchMark(
        hatchMark: defaultHatchMark,
        helperModal: HatchMarkHelperModal(
          handlersWidth: _handlerHelperModel.handlersWidth,
          handlersHeight: _handlerHelperModel.handlersHeight,
          constraintMaxWidth: _containerHelperModel.constraintMaxWidth,
          constraintMaxHeight: _containerHelperModel.constraintMaxHeight,
          hatchMark: defaultHatchMark,
          percentaje: 100 * defaultHatchMark.density,
          handlersPadding: _handlerHelperModel.handlersPadding,
          containerHeight: _containerHelperModel.containerHeight,
          getPositioned: _points.add,
          containerWidth: _containerHelperModel.containerWidth,
          maxTrackBarHeight: ([
            widget.trackBar.inactiveTrackBar.thickness,
            widget.trackBar.activeTrackbar.thickness
          ].reduce(max)),
          rtl: widget.startAtRight,
          containerWidthWithoutPadding:
              _containerHelperModel.containerWidthWithoutPadding ?? 0,
          containerHeightWithoutPadding:
              _containerHelperModel.containerHeightWithoutPadding ?? 0,
        ),
      );
    }
  }

  void initMethod() {
    _widgetMax = widget.xliderValues?.range?.max;
    _widgetMin = widget.xliderValues?.range?.min;

    // validate inputs
    validations(
        isRangeSlider: widget.rangeSlider,
        values: widget.xliderValues?.values ?? const XliderRangeValues(),
        fixedValues: widget.xliderValues?.fixedValues,
        widgetMax: _widgetMax,
        widgetMin: _widgetMin);

    _handlerHelperModel = _handlerHelperModel.setAnimations(
      isInitialCall: _isInitCall,
      animationProvider: this,
      xliderHandlerAnimation:
          widget.xliderHandlerConfiguration.handlerAnimation,
    );

    _setParameters();
    _setValues();

    if (widget.rangeSlider == true &&
        (widget.xliderValues?.distances?.max ?? 0) > 0 &&
        (_upperValue - _lowerValue) >
            (widget.xliderValues?.distances?.max ?? 0)) {
      throw 'lower and upper distance is more than maximum distance';
    }
    if (widget.rangeSlider == true &&
        (widget.xliderValues?.distances?.min ?? 0) > 0 &&
        (_upperValue - _lowerValue) <
            (widget.xliderValues?.distances?.min ?? 0)) {
      throw 'lower and upper distance is less than minimum distance';
    }

    Offset animationStart = const Offset(0, 0);
    if (widget.tooltip?.disableAnimation == true) {
      animationStart = const Offset(0, -1);
    }

    Offset? animationFinish;
    switch (_tooltipHelperModel.tooltipData.direction) {
      case XliderTooltipDirection.top:
        animationFinish = const Offset(0, -1);
        break;
      case XliderTooltipDirection.left:
        animationFinish = const Offset(-1, 0);
        break;
      case XliderTooltipDirection.right:
        animationFinish = const Offset(1, 0);
        break;
      default:
        animationFinish = Offset.zero;
        break;
    }

    _tooltipHelperModel = _tooltipHelperModel.animationInstance(
        isInitCall: _isInitCall,
        tickerProvider: this,
        animationStart: animationStart,
        animationFinish: animationFinish);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _containerHelperModel = _containerHelperModel.renderBoxInitialization(
        screenSize: MediaQuery.of(context).size,
        containerKey: containerKey,
      );

      _handlerHelperModel = _handlerHelperModel.arrangeHandlersPosition(
        dragging: __dragging,
        lowerPositionByValue: getPositionByValue(_lowerValue),
        upperPositionByValue: getPositionByValue(_upperValue),
      );

      _drawHatchMark();

      setState(() {});
    });
  }

  void _setParameters() {
    _realMin = 0;
    _widgetMax = widget.xliderValues?.range?.max;
    _widgetMin = widget.xliderValues?.range?.min;

    _tooltipHelperModel =
        _tooltipHelperModel.copyWith(tooltipData: widget.tooltip);

    _ignoreSteps = [];

    if (widget.xliderValues?.fixedValues != null &&
        widget.xliderValues!.fixedValues!.isNotEmpty) {
      _realMax = 100;
      _realMin = 0;
      _widgetStep = 1;
      _widgetMax = 100;
      _widgetMin = 0;

      List<double> fixedValuesIndices = [];
      for (XliderFixedValue fixedValue in widget.xliderValues!.fixedValues!) {
        fixedValuesIndices.add(fixedValue.percent!.toDouble());
      }

      double lowerIgnoreBound = -1;
      double upperIgnoreBound;
      List<double> fixedV = [];
      for (double fixedPercent = 0; fixedPercent <= 100; fixedPercent++) {
        dynamic fValue = '';
        for (XliderFixedValue fixedValue in widget.xliderValues!.fixedValues!) {
          if (fixedValue.percent == fixedPercent.toInt()) {
            fixedValuesIndices.add(fixedValue.percent!.toDouble());
            fValue = fixedValue.value;

            upperIgnoreBound = fixedPercent;
            if (fixedPercent > lowerIgnoreBound + 1 || lowerIgnoreBound == 0) {
              if (lowerIgnoreBound > 0) lowerIgnoreBound += 1;
              upperIgnoreBound = fixedPercent - 1;
              _ignoreSteps.add(XliderIgnoreSteps(
                  from: lowerIgnoreBound, to: upperIgnoreBound));
            }
            lowerIgnoreBound = fixedPercent;
            break;
          }
        }
        _fixedValues.add(
            XliderFixedValue(percent: fixedPercent.toInt(), value: fValue));
        if (fValue.toString().isNotEmpty) {
          fixedV.add(fixedPercent);
        }
      }

      double? biggestPoint =
          _findBiggestIgnorePoint(ignoreBeyondBoundaries: true);
      if (!fixedV.contains(100)) {
        _ignoreSteps.add(XliderIgnoreSteps(from: biggestPoint + 1, to: 101));
      }
    } else {
      _realMax = _widgetMax! - _widgetMin!;
      _widgetStep = widget.step.step;
    }

    _ignoreSteps.addAll(widget.ignoreSteps);

    _handlerHelperModel = _handlerHelperModel.copyWith(
      handlersHeight: widget.xliderHandlerConfiguration.height,
      handlersWidth: widget.xliderHandlerConfiguration.width,
    );

    _setDivisionAndDecimalScale();

    _positionedItems = [
      _leftHandlerWidget,
      _rightHandlerWidget,
    ];

    _arrangeHandlersZIndex();

    _handlerHelperModel = _handlerHelperModel.generateHandler(
      rightHandler: widget.xliderHandlerConfiguration.rightHandler,
      isRangeSlider: widget.rangeSlider,
      rightHandlerKey: rightHandlerKey,
      leftHandlerKey: leftHandlerKey,
      visibleTouchArea: widget.visibleTouchArea,
      handler: widget.xliderHandlerConfiguration.leftHandler,
      touchSize: widget.touchSize,
      rtl: widget.startAtRight,
    );

    _handlersDistance = _upperValue - _lowerValue;
  }

  void _setDivisionAndDecimalScale() {
    _divisions = _realMax / _widgetStep!;
    String tmpDecimalScale = '0';
    List<String> tmpDecimalScaleArr = _widgetStep.toString().split(".");
    if (tmpDecimalScaleArr.length > 1) tmpDecimalScale = tmpDecimalScaleArr[1];
    if (int.parse(tmpDecimalScale) > 0) {
      _decimalScale = tmpDecimalScale.length;
    }
  }

  List<double?> _calculateUpperAndLowerValues() {
    double? localLV, localUV;
    localLV = widget.xliderValues?.values?.min;
    if (widget.rangeSlider) {
      localUV = widget.xliderValues?.values?.max;
    } else {
      // when direction is rtl, then we use left handler. so to make right hand side
      // as blue ( as if selected ), then upper value should be max
      if (widget.startAtRight) {
        localUV = _widgetMax;
      } else {
        // when direction is ltr, so we use right handler, to make left hand side of handler
        // as blue ( as if selected ), we set lower value to min, and upper value to (input lower value)
        localUV = localLV;
        localLV = _widgetMin;
      }
    }

    return [localLV, localUV];
  }

  void _setValues() {
    List<double?> localValues = _calculateUpperAndLowerValues();

    _lowerValue = localValues[0]! - _widgetMin!;
    _upperValue = localValues[1]! - _widgetMin!;

    _outputUpperValue = _displayRealValue(_upperValue);
    _outputLowerValue = _displayRealValue(_lowerValue);

    if (widget.startAtRight) {
      _outputLowerValue = _displayRealValue(_upperValue);
      _outputUpperValue = _displayRealValue(_lowerValue);

      double tmpUpperValue = _realMax - _lowerValue;
      double tmpLowerValue = _realMax - _upperValue;

      _lowerValue = tmpLowerValue;
      _upperValue = tmpUpperValue;
    }
  }

  double getPositionByValue(double value) {
    return (((_containerHelperModel.constraintMaxWidth -
                    _handlerHelperModel.handlersWidth) /
                _realMax) *
            value) -
        widget.touchSize;
  }

  double getValueByPosition(double position) {
    double value = ((position /
            (_containerHelperModel.containerSizeWithoutPadding! / _divisions)) *
        _widgetStep!);
    value = (double.parse(value.toStringAsFixed(_decimalScale)) -
        double.parse((value % _widgetStep!).toStringAsFixed(_decimalScale)));
    return value;
  }

  double? getLengthByValue(value) {
    return value * _containerHelperModel.containerSizeWithoutPadding / _realMax;
  }

  double getValueByPositionIgnoreOffset(double position) {
    double value = ((position /
            (_containerHelperModel.containerSizeWithoutPadding! / _divisions)) *
        _widgetStep!);
    return value;
  }

  void _leftHandlerMove(PointerEvent pointer,
      {double lockedHandlersDragOffset = 0,
      double tappedPositionWithPadding = 0,
      bool selectedByTap = false}) {
    if (widget.disabled ||
        (widget.xliderHandlerConfiguration.leftHandler.disabled)) {
      return;
    }

    _handlersDistance = _upperValue - _lowerValue;

    // Tip: lockedHandlersDragOffset only subtracts from left handler position
    // because it calculates drag position only by left handler's position
    if (lockedHandlersDragOffset == 0) __lockedHandlersDragOffset = 0;

    if (selectedByTap) {
      _callbacks(XliderDragFunction.onDragStarted, XliderSide.left);
    }

    bool validMove = true;

    __dAxis = pointer.position.dx -
        tappedPositionWithPadding -
        lockedHandlersDragOffset -
        _containerHelperModel.containerLeft;
    __axisDragTmp = xDragTmp;
    _containerHelperModel = _containerHelperModel.copyWith(
        containerSizeWithoutPadding:
            _containerHelperModel.containerWidthWithoutPadding);
    __rightHandlerPosition = _handlerHelperModel.rightHandlerXPosition;
    __leftHandlerPosition = _handlerHelperModel.leftHandlerXPosition;

    __axisPosTmp = __dAxis! - __axisDragTmp! + widget.touchSize;

    _checkRangeStep(getValueByPositionIgnoreOffset(__axisPosTmp!));

    __rAxis = getValueByPosition(__axisPosTmp!);

    if (widget.rangeSlider &&
        (widget.xliderValues?.distances?.min ?? 0) > 0 &&
        (__rAxis! + (widget.xliderValues?.distances?.min ?? 0)) >=
            _upperValue) {
      _lowerValue =
          (_upperValue - (widget.xliderValues?.distances?.min ?? 0) > _realMin)
              ? _upperValue - (widget.xliderValues?.distances?.min ?? 0)
              : _realMin;
      _updateLowerValue(_lowerValue);

      if (lockedHandlersDragOffset == 0) validMove = validMove & false;
    }

    if (widget.rangeSlider &&
        (widget.xliderValues?.distances?.max ?? 0) > 0 &&
        __rAxis! <=
            (_upperValue - (widget.xliderValues?.distances?.max ?? 0))) {
      _lowerValue =
          (_upperValue - (widget.xliderValues?.distances?.max ?? 0) > _realMin)
              ? _upperValue - (widget.xliderValues?.distances?.max ?? 0)
              : _realMin;
      _updateLowerValue(_lowerValue);

      if (lockedHandlersDragOffset == 0) validMove = validMove & false;
    }

    double? tS = widget.touchSize;
    if (widget.jump) {
      tS = widget.touchSize + _handlerHelperModel.handlersPadding;
    }

    validMove = validMove & _leftHandlerIgnoreSteps(tS);

    bool forcePosStop = false;
    if (((__axisPosTmp! <= 0) ||
        (__axisPosTmp! - tS >= __rightHandlerPosition!))) {
      forcePosStop = true;
    }

    if (validMove &&
        ((__axisPosTmp! + _handlerHelperModel.handlersPadding >=
                _handlerHelperModel.handlersPadding) ||
            forcePosStop)) {
      double tmpLowerValue = __rAxis!;

      if (tmpLowerValue > _realMax) tmpLowerValue = _realMax;
      if (tmpLowerValue < _realMin) tmpLowerValue = _realMin;

      if (tmpLowerValue > _upperValue) tmpLowerValue = _upperValue;

      if (widget.jump) {
        if (!forcePosStop) {
          _lowerValue = tmpLowerValue;
          _leftHandlerMoveBetweenSteps(
              __dAxis! - __axisDragTmp!, selectedByTap);
          __leftHandlerPosition = getPositionByValue(_lowerValue);
        } else {
          if (__axisPosTmp! - tS >= __rightHandlerPosition!) {
            __leftHandlerPosition = __rightHandlerPosition;
            _lowerValue = tmpLowerValue = _upperValue;
          } else {
            __leftHandlerPosition = getPositionByValue(_realMin);
            _lowerValue = tmpLowerValue = _realMin;
          }
          _updateLowerValue(tmpLowerValue);
        }
      } else {
        _lowerValue = tmpLowerValue;

        if (!forcePosStop) {
          __leftHandlerPosition = __dAxis! - __axisDragTmp!; // - (_touchSize);

          _leftHandlerMoveBetweenSteps(__leftHandlerPosition, selectedByTap);
          tmpLowerValue = _lowerValue;
        } else {
          if (__axisPosTmp! - tS >= __rightHandlerPosition!) {
            __leftHandlerPosition = __rightHandlerPosition;
            _lowerValue = tmpLowerValue = _upperValue;
          } else {
            __leftHandlerPosition = getPositionByValue(_realMin);
            _lowerValue = tmpLowerValue = _realMin;
          }
          _updateLowerValue(tmpLowerValue);
        }
      }
    }
    _handlerHelperModel = _handlerHelperModel.copyWith(
      leftHandlerXPosition: __leftHandlerPosition,
    );
    if (widget.xliderHandlerConfiguration.lock ||
        lockedHandlersDragOffset > 0) {
      _lockedHandlers(XliderSide.left);
    }
    setState(() {});

    if (selectedByTap) {
      _callbacks(XliderDragFunction.onDragging, XliderSide.left);
      _callbacks(XliderDragFunction.onDragCompleted, XliderSide.left);
    } else {
      _callbacks(XliderDragFunction.onDragging, XliderSide.left);
    }
  }

  bool _leftHandlerIgnoreSteps(double? tS) {
    bool validMove = true;
    if (_ignoreSteps.isNotEmpty) {
      if (__axisPosTmp! <= 0) {
        double? ignorePoint;
        if (widget.startAtRight) {
          ignorePoint = _findBiggestIgnorePoint();
        } else {
          ignorePoint = _findSmallestIgnorePoint();
        }

        __leftHandlerPosition = getPositionByValue(ignorePoint);
        _lowerValue = ignorePoint;
        _updateLowerValue(_lowerValue);
        return false;
      } else if (__axisPosTmp! - tS! >= __rightHandlerPosition!) {
        __leftHandlerPosition = __rightHandlerPosition;
        _lowerValue = _upperValue;
        _updateLowerValue(_lowerValue);
        return false;
      }

      for (XliderIgnoreSteps steps in _ignoreSteps) {
        if (((!widget.startAtRight) &&
                (getValueByPositionIgnoreOffset(__axisPosTmp!) >
                        steps.from! - _widgetStep! / 2 &&
                    getValueByPositionIgnoreOffset(__axisPosTmp!) <=
                        steps.to! + _widgetStep! / 2)) ||
            ((widget.startAtRight) &&
                (_realMax - getValueByPositionIgnoreOffset(__axisPosTmp!) >
                        steps.from! - _widgetStep! / 2 &&
                    _realMax - getValueByPositionIgnoreOffset(__axisPosTmp!) <=
                        steps.to! + _widgetStep! / 2))) validMove = false;
      }
    }

    return validMove;
  }

  void _leftHandlerMoveBetweenSteps(handlerPos, bool selectedByTap) {
    double nextStepMiddlePos =
        getPositionByValue((_lowerValue + (_lowerValue + _widgetStep!)) / 2);
    double prevStepMiddlePos =
        getPositionByValue((_lowerValue - (_lowerValue - _widgetStep!)) / 2);

    if (handlerPos > nextStepMiddlePos || handlerPos < prevStepMiddlePos) {
      if (handlerPos > nextStepMiddlePos) {
        _lowerValue = _lowerValue + _widgetStep!;
        if (_lowerValue > _realMax) _lowerValue = _realMax;
        if (_lowerValue > _upperValue) _lowerValue = _upperValue;
      } else {
        _lowerValue = _lowerValue - _widgetStep!;
        if (_lowerValue < _realMin) _lowerValue = _realMin;
      }
    }
    _updateLowerValue(_lowerValue);
  }

  ///It's possible to move handler together.
  ///
  ///If [widget.selectByTap] is active don't do anything because handler update for tap
  ///will be done.
  void _lockedHandlers(XliderSide handler) {
    if (widget.selectByTap) {
      return;
    }

    double? distanceOfTwoHandlers = getLengthByValue(_handlersDistance);

    double? leftHandlerPos, rightHandlerPos;
    leftHandlerPos = _handlerHelperModel.leftHandlerXPosition;
    rightHandlerPos = _handlerHelperModel.rightHandlerXPosition;

    if (handler == XliderSide.right) {
      _lowerValue = _upperValue - _handlersDistance;
      leftHandlerPos = rightHandlerPos - distanceOfTwoHandlers!;
      if (getValueByPositionIgnoreOffset(__axisPosTmp!) - _handlersDistance <
          _realMin) {
        _lowerValue = _realMin;
        _upperValue = _realMin + _handlersDistance;
        rightHandlerPos = getPositionByValue(_upperValue);
        leftHandlerPos = getPositionByValue(_lowerValue);
      }
    } else {
      _upperValue = _lowerValue + _handlersDistance;
      rightHandlerPos = leftHandlerPos + distanceOfTwoHandlers!;
      if (getValueByPositionIgnoreOffset(__axisPosTmp!) + _handlersDistance >
          _realMax) {
        _upperValue = _realMax;
        _lowerValue = _realMax - _handlersDistance;
        rightHandlerPos = getPositionByValue(_upperValue);
        leftHandlerPos = getPositionByValue(_lowerValue);
      }
    }
    _handlerHelperModel = _handlerHelperModel.copyWith(
      leftHandlerXPosition: leftHandlerPos,
      rightHandlerXPosition: rightHandlerPos,
    );

    _updateUpperValue(_upperValue);
    _updateLowerValue(_lowerValue);
  }

  void _updateLowerValue(double value) {
    _outputLowerValue = _displayRealValue(value);
    if (widget.startAtRight == true) {
      _outputLowerValue = _displayRealValue(_realMax - value);
    }
  }

  void _rightHandlerMove(PointerEvent pointer,
      {double tappedPositionWithPadding = 0, bool selectedByTap = false}) {
    if (widget.disabled ||
        (widget.xliderHandlerConfiguration.rightHandler.disabled)) return;

    _handlersDistance = _upperValue - _lowerValue;

    if (selectedByTap) {
      _callbacks(XliderDragFunction.onDragStarted, XliderSide.right);
    }

    bool validMove = true;
    __dAxis = pointer.position.dx -
        tappedPositionWithPadding -
        _containerHelperModel.containerLeft;
    __axisDragTmp = xDragTmp;
    _containerHelperModel = _containerHelperModel.copyWith(
        containerSizeWithoutPadding:
            _containerHelperModel.containerWidthWithoutPadding);

    __rightHandlerPosition = _handlerHelperModel.rightHandlerXPosition;
    __leftHandlerPosition = _handlerHelperModel.leftHandlerXPosition;
    __containerSizeWithoutHalfPadding =
        _containerHelperModel.constraintMaxWidth -
            _handlerHelperModel.handlersPadding +
            1;

    __axisPosTmp = __dAxis! - __axisDragTmp! + widget.touchSize;

    _checkRangeStep(getValueByPositionIgnoreOffset(__axisPosTmp!));

    __rAxis = getValueByPosition(__axisPosTmp!);

    if (widget.rangeSlider &&
        (widget.xliderValues?.distances?.min ?? 0) > 0 &&
        (__rAxis! - (widget.xliderValues?.distances?.min ?? 0)) <=
            _lowerValue) {
      _upperValue =
          (_lowerValue + (widget.xliderValues?.distances?.min ?? 0) < _realMax)
              ? _lowerValue + (widget.xliderValues?.distances?.min ?? 0)
              : _realMax;
      validMove = validMove & false;
      _updateUpperValue(_upperValue);
    }
    if (widget.rangeSlider &&
        (widget.xliderValues?.distances?.max ?? 0) > 0 &&
        __rAxis! >=
            (_lowerValue + (widget.xliderValues?.distances?.max ?? 0))) {
      _upperValue =
          (_lowerValue + (widget.xliderValues?.distances?.max ?? 0) < _realMax)
              ? _lowerValue + (widget.xliderValues?.distances?.max ?? 0)
              : _realMax;
      validMove = validMove & false;
      _updateUpperValue(_upperValue);
    }

    double? tS = widget.touchSize;
    double rM = _handlerHelperModel.handlersPadding;
    if (widget.jump) {
      rM = -_handlerHelperModel.handlersWidth;
      tS = -widget.touchSize;
    }

    validMove = validMove & _rightHandlerIgnoreSteps(tS);

    bool forcePosStop = false;
    if (((__axisPosTmp! >=
            _containerHelperModel.containerSizeWithoutPadding!) ||
        (__axisPosTmp! - tS <= __leftHandlerPosition!))) {
      forcePosStop = true;
    }

    if (validMove &&
        (__axisPosTmp! + rM <= __containerSizeWithoutHalfPadding! ||
            forcePosStop)) {
      double tmpUpperValue = __rAxis!;

      if (tmpUpperValue > _realMax) tmpUpperValue = _realMax;
      if (tmpUpperValue < _realMin) tmpUpperValue = _realMin;

      if (tmpUpperValue < _lowerValue) tmpUpperValue = _lowerValue;

      if (widget.jump == true) {
        if (!forcePosStop) {
          _upperValue = tmpUpperValue;
          _rightHandlerMoveBetweenSteps(
              __dAxis! - __axisDragTmp!, selectedByTap);
          __rightHandlerPosition = getPositionByValue(_upperValue);
        } else {
          if (__axisPosTmp! - tS <= __leftHandlerPosition!) {
            __rightHandlerPosition = __leftHandlerPosition;
            _upperValue = tmpUpperValue = _lowerValue;
          } else {
            __rightHandlerPosition = getPositionByValue(_realMax);
            _upperValue = tmpUpperValue = _realMax;
          }

          _updateUpperValue(tmpUpperValue);
        }
      } else {
        _upperValue = tmpUpperValue;

        if (!forcePosStop) {
          __rightHandlerPosition = __dAxis! - __axisDragTmp!;
          _rightHandlerMoveBetweenSteps(__rightHandlerPosition, selectedByTap);
          tmpUpperValue = _upperValue;
        } else {
          if (__axisPosTmp! - tS <= __leftHandlerPosition!) {
            __rightHandlerPosition = __leftHandlerPosition;
            _upperValue = tmpUpperValue = _lowerValue;
          } else {
            __rightHandlerPosition = getPositionByValue(_realMax) + 1;
            _upperValue = tmpUpperValue = _realMax;
          }
        }
        _updateUpperValue(tmpUpperValue);
      }
    }
    _handlerHelperModel = _handlerHelperModel.copyWith(
        rightHandlerXPosition: __rightHandlerPosition);

    if (widget.xliderHandlerConfiguration.lock) {
      _lockedHandlers(XliderSide.right);
    }

    setState(() {});

    if (selectedByTap) {
      _callbacks(XliderDragFunction.onDragging, XliderSide.right);
      _callbacks(XliderDragFunction.onDragCompleted, XliderSide.right);
    } else {
      _callbacks(XliderDragFunction.onDragging, XliderSide.right);
    }
  }

  bool _rightHandlerIgnoreSteps(double? tS) {
    bool validMove = true;
    if (_ignoreSteps.isNotEmpty) {
      if (__axisPosTmp! <= 0) {
        if (!widget.rangeSlider) {
          double? ignorePoint;
          if (widget.startAtRight) {
            ignorePoint = _findBiggestIgnorePoint();
          } else {
            ignorePoint = _findSmallestIgnorePoint();
          }

          __rightHandlerPosition = getPositionByValue(ignorePoint);
          _upperValue = ignorePoint;
          _updateUpperValue(_upperValue);
        } else {
          __rightHandlerPosition = __leftHandlerPosition;
          _upperValue = _lowerValue;
          _updateUpperValue(_upperValue);
        }
        return false;
      } else if (__axisPosTmp! >=
          _containerHelperModel.containerSizeWithoutPadding!) {
        double? ignorePoint;

        if (widget.startAtRight) {
          ignorePoint = _findSmallestIgnorePoint();
        } else {
          ignorePoint = _findBiggestIgnorePoint();
        }

        __rightHandlerPosition = getPositionByValue(ignorePoint);
        _upperValue = ignorePoint;
        _updateUpperValue(_upperValue);
        return false;
      }

      for (XliderIgnoreSteps steps in _ignoreSteps) {
        if (((!widget.startAtRight) &&
                (getValueByPositionIgnoreOffset(__axisPosTmp!) >
                        steps.from! - _widgetStep! / 2 &&
                    getValueByPositionIgnoreOffset(__axisPosTmp!) <=
                        steps.to! + _widgetStep! / 2)) ||
            ((widget.startAtRight) &&
                (_realMax - getValueByPositionIgnoreOffset(__axisPosTmp!) >
                        steps.from! - _widgetStep! / 2 &&
                    _realMax - getValueByPositionIgnoreOffset(__axisPosTmp!) <=
                        steps.to! + _widgetStep! / 2))) validMove = false;
      }
    }
    return validMove;
  }

  double _findSmallestIgnorePoint({ignoreBeyondBoundaries = false}) {
    double ignorePoint = _realMax;
    bool beyondBoundaries = false;
    for (XliderIgnoreSteps steps in _ignoreSteps) {
      if (steps.from! < _realMin) beyondBoundaries = true;
      if (steps.from! < ignorePoint && steps.from! >= _realMin) {
        ignorePoint = steps.from! - _widgetStep!;
      } else if (steps.to! < ignorePoint && steps.to! >= _realMin) {
        ignorePoint = steps.to! + _widgetStep!;
      }
    }
    if (beyondBoundaries || ignoreBeyondBoundaries) {
      if (widget.startAtRight) {
        ignorePoint = _realMax - ignorePoint;
      }
      return ignorePoint;
    } else {
      if (widget.startAtRight) return _realMax;
      return _realMin;
    }
  }

  double _findBiggestIgnorePoint({ignoreBeyondBoundaries = false}) {
    double ignorePoint = _realMin;
    bool beyondBoundaries = false;
    for (XliderIgnoreSteps steps in _ignoreSteps) {
      if (steps.to! > _realMax) beyondBoundaries = true;

      if (steps.to! > ignorePoint && steps.to! <= _realMax) {
        ignorePoint = steps.to! + _widgetStep!;
      } else if (steps.from! > ignorePoint && steps.from! <= _realMax) {
        ignorePoint = steps.from! - _widgetStep!;
      }
    }
    if (beyondBoundaries || ignoreBeyondBoundaries) {
      if (widget.startAtRight) {
        ignorePoint = _realMax - ignorePoint;
      }

      return ignorePoint;
    } else {
      if (widget.startAtRight) return _realMin;
      return _realMax;
    }
  }

  void _rightHandlerMoveBetweenSteps(handlerPos, bool selectedByTap) {
    double nextStepMiddlePos =
        getPositionByValue((_upperValue + (_upperValue + _widgetStep!)) / 2);
    double prevStepMiddlePos =
        getPositionByValue((_upperValue - (_upperValue - _widgetStep!)) / 2);

    if (handlerPos > nextStepMiddlePos || handlerPos < prevStepMiddlePos) {
      if (handlerPos > nextStepMiddlePos) {
        _upperValue = _upperValue + _widgetStep!;
        if (_upperValue > _realMax) _upperValue = _realMax;
      } else {
        _upperValue = _upperValue - _widgetStep!;
        if (_upperValue < _realMin) _upperValue = _realMin;
        if (_upperValue < _lowerValue) _upperValue = _lowerValue;
      }
    }
    _updateUpperValue(_upperValue);
  }

  void _updateUpperValue(double value) {
    _outputUpperValue = _displayRealValue(value);
    if (widget.startAtRight == true) {
      _outputUpperValue = _displayRealValue(_realMax - value);
    }
  }

  void _checkRangeStep(double realValue) {
    double? sliderFromRange, sliderToRange;
    if (widget.step.rangeList != null) {
      for (XliderRangeStep rangeStep in widget.step.rangeList!) {
        if (widget.step.isPercentRange) {
          sliderFromRange = _widgetMax! * rangeStep.from! / 100;
          sliderToRange = _widgetMax! * rangeStep.to! / 100;
        } else {
          sliderFromRange = rangeStep.from;
          sliderToRange = rangeStep.to;
        }

        if (realValue >= sliderFromRange! && realValue <= sliderToRange!) {
          _widgetStep = rangeStep.step;
          _setDivisionAndDecimalScale();
          break;
        }
      }
    }
  }

  Positioned _leftHandlerWidget() {
    if (widget.rangeSlider == false) {
      return Positioned(
        child: Container(),
      );
    }

    double bottom = 0;

    return Positioned(
      key: const Key('leftHandler'),
      left: _handlerHelperModel.leftHandlerXPosition,
      top: _handlerHelperModel.leftHandlerYPosition,
      bottom: bottom,
      child: Listener(
        child: Draggable(
          axis: Axis.horizontal,
          feedback: Container(),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Tooltip(
                side: XliderSide.left,
                value: _outputLowerValue,
                opacity: _tooltipHelperModel.leftTooltipOpacity,
                animation: _tooltipHelperModel.leftTooltipAnimation!,
                tooltipHelperModel: _tooltipHelperModel,
                isRangeSlider: widget.rangeSlider,
                tooltip: widget.tooltip,
                leftTooltipKey: leftTooltipKey,
                rightTooltipKey: rightTooltipKey,
              ),
              _handlerHelperModel.leftHandler,
            ],
          ),
        ),
        onPointerMove: (_) {
          __dragging = true;

          _leftHandlerMove(_);
        },
        onPointerDown: (_) {
          if (widget.disabled ||
              (widget.xliderHandlerConfiguration.leftHandler.disabled)) return;

          _containerHelperModel = _containerHelperModel.renderBoxInitialization(
            screenSize: MediaQuery.of(context).size,
            containerKey: containerKey,
          );

          xDragTmp = (_.position.dx -
              _containerHelperModel.containerLeft -
              _handlerHelperModel.leftHandlerXPosition);
          yDragTmp = (_.position.dy -
              _containerHelperModel.containerTop -
              _handlerHelperModel.leftHandlerYPosition);

          if (!_tooltipHelperModel.tooltipData.disabled &&
              _tooltipHelperModel.tooltipData.alwaysShowTooltip == false) {
            _tooltipHelperModel = _tooltipHelperModel.startLeftAnimation(
                lockHandlers: widget.xliderHandlerConfiguration.lock);
          }

          _handlerHelperModel.leftHandlerScaleAnimationController!.forward();

          setState(() {});

          _callbacks(XliderDragFunction.onDragStarted, XliderSide.left);
        },
        onPointerUp: (_) {
          __dragging = false;

          _handlerHelperModel = _handlerHelperModel.adjustLeftHandlerPosition(
            jump: !widget.jump,
            lowerPositionValue: getPositionByValue(_lowerValue),
            posititonValue: getPositionByValue(_lowerValue + _handlersDistance),
            lockHandlers: widget.xliderHandlerConfiguration.lock,
            lockedHandlersDragOffset: __lockedHandlersDragOffset,
          );

          if (widget.disabled ||
              (widget.xliderHandlerConfiguration.leftHandler.disabled)) return;

          _arrangeHandlersZIndex();
          _handlerHelperModel.stopHandlerLeftAnimation(
              hasCustomReverseCurve: (widget.xliderHandlerConfiguration
                      .handlerAnimation.reverseCurve !=
                  null));

          _tooltipHelperModel = _tooltipHelperModel.hideTooltips();

          setState(() {});

          _callbacks(XliderDragFunction.onDragCompleted, XliderSide.left);
        },
      ),
    );
  }

  Positioned _rightHandlerWidget() {
    double bottom = 0;

    return Positioned(
      key: const Key('rightHandler'),
      left: _handlerHelperModel.rightHandlerXPosition,
      top: _handlerHelperModel.rightHandlerYPosition,
      bottom: bottom,
      child: Listener(
        child: Draggable(
          axis: Axis.horizontal,
          feedback: Container(),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: ([
              Tooltip(
                side: XliderSide.right,
                value: _outputUpperValue,
                opacity: _tooltipHelperModel.rightTooltipOpacity,
                animation: _tooltipHelperModel.rightTooltipAnimation!,
                tooltipHelperModel: _tooltipHelperModel,
                isRangeSlider: widget.rangeSlider,
                tooltip: widget.tooltip,
                leftTooltipKey: leftTooltipKey,
                rightTooltipKey: rightTooltipKey,
              ),
              _handlerHelperModel.rightHandler,
            ]),
          ),
        ),
        onPointerMove: (_) {
          __dragging = true;

          _rightHandlerMove(_);
        },
        onPointerDown: (_) {
          if (widget.disabled ||
              (widget.xliderHandlerConfiguration.rightHandler.disabled)) {
            return;
          }

          _containerHelperModel = _containerHelperModel.renderBoxInitialization(
            screenSize: MediaQuery.of(context).size,
            containerKey: containerKey,
          );

          xDragTmp = (_.position.dx -
              _containerHelperModel.containerLeft -
              _handlerHelperModel.rightHandlerXPosition);
          yDragTmp = (_.position.dy -
              _containerHelperModel.containerTop -
              _handlerHelperModel.rightHandlerYPosition);

          if (!_tooltipHelperModel.tooltipData.disabled &&
              _tooltipHelperModel.tooltipData.alwaysShowTooltip == false) {
            _tooltipHelperModel = _tooltipHelperModel.startRightAnimation(
              lockHandlers: widget.xliderHandlerConfiguration.lock,
            );

            setState(() {});
          }
          if (widget.rangeSlider == false) {
            _handlerHelperModel.leftHandlerScaleAnimationController!.forward();
          } else {
            _handlerHelperModel.rightHandlerScaleAnimationController!.forward();
          }

          _callbacks(XliderDragFunction.onDragStarted, XliderSide.right);
        },
        onPointerUp: (_) {
          __dragging = false;

          _handlerHelperModel = _handlerHelperModel.adjustRightHandlerPosition(
            jump: widget.jump,
            upperPositionValue: getPositionByValue(_upperValue),
            posititonValue: getPositionByValue(_upperValue - _handlersDistance),
            lockHandlers: widget.xliderHandlerConfiguration.lock,
          );

          if (widget.disabled ||
              (widget.xliderHandlerConfiguration.rightHandler.disabled)) {
            return;
          }

          _arrangeHandlersZIndex();

          if (widget.rangeSlider == false) {
            _handlerHelperModel.stopHandlerLeftAnimation(
                hasCustomReverseCurve: (widget.xliderHandlerConfiguration
                        .handlerAnimation.reverseCurve !=
                    null));
          } else {
            _handlerHelperModel.stopHandlerRightAnimation(
                hasCustomReverseCurve: (widget.xliderHandlerConfiguration
                        .handlerAnimation.reverseCurve !=
                    null));
          }

          _tooltipHelperModel = _tooltipHelperModel.hideTooltips();

          setState(() {});

          _callbacks(XliderDragFunction.onDragCompleted, XliderSide.right);
        },
      ),
    );
  }

  List<Widget> drawHandlers() {
    List<Widget> items = [
      InactiveTrack(
        trackBar: widget.trackBar,
        disabled: widget.disabled,
        containerHelperModel: _containerHelperModel,
        handlersPadding: _handlerHelperModel.handlersPadding,
      ),
      Positioned(
        left: 0,
        top: 0,
        right: 0,
        bottom: 0,
        child: Center(child: widget.trackBar.centralWidget ?? Container()),
      ),
      ActiveTrack(
        trackBar: widget.trackBar,
        disabled: widget.disabled,
        containerHelperModel: _containerHelperModel,
        handlerHelperModel: _handlerHelperModel,
        touchSize: widget.touchSize,
        isRangeSlider: widget.rangeSlider,
        isCenterOrigen: widget.centeredOrigin,
        isRtl: widget.startAtRight,
      ),
    ];
    items.addAll(_points);

    double tappedPositionWithPadding = 0;

    items.add(Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Opacity(
          opacity: 0,
          child: Listener(
            onPointerUp: (_) {
              __dragging = false;
              if (widget.selectByTap && !__dragging) {
                tappedPositionWithPadding = _distance();
                if (_distanceFromLeftHandler! < _distanceFromRightHandler!) {
                  if (!widget.rangeSlider) {
                    _rightHandlerMove(_,
                        tappedPositionWithPadding: tappedPositionWithPadding,
                        selectedByTap: true);
                  } else {
                    _leftHandlerMove(_,
                        tappedPositionWithPadding: tappedPositionWithPadding,
                        selectedByTap: true);
                  }
                } else {
                  _rightHandlerMove(_,
                      tappedPositionWithPadding: tappedPositionWithPadding,
                      selectedByTap: true);
                }
              } else {
                if (_slidingByActiveTrackBar) {
                  _callbacks(
                      XliderDragFunction.onDragCompleted, XliderSide.left);
                }
                if (_leftTapAndSlide) {
                  _callbacks(
                      XliderDragFunction.onDragCompleted, XliderSide.left);
                }
                if (_rightTapAndSlide) {
                  _callbacks(
                      XliderDragFunction.onDragCompleted, XliderSide.right);
                }
              }

              _tooltipHelperModel = _tooltipHelperModel.hideTooltips();

              _handlerHelperModel.stopHandlerAnimation(
                  hasCustomReverseCurve: (widget.xliderHandlerConfiguration
                          .handlerAnimation.reverseCurve !=
                      null));

              setState(() {});
            },
            onPointerMove: (_) {
              __dragging = true;

              if (_slidingByActiveTrackBar) {
                _trackBarSlideCallDragStated(XliderSide.left);
                _leftHandlerMove(_,
                    lockedHandlersDragOffset: __lockedHandlersDragOffset);
              } else {
                tappedPositionWithPadding = _distance();

                if (widget.rangeSlider) {
                  if (_leftTapAndSlide) {
                    _trackBarSlideCallDragStated(XliderSide.left);
                    if (!_tooltipHelperModel.tooltipData.disabled &&
                        _tooltipHelperModel.tooltipData.alwaysShowTooltip ==
                            false) {
                      _tooltipHelperModel = _tooltipHelperModel
                          .startLeftAnimation(lockHandlers: false);
                    }
                    _leftHandlerMove(_,
                        tappedPositionWithPadding: tappedPositionWithPadding);
                  } else {
                    _trackBarSlideCallDragStated(XliderSide.right);
                    if (!_tooltipHelperModel.tooltipData.disabled &&
                        _tooltipHelperModel.tooltipData.alwaysShowTooltip ==
                            false) {
                      _tooltipHelperModel = _tooltipHelperModel
                          .startRightAnimation(lockHandlers: false);
                    }
                    _rightHandlerMove(_,
                        tappedPositionWithPadding: tappedPositionWithPadding);
                  }
                } else {
                  _trackBarSlideCallDragStated(XliderSide.right);
                  if (!_tooltipHelperModel.tooltipData.disabled &&
                      _tooltipHelperModel.tooltipData.alwaysShowTooltip ==
                          false) {
                    _tooltipHelperModel = _tooltipHelperModel
                        .startRightAnimation(lockHandlers: false);
                  }
                  _rightHandlerMove(_,
                      tappedPositionWithPadding: tappedPositionWithPadding);
                }
              }
            },
            onPointerDown: (_) {
              _leftTapAndSlide = false;
              _rightTapAndSlide = false;
              _slidingByActiveTrackBar = false;
              __dragging = false;
              _trackBarSlideOnDragStartedCalled = false;

              double leftHandlerLastPosition, rightHandlerLastPosition;
              double lX = _handlerHelperModel.leftHandlerXPosition +
                  _handlerHelperModel.handlersPadding +
                  widget.touchSize +
                  _containerHelperModel.containerLeft;
              double rX = _handlerHelperModel.rightHandlerXPosition +
                  _handlerHelperModel.handlersPadding +
                  widget.touchSize +
                  _containerHelperModel.containerLeft;

              _distanceFromRightHandler = (rX - _.position.dx);
              _distanceFromLeftHandler = (lX - _.position.dx);

              leftHandlerLastPosition = lX;
              rightHandlerLastPosition = rX;

              if (widget.rangeSlider &&
                  widget.trackBar.activeTrackBarDraggable &&
                  _ignoreSteps.isEmpty &&
                  _distanceFromRightHandler! > 0 &&
                  _distanceFromLeftHandler! < 0) {
                _slidingByActiveTrackBar = true;
              } else {
                double thumbPosition = _.position.dx;
                if (_distanceFromLeftHandler!.abs() <
                        _distanceFromRightHandler!.abs() ||
                    (_distanceFromLeftHandler == _distanceFromRightHandler &&
                        thumbPosition < leftHandlerLastPosition)) {
                  _leftTapAndSlide = true;
                }
                if (_distanceFromRightHandler!.abs() <
                        _distanceFromLeftHandler!.abs() ||
                    (_distanceFromLeftHandler == _distanceFromRightHandler &&
                        thumbPosition < rightHandlerLastPosition)) {
                  _rightTapAndSlide = true;
                }
              }

              // if drag is within active area
              if (_distanceFromRightHandler! > 0 &&
                  _distanceFromLeftHandler! < 0) {
                xDragTmp = 0;
                __lockedHandlersDragOffset =
                    (_handlerHelperModel.leftHandlerXPosition +
                            _containerHelperModel.containerLeft -
                            _.position.dx)
                        .abs();
              }

              if (_ignoreSteps.isEmpty) {
                if ((widget.xliderHandlerConfiguration.lock ||
                        __lockedHandlersDragOffset > 0) &&
                    !_tooltipHelperModel.tooltipData.disabled &&
                    _tooltipHelperModel.tooltipData.alwaysShowTooltip ==
                        false) {
                  _tooltipHelperModel = _tooltipHelperModel.startLeftAnimation(
                      lockHandlers: true);
                }

                if ((widget.xliderHandlerConfiguration.lock ||
                    __lockedHandlersDragOffset > 0)) {
                  _handlerHelperModel.leftHandlerScaleAnimationController!
                      .forward();
                  _handlerHelperModel.rightHandlerScaleAnimationController!
                      .forward();
                }
              }

              setState(() {});
            },
            child: Draggable(
                axis: Axis.horizontal,
                feedback: Container(),
                child: Container(
                  color: Colors.transparent,
                )),
          ),
        )));

    for (Function func in _positionedItems) {
      items.add(Function.apply(func, []));
    }

    return items;
  }

  _trackBarSlideCallDragStated(XliderSide handlerIndex) {
    if (!_trackBarSlideOnDragStartedCalled) {
      _callbacks(XliderDragFunction.onDragStarted, handlerIndex);
      _trackBarSlideOnDragStartedCalled = true;
    }
  }

  _distance() {
    _distanceFromLeftHandler = _distanceFromLeftHandler!.abs();
    _distanceFromRightHandler = _distanceFromRightHandler!.abs();
    return _handlerHelperModel.handlersWidth / 2 + widget.touchSize - xDragTmp;
  }

  void _callbacks(XliderDragFunction type, XliderSide handlerIndex) {
    double lowerValue = _outputLowerValue;
    double upperValue = _outputUpperValue;
    if (widget.startAtRight == true || widget.rangeSlider == false) {
      lowerValue = _outputUpperValue;
      upperValue = _outputLowerValue;
    }

    switch (type) {
      case XliderDragFunction.onDragging:
        if (widget.onDragging != null) {
          widget.onDragging!(handlerIndex, lowerValue, upperValue);
        }
        break;
      case XliderDragFunction.onDragCompleted:
        if (widget.onDragCompleted != null) {
          widget.onDragCompleted!(handlerIndex, lowerValue, upperValue);
        }
        break;
      case XliderDragFunction.onDragStarted:
        if (widget.onDragStarted != null) {
          widget.onDragStarted!(handlerIndex, lowerValue, upperValue);
        }
        break;
    }
  }

  double _displayRealValue(double value) {
    if (_fixedValues.isNotEmpty) {
      return _fixedValues[value.toInt()].value ?? 0;
    }

    return double.parse((value + _widgetMin!).toStringAsFixed(_decimalScale));
  }

  void _arrangeHandlersZIndex() {
    if (_lowerValue >= (_realMax / 2)) {
      _positionedItems = [
        _rightHandlerWidget,
        _leftHandlerWidget,
      ];
    } else {
      _positionedItems = [
        _leftHandlerWidget,
        _rightHandlerWidget,
      ];
    }
  }
}
