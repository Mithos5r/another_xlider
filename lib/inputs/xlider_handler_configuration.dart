part of xlider;

class XliderHandlerConfiguration {
  ///Width of the handler
  ///
  ///Set a Sizebox in top of the handler child widget with it
  final double width;

  ///Height of the handler
  ///
  ///Set a Sizebox in top of the handler child widget with it
  final double height;

  ///Block handlers and both will be move together
  final bool lock;

  final XliderHandler leftHandler;
  final XliderHandler rightHandler;
  final XliderHandlerAnimation handlerAnimation;

  const XliderHandlerConfiguration({
    this.leftHandler = const XliderHandler(),
    this.rightHandler = const XliderHandler(),
    this.handlerAnimation = const XliderHandlerAnimation(),
    this.width = 35,
    this.height = 35,
    this.lock = false,
  });
}
