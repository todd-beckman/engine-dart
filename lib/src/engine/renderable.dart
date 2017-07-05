import 'package:engine_dart/engine.dart';

/// A mixin intended for Actors to enable ease of rendering.
abstract class RenderableMixin<TState extends RenderableState> {
  TState get state;

  /// Care must be taken if overriding this method to render an immutable
  /// State.
  void render(RenderingContext context, EngineState renderingState) {
    state.render(context, renderingState);
  }
}

/// A state which may be rendered.
abstract class RenderableState extends State {
  void render(RenderingContext context, EngineState state);
}
