import 'dart:async';
import 'dart:html';

import 'package:engine_dart/engine.dart';
import 'package:logging/logging.dart';

Logger _logger = new Logger('logic engine');

class EngineActions extends ActionCollection {
  /// Adds an actor to the game.
  /// 
  /// The actor will not receive a [step] until the next step.
  final Action<Actor> addActor;

  /// Removes an actor from the game.
  /// 
  /// The actor will not be removed until the next [step].
  final Action<Actor> removeActor;

  /// Renders the current state.
  /// 
  /// This will only render the most recently completed [step], not the current one.
  final Action<Actor> render;

  ///
  final Action<Null> step;

  final Action<bool> toggleFpsMonitor;

  EngineActions() :
      addActor = new Action<Actor>(),
      removeActor = new Action<Actor>(),
      render = new Action<Actor>(),
      step = new Action<Null>(),
      toggleFpsMonitor = new Action<bool>() {
    [
      addActor,
      removeActor,
      render,
      step,
      toggleFpsMonitor,
    ].forEach(manageAction);
  }
}

class EngineStore extends BuiltStore<EngineState, EngineStateBuilder> {

  final EngineActions api;

  /// Shows or hides the FPS monitor.
  /// 
  /// 
  Action<RenderableMixin> toggleFpsMonitor;


  // TODO: group the actors by priority level
  List<Actor> _actors;

  CanvasRenderingContext2D _canvasContext;

  // Note: ignoring close_sinks because this is managed
  // ignore: close_sinks
  StreamController<Null> _didResizeController;

  FpsMonitor _fpsMonitor;

  RenderingContext _renderingContext;

  EngineStore() : api = new EngineActions() {
    [
      _fpsMonitor = new FpsMonitor(),
      _didResizeController = new StreamController<Null>.broadcast(),
    ].forEach(manageDisposable);
  }

  /// Event fired when the window resizes.
  ///
  /// There is no payload as the state should be checked for the
  /// most up-to-date dimensions.
  Stream<Null> get didResize => _didResizeController.stream;

  @override
  EngineState get initialState => new EngineState.initial();

  Future<Null> load() async {
    CanvasElement canvasElement =
        document.querySelector('.canvas') as CanvasElement;
    _canvasContext = canvasElement.context2D;
    _renderingContext = new RenderingContext(_canvasContext);

    [
      api.addActor.listen(_addActor),
      api.removeActor.listen(_removeActor),
      api.render.listen((_) => _render()),
      api.toggleFpsMonitor.listen((_) => _toggleFpsMonitor()),
      api.step.listen((_) => _step()),
      window.onResize.listen(_onWindowResize),
    ].forEach(manageStreamSubscription);
  }

  void _render() {
    _renderingContext.fillRect(0, 0, state.width, state.height,
    color: canvasColor);

    _fpsMonitor.step(null);

    if (state.showFpsMonitor) {
      _fpsMonitor.render(_renderingContext, state);
    }

    // TODO: render in layers
    state.actors.forEach((asset) {
      asset.render(_renderingContext, state);
    });

    window.requestAnimationFrame((_) => _render());
  }

  // TODO: an implementation that allows actors to interact
  void _step() {
    var shouldDestroy = <Actor>[];
    var shouldRender = <ActorState>[];
    _actors.forEach((actor) {
      actor.step(state);
      if (actor.state.shouldDestroySelf) {
        shouldDestroy.add(actor);
      } else if (actor.state.shouldRenderSelf) {
        shouldRender.add(actor.state);
      }
    });

    // Only remove after all actor steps to prevent race conditions
    shouldDestroy.forEach(_actors.remove);

    setState(state.toBuilder()
      ..actors = shouldRender
    );
  }

  void _addActor(Actor actor) => _actors.add(actor);

  void _onWindowResize(e) {
    trigger((state.toBuilder()
          ..width = window.innerWidth
          ..height = window.innerHeight)
        .build());
    _didResizeController.add(null);
  }

  void _removeActor(Actor actor) => _actors.remove(actor);

  void _toggleFpsMonitor() {
    setState(state.toBuilder()..showFpsMonitor = !state.showFpsMonitor);
  }
}
