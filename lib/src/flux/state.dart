/// A [State] is intended as the parent to an immutable structure representing the
/// public API for the flux store.
/// 
/// All fields of a [State] should be immutable. Use of built_collection is
/// recommended but not required.
abstract class State {

  bool get invalidated => _invalidated;
  bool _invalidated = false;

  void invalidate() {
    _invalidated = true;
  }

  StateBuilder toBuilder();
}

/// The [StateBuilder] allows for use of the builder pattern.
/// 
/// Expected consumption is to [build] a [TState] using a private constructor.
abstract class StateBuilder<TState extends State> {
  TState build();
}