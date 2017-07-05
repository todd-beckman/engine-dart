part of engine.flux;

/// A [Store] responds to [Action]s and streams the changed [State]
/// 
/// When constructing a store, be sure to use `manageDisposable` and
/// `manageStreamSubscription` for best memory management practices. All
/// fields which are not disposable should be nulled out in an `onDisposed`
/// handler.
abstract class Store<TState extends State> extends ActionCollection {
  TState _state;
  StreamController<TState> _triggerController =
      new StreamController<TState>.broadcast();

  Store() {
    manageStreamController(_triggerController);
    _state = initialState;
  }

  TState get initialState;
  TState get state => _state;

  StreamSubscription<TState> listen(void callback(TState state)) =>
      _triggerController.stream.listen(callback);

  void trigger(TState newState) {
    _state = newState;
    _triggerController.add(newState);
  }
}

/// 
/// The recommended means of updating a [BuiltStore] is to call:
/// 
/// ```
/// trigger(state.toBuilder()
///   ..changingProp = newValue
///   ..otherChangingProp = otherNewValue);
/// ```
/// 
/// Any fields on the builder that are not updated will be inherited from the
/// current state.
abstract class BuiltStore
  <TState extends BuiltState, TBuilder extends StateBuilder<TState>>
    extends Store<TState> {

  void setState(TBuilder builder) {
    trigger(builder.build());
  }
}

