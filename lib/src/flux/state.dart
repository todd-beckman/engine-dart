/// A [State] is intended as the parent to an immutable structure representing the
/// public API for the flux store.
/// 
/// All fields of a [State] should be declared final to preserve immutability.
abstract class State {

  bool get invalidated => _invalidated;
  bool _invalidated = false;

  void invalidate() {
    _invalidated = true;
  }
}