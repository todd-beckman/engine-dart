import 'package:logging/logging.dart';
import 'package:engine_dart/flux.dart';

var _logger = new Logger('fps monitor');

const int fpsRefreshRateInSeconds = 3;
const Duration fpsRefreshRate = const Duration(seconds: fpsRefreshRateInSeconds);

class FpsState extends State {
  final double framesPerSecond;

  FpsState._(this.framesPerSecond) : super();
}

class FpsMonitor extends Store<FpsState> {
  final Action<Null> step = new Action<Null>();

  DateTime _lastKeyFrame;
  int stepCountSinceKeyFrame = 0;

  FpsMonitor() {
    _lastKeyFrame = new DateTime.now();
    manageAction(step);
    manageStreamSubscription(step.listen(_stepHandler));
  }

  @override
  FpsState get initialState => new FpsState._(0.0);
  
  void _stepHandler(_) {
    _logger.info('fps');
    stepCountSinceKeyFrame++;

    var now = new DateTime.now();
    if (now.difference(_lastKeyFrame) >= fpsRefreshRate) {
      var framesPerSecond = stepCountSinceKeyFrame.toDouble() / fpsRefreshRateInSeconds.toDouble();

      _logger.info('updating fps to ${framesPerSecond}');
      trigger(new FpsState._(framesPerSecond));
    }
  }
}

