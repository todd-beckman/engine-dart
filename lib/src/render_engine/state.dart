import 'package:engine_dart/flux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:engine_dart/engine.dart';

import 'renderable.dart';

/// The immutable state of the current UI.
class RenderEngineState extends EngineState {
  BuiltList<Renderable> assets;

  RenderEngineState.initial() {
    assets = new BuiltList<Renderable>();
  }

  RenderEngineState._({BuiltList<Renderable> assets})
    : this.assets = assets;

  factory RenderEngineState.build(RenderEngineStateBuilder builder) {
    return builder.build();
  }

  @override
  RenderEngineStateBuilder toBuilder() {
    return new RenderEngineStateBuilder()
      ..assets = assets.toBuilder();
  }
}

/// The builder associated with a [RenderEngineState]
class RenderEngineStateBuilder extends StateBuilder<RenderEngineState> {
  ListBuilder<Renderable> assets;

  @override
  RenderEngineState build() {
    return new RenderEngineState._(
      assets: assets.build(),
    );
  }
}