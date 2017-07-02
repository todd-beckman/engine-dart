import 'package:built_collection/built_collection.dart';
import 'package:engine_dart/flux.dart';
import 'package:engine_dart/engine.dart';

import 'actor.dart';

class LogicEngineState extends EngineState implements BuiltState {
  final BuiltList<Actor> actors;

  LogicEngineState._({this.actors});

  LogicEngineState.initial() : actors = new BuiltList<Actor>();

  @override
  LogicEngineStateBuilder toBuilder() {
    return new LogicEngineStateBuilder()..actors = actors.toBuilder();
  }
}

class LogicEngineStateBuilder extends StateBuilder<LogicEngineState> {
  ListBuilder<Actor> actors;

  @override
  LogicEngineState build() {
    return new LogicEngineState._(
      actors: actors.build(),
    );
  }
}
