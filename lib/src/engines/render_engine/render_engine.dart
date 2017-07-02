import 'dart:html';
import 'dart:async';

import 'package:engine_dart/engine.dart';
import 'package:engine_dart/flux.dart';
import 'package:logging/logging.dart';

import 'context.dart';
import 'state.dart';

Logger _logger = new Logger('render engine');

class RenderEngine extends EngineStore<RenderEngineState> {
  CanvasRenderingContext2D _canvasContext;
  RenderingContext _renderingContext;

  // Note: ignoring close_sinks because this is managed
  // ignore: close_sinks
  StreamController<Null> _didResizeController =
      new StreamController<Null>.broadcast();

  Action<Renderable> addRenderable = new Action<Renderable>();
  Action<Renderable> removeRenderable = new Action<Renderable>();

  RenderEngine() {
    [
      addRenderable,
      removeRenderable,
    ].forEach(manageAction);
  }

  /// Event fired when the window resizes.
  ///
  /// There is no payload as the state should be checked for the
  /// most up-to-date dimensions.
  Stream<Null> get didResize => _didResizeController.stream;

  @override
  Future<Null> onLoad() async {
    CanvasElement canvasElement =
        document.querySelector('.canvas') as CanvasElement;
    _canvasContext = canvasElement.context2D;
    _renderingContext = new RenderingContext(_canvasContext);

    [
      addRenderable.listen(_addRenderable),
      removeRenderable.listen(_removeRenderable),
      window.onResize.listen(_onWindowResize),
    ].forEach(manageStreamSubscription);
  }

  @override
  void onStep() {
    _renderingContext.fillRect(0, 0, state.width, state.height,
        color: canvasColor);

    // TODO: render in layers
    state.assets.forEach((asset) {
      asset.render(_renderingContext, state);
    });

    window.requestAnimationFrame((_) => onStep());
  }

  void _addRenderable(Renderable renderable) {
    trigger((state.toBuilder()..assets.add(renderable)).build());
  }

  void _removeRenderable(Renderable renderable) {
    trigger((state.toBuilder()..assets.remove(renderable)).build());
  }

  void _onWindowResize(e) {
    _logger.info('resizing');
    trigger((state.toBuilder()
          ..width = window.innerWidth
          ..height = window.innerHeight)
        .build());
    _didResizeController.add(null);
  }

  @override
  RenderEngineState get initialState => new RenderEngineState.initial();
}
