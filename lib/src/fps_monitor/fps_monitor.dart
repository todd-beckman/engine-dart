import 'package:logging/logging.dart';
import 'package:engine_dart/flux.dart';

import 'state.dart';

var _logger = new Logger('fps monitor');

class FpsMonitor extends Store<FpsState> {
  final Action<Null> step = new Action<Null>();

  DateTime _lastKeyFrame;
  int _stepsSinceKeyFrame = 0;

  FpsMonitor() {
    _lastKeyFrame = new DateTime.now();
    manageAction(step);
    manageStreamSubscription(step.listen(_stepHandler));
  }

  @override
  FpsState get initialState => new FpsState();

  void _stepHandler(_) {
    _stepsSinceKeyFrame++;

    var now = new DateTime.now();
    if (now.difference(_lastKeyFrame).inSeconds >= 1) {
      var framesPerSecond = _stepsSinceKeyFrame;
      _stepsSinceKeyFrame = 0;
      _lastKeyFrame = now;
      trigger(new FpsState(framesPerSecond: framesPerSecond));
    }
  }
}
