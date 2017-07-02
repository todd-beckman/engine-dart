import 'package:engine_dart/flux.dart';

class EngineActions extends ActionCollection {
  final Action<Null> step = new Action();

  EngineActions() {
    [
      step,
    ].forEach(manageAction);
  }
}