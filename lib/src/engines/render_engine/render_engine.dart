import 'dart:html';
import 'dart:async';

import 'package:engine_dart/engine.dart';
import 'package:engine_dart/flux.dart';
import 'package:logging/logging.dart';

import 'context.dart';
import 'state.dart';

Logger _logger = new Logger('render engine');

class RenderEngine extends EngineStore<RenderEngineState> {
  // TODO: don't expose the context to consumers; a limited API has better guarantees
  CanvasRenderingContext2D _canvasContext;
  RenderingContext _renderingContext;

  // Note: ignoring close_sinks because this is managed
  // ignore: close_sinks
  StreamController<Null> _didResizeController =
      new StreamController<Null>.broadcast();

  Action<Renderable> addRenderable = new Action<Renderable>();

  RenderEngine() : super() {
    manageStreamController(_didResizeController);
    [
      addRenderable,
      step,
    ].forEach(manageAction);

    [
      addRenderable.listen(_addRenderable),
      step.listen((_) => onStep()),
      window.onResize.listen(_onWindowResize),
    ].forEach(manageStreamSubscription);
  }

  /// Event fired when the window resizes.
  ///
  /// There is no payload as the state should be checked for the
  /// most up-to-date dimensions.
  Stream<Null> get didResize => _didResizeController.stream;

  Future<Null> load() async {
    _logger.info('loading');
    CanvasElement canvasElement =
        document.querySelector('.canvas') as CanvasElement;
    _canvasContext = canvasElement.context2D;
    _renderingContext = new RenderingContext(_canvasContext);
  }

  @override
  void onStep() {
    _logger.info('rendering');

    _renderingContext.fillRect(0, 0, state.width, state.height,
        color: canvasColor);

    // TODO: render in layers
    state.assets.forEach((asset) {
      asset.render(_renderingContext, state);
    });

    _canvasContext.restore();
    window.requestAnimationFrame((_) => onStep());
  }

  void _addRenderable(Renderable renderable) {
    trigger((state.toBuilder()..assets.add(renderable)).build());
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
