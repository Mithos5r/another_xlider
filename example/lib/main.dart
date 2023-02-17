import 'package:flutter/material.dart';
import 'package:xlider/xlider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Xlider Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _lowerValue = 50;
  double _upperValue = 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50),
              child: Xlider(
                xliderValues: XliderValues(
                  values: XliderRangeValues(min: 50),
                  range: XliderRangeValues(min: 0, max: 100),
                ),
                xliderHandlerConfiguration: XliderHandlerConfiguration(),
                touchSize: 5,
                selectByTap: false,
                centeredOrigin: true,
                isMagnetic: true,
                trackBar: XliderTrackBarConfiguration(
                  activeTrackbar: XliderTrackBar(
                    thickness: 3.5,
                    color: Colors.red,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                    ),
                  ),
                ),
                step: XliderStep(step: 10, isPercentRange: true, rangeList: [
                  XliderRangeStep(from: 0, to: 20, step: 10),
                  XliderRangeStep(from: 20, to: 50, step: 5),
                ]),
                tooltip: XliderTooltip(
                  direction: XliderTooltipDirection.top,
                  decorations: XliderTooltipDecorations(
                    rightComplements: XliderTooltipComplements(
                      suffix: Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
//             Container(
//               color: Colors.red,
//               margin: EdgeInsets.only(top: 50, left: 50, right: 50),
//               alignment: Alignment.centerLeft,
//               child: Xlider(
//                 values: [60, 160],
// //              ignoreSteps: [
// //               XliderIgnoreSteps(from: 120, to: 150),
// //               XliderIgnoreSteps(from: 160, to: 190),
// //              ],
//                 max: 200,
//                 min: 50,
//                 maximumDistance: 0,
//                 rangeSlider: true,
//                 rtl: false,
//                 handlerAnimation: XliderHandlerAnimation(
//                     curve: Curves.elasticOut,
//                     reverseCurve: null,
//                     duration: Duration(milliseconds: 700),
//                     scale: 1.4),
//                 onDragging: (handlerIndex, lowerValue, upperValue) {
//                   setState(() {
//                     _lowerValue = lowerValue;
//                     _upperValue = upperValue;
//                   });
//                 },
//               ),
//             ),
//             Container(
//                 margin: EdgeInsets.only(top: 50, left: 20, right: 20),
//                 alignment: Alignment.centerLeft,
//                 child: Xlider(
//                   values: [1000, 15000],
//                   rangeSlider: true,
// //rtl: true,
//                   ignoreSteps: [
//                     XliderIgnoreSteps(from: 8000, to: 12000),
//                     XliderIgnoreSteps(from: 18000, to: 22000),
//                   ],
//                   max: 25000,
//                   min: 0,
//                   step: XliderStep(step: 100),

//                   jump: true,

//                   trackBar: XliderTrackBar(
//                     activeTrackBarHeight: 5,
//                   ),
//                   tooltip: XliderTooltip(
//                     textStyle: TextStyle(fontSize: 17, color: Colors.lightBlue),
//                   ),
//                   handler: XliderHandler(
//                     decoration: BoxDecoration(),
//                     child: Material(
//                       type: MaterialType.canvas,
//                       color: Colors.orange,
//                       elevation: 10,
//                       child: Container(
//                           padding: EdgeInsets.all(5),
//                           child: Icon(
//                             Icons.adjust,
//                             size: 25,
//                           )),
//                     ),
//                   ),
//                   rightHandler: XliderHandler(
//                     child: Icon(
//                       Icons.chevron_left,
//                       color: Colors.red,
//                       size: 24,
//                     ),
//                   ),
//                   disabled: false,

//                   onDragging: (handlerIndex, lowerValue, upperValue) {
//                     _lowerValue = lowerValue;
//                     _upperValue = upperValue;
//                     setState(() {});
//                   },
//                 )),
//             Container(
//                 margin: EdgeInsets.only(top: 50, left: 20, right: 20),
//                 alignment: Alignment.centerLeft,
//                 child: Xlider(
//                   values: [3000, 17000],
//                   rangeSlider: true,
// //rtl: true,

// //                ignoreSteps: [
// //                 XliderIgnoreSteps(from: 8000, to: 12000),
// //                 XliderIgnoreSteps(from: 18000, to: 22000),
// //                ],
//                   max: 25000,
//                   min: 0,
//                   step: XliderStep(step: 100),
//                   jump: true,
//                   trackBar: XliderTrackBar(
//                     inactiveTrackBarHeight: 2,
//                     activeTrackBarHeight: 3,
//                   ),

//                   disabled: false,

//                   handler: customHandler(Icons.chevron_right),
//                   rightHandler: customHandler(Icons.chevron_left),
//                   tooltip: XliderTooltip(
//                     leftPrefix: Icon(
//                       Icons.attach_money,
//                       size: 19,
//                       color: Colors.black45,
//                     ),
//                     rightSuffix: Icon(
//                       Icons.attach_money,
//                       size: 19,
//                       color: Colors.black45,
//                     ),
//                     textStyle: TextStyle(fontSize: 17, color: Colors.black45),
//                   ),

//                   onDragging: (handlerIndex, lowerValue, upperValue) {
//                     _lowerValue = lowerValue;
//                     _upperValue = upperValue;
//                     setState(() {});
//                   },
//                 )),
//             Container(
//               margin: EdgeInsets.only(top: 20, left: 20, right: 20),
//               alignment: Alignment.centerLeft,
//               child: Xlider(
//                 key: Key('3343'),
//                 values: [300000000, 1600000000],
//                 rangeSlider: true,
//                 tooltip: XliderTooltip(
//                   alwaysShowTooltip: true,
//                 ),
//                 max: 2000000000,
//                 min: 0,
//                 step: XliderStep(step: 20),
//                 jump: true,
//                 onDragging: (handlerIndex, lowerValue, upperValue) {
//                   _lowerValue = lowerValue;
//                   _upperValue = upperValue;
//                   setState(() {});
//                 },
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 50, left: 50, right: 50),
//               alignment: Alignment.centerLeft,
//               child: Xlider(
//                 values: [30, 60],
//                 rangeSlider: true,
//                 max: 100,
//                 min: 0,
//                 visibleTouchArea: true,
//                 trackBar: XliderTrackBar(
//                   inactiveTrackBarHeight: 14,
//                   activeTrackBarHeight: 10,
//                   inactiveTrackBar: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.black12,
//                     border: Border.all(width: 3, color: Colors.blue),
//                   ),
//                   activeTrackBar: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                       color: Colors.blue.withOpacity(0.5)),
//                 ),
//                 onDragging: (handlerIndex, lowerValue, upperValue) {
//                   _lowerValue = lowerValue;
//                   _upperValue = upperValue;
//                   setState(() {});
//                 },
//               ),
//             ),

//             /*Fixed Values*/
//             Container(
//               height: 80,
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Xlider(
//                 jump: true,
//                 values: [10],
//                 fixedValues: [
//                   XliderFixedValue(percent: 0, value: '1000'),
//                   XliderFixedValue(percent: 10, value: '10K'),
//                   XliderFixedValue(percent: 50, value: 50000),
//                   XliderFixedValue(percent: 80, value: '80M'),
//                   XliderFixedValue(percent: 100, value: '100B'),
//                 ],
//                 onDragging: (handlerIndex, lowerValue, upperValue) {
//                   if (lowerValue is String) {
//                     _lowerValue = double.tryParse(lowerValue) ?? 20;
//                   } else {
//                     _lowerValue = lowerValue.toDouble();
//                   }
//                   setState(() {});
//                 },
//               ),
//             ),

//             /*Hatch Mark Example*/
//             Container(
//               height: 50,
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Xlider(
//                 handlerWidth: 15,
//                 hatchMark: XliderHatchMark(
//                   linesDistanceFromTrackBar: 5,
//                   density: 0.5,
//                   labels: [
//                     XliderHatchMarkLabel(percent: 0, label: Text('Start')),
//                     XliderHatchMarkLabel(percent: 10, label: Text('10,000')),
//                     XliderHatchMarkLabel(percent: 50, label: Text('50 %')),
//                     XliderHatchMarkLabel(percent: 80, label: Text('80,000')),
//                     XliderHatchMarkLabel(percent: 100, label: Text('Finish')),
//                   ],
//                 ),
//                 jump: true,
//                 trackBar: XliderTrackBar(),
//                 handler: XliderHandler(
//                   decoration: BoxDecoration(),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 rightHandler: XliderHandler(
//                   decoration: BoxDecoration(),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 values: [30000, 70000],
//                 visibleTouchArea: true,
//                 min: 0,
//                 max: 100000,
//                 touchSize: 15,
//                 rangeSlider: true,
//                 step: XliderStep(step: 1000),
//                 onDragging: (handlerIndex, lowerValue, upperValue) {},
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Text('Lower Value: ' + _lowerValue.toString()),
//             SizedBox(height: 25),
//             Text('Upper Value: ' + _upperValue.toString())
          ],
        ),
      ),
    );
  }

  XliderHandler customHandler(IconData icon) {
    return XliderHandler(
      decoration: BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0.05,
                blurRadius: 5,
                offset: Offset(0, 1))
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle),
          child: Icon(
            icon,
            color: Colors.white,
            size: 23,
          ),
        ),
      ),
    );
  }
}
