import 'dart:async';

import 'package:engine_dart/engine.dart';
import 'package:engine_dart/flux.dart';
import 'package:logging/logging.dart';

import 'actor.dart';
import 'state.dart';

Logger _logger = new Logger('logic engine');

class LogicEngine extends EngineStore<LogicEngineState> {
  Action<Actor> addActor = new Action<Actor>();
  Action<Actor> removeActor = new Action<Actor>();

  LogicEngine() {
    [addActor, removeActor].forEach(manageAction);
  }

  @override
  LogicEngineState get initialState => new LogicEngineState.initial();

  @override
  Future<Null> onLoad() async {
    [
      addActor.listen(_addActor),
      removeActor.listen(_removeActor),
    ].forEach(manageStreamSubscription);
  }

  @override
  void onStep() {
    state.actors.forEach((actor) {
      actor.step(state);
    });
  }

  void _addActor(Actor actor) =>
      trigger((state.toBuilder()..actors.add(actor)).build());

  void _removeActor(Actor actor) =>
      trigger((state.toBuilder()..actors.remove(actor)).build());
}
