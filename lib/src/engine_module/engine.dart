import 'package:engine_dart/flux.dart';
import 'package:engine_dart/fps.dart';

class EngineState extends State {
  final FpsState fps;

  EngineState._(this.fps);
}

class EngineStore extends Store<EngineState> {
  final Action<Null> step = new Action();

  FpsMonitor _fps;

  EngineStore(actions) {
    [
      _fps = new FpsMonitor(),
    ].forEach(manageDisposable);

    [
      step,
    ].forEach(manageAction);

    [
      _fps.listen(_fpsTrigger),
      actions.step.listen(_step),
    ].forEach(manageStreamSubscription);
  }

  @override
  EngineState get initialState => new EngineState._(_fps.state);

  void _fpsTrigger(FpsState newState) {
    trigger(new EngineState._(newState));
  }

  void _step(_) {
    _fps.step(null);
  }
}