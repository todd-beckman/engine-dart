import 'dart:html';

import 'package:engine_dart/engine.dart';
import 'package:engine_dart/flux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import 'renderable.dart';

/// The immutable state of the current UI.
class RenderEngineState extends EngineState implements BuiltState {
  BuiltList<Renderable> _assets;
  final int width;
  final int height;

  RenderEngineState.initial({
    width,
    height,
  })
      : this.width = width ?? window.innerWidth,
        this.height = height ?? window.innerHeight {
    _assets = new BuiltList<Renderable>();
  }

  RenderEngineState._({
    @required BuiltList<Renderable> assets,
    @required this.width,
    @required this.height,
  })
      : _assets = assets;

  BuiltList<Renderable> get assets => _assets;

  @override
  RenderEngineStateBuilder toBuilder() {
    return new RenderEngineStateBuilder()
      ..assets = assets.toBuilder()
      ..width = width
      ..height = height;
  }
}

/// The builder associated with a [RenderEngineState]
class RenderEngineStateBuilder extends StateBuilder<RenderEngineState> {
  ListBuilder<Renderable> assets;
  int width;
  int height;

  @override
  RenderEngineState build() {
    return new RenderEngineState._(
      assets: assets.build(),
      width: width,
      height: height,
    );
  }
}
