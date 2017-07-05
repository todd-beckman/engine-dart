import 'package:engine_dart/engine.dart';

/// Any object which steps once per logical frame.
/// 
/// In order to prevent inconsistent behavior, the logical state should not
/// depend on the rendering engine's state.
abstract class Actor<TState extends ActorState> extends Store<TState> with RenderableMixin<TState> {
  void step(EngineState state);
}

/// A state which will conditionally destroy itself.
abstract class ActorState extends RenderableState {
  /// Flags the [Actor] for destruction by the logic engine.
  bool get shouldDestroySelf;

  /// Flags the [Actor] as one that should be rendered.
  bool get shouldRenderSelf;
}
