import 'dart:async';

import 'package:engine_dart/flux.dart';

abstract class EngineState extends State {}

abstract class EngineStore<TState extends EngineState> extends Store<TState> {
  final Action<Null> step = new Action();

  EngineStore() {
    manageAction(step);
  }

  /// Loads the engine.
  ///
  /// Children of this class should override [onLoad] while
  /// consumers should call [load].
  Future<Null> load() async {
    manageStreamSubscription(step.listen((_) => _step()));
    await onLoad();
  }

  @override
  TState get initialState;

  /// An event that is fired once during loading.
  Future<Null> onLoad() async {}

  /// An event that occurs once per step.
  ///
  /// All logic should occur in this step.
  void onStep();

  void _step() => onStep();
}
