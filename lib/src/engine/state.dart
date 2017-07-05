import 'dart:html';
import 'package:meta/meta.dart';

import 'package:engine_dart/engine.dart';

// TODO: use built_collections and built_value
class EngineState implements BuiltState {
  final List<ActorState> actors;
  final int width;
  final int height;
  final bool showFpsMonitor;

  EngineState._({
    @required this.actors,
    @required this.width,
    @required this.height,
    @required this.showFpsMonitor,
  });

  EngineState.initial({
    assets,
    width,
    height,
    this.showFpsMonitor: false,
  }) : actors = new List<ActorState>(),
    this.width = width ?? window.innerWidth,
    this.height = height ?? window.innerHeight;

  @override
  EngineStateBuilder toBuilder() {
    return new EngineStateBuilder()
      ..actors = actors
      ..width = width
      ..height = height
      ..showFpsMonitor = showFpsMonitor;
  }
}

class EngineStateBuilder implements StateBuilder<EngineState> {
  List<ActorState> actors;
  int width;
  int height;
  bool showFpsMonitor;


  @override
  EngineState build() {
    return new EngineState._(
      actors: actors,
      width: width,
      height: height,
      showFpsMonitor: showFpsMonitor,
    );
  }
}
