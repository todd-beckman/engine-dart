part of engine.flux;

/// A [State] is intended as the parent to an immutable structure representing
/// the public API for the flux store.
///
/// Use of built_collection for collections is recommended but not required.
/// For complex states, a [BuiltState] is recommend.
@immutable
abstract class State {}

/// A [State] which follows the builder pattern.
///
/// Build a new [StateBuilder] from this one, and use that to build a new 
/// [BuiltState].
abstract class BuiltState extends State {
  StateBuilder toBuilder();
}

/// The [StateBuilder] allows for use of the builder pattern.
///
/// Expected consumption is to [build] a [TState] using a private constructor.
abstract class StateBuilder<TState extends BuiltState> {
  TState build();
}
