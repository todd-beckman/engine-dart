import 'dart:async';
import 'package:w_common/disposable.dart';

import 'actions.dart';
import 'state.dart';

/// A [Store] responds to [Action]s and streams the changed [State]
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
    _state?.invalidate();
    _state = newState;
    _triggerController.add(newState);
  }
}
