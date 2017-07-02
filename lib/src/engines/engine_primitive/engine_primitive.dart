import 'package:engine_dart/flux.dart';

abstract class EngineState extends State {}

abstract class EngineStore<TState extends EngineState> extends Store<TState> {
  final Action<Null> step = new Action();

  EngineStore() {
    [
      step,
    ].forEach(manageAction);

    [
      step.listen((_) => onStep),
    ].forEach(manageStreamSubscription);
  }

  @override
  TState get initialState;

  void onStep();
}
