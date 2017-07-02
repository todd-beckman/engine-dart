import 'state.dart';

abstract class Actor {
  void step(LogicEngineState state);
}
