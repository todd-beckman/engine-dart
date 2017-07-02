import 'dart:async';
import 'package:w_common/disposable.dart';

/// A collection of [Action]s, all of which should be declared final.
///
/// For best memory management practices, all [ActionCollection]s should
/// call [manageAction] on all of their actions so that when this object
/// is disposed, so are all actiosn in the collection.
///
/// Stores can optionally extend this class directly.
abstract class ActionCollection extends Disposable {
  List<Action> _managedActions = <Action>[];

  /// Flags the given [action] for disposal when this collection id disposed.
  Action manageAction(Action action) {
    _managedActions.add(action);
    return action;
  }

  @override
  Future<Null> onDispose() async {
    _managedActions.forEach((action) {
      if (action != null && !action.isDisposed) {
        action.dispose();
      }
    });
  }
}

/// A typed API call to be listened to by a Store.
///
/// These should be declared as final variables in an [ActionCollection].
class Action<TPayload> extends Disposable {
  StreamController<TPayload> _actionController =
      new StreamController<TPayload>.broadcast();

  Action() {
    manageStreamController(_actionController);
  }

  void call(TPayload payload) {
    _actionController.add(payload);
  }

  StreamSubscription<TPayload> listen(void callback(TPayload payload)) {
    return _actionController.stream.listen(callback);
  }
}
