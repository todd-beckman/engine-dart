import 'package:engine_dart/engine.dart';

import 'fps_monitor.dart';

class FpsComponent implements Renderable {
  FpsMonitor _monitor;

  FpsComponent() {
    _monitor = new FpsMonitor();
  }

  @override
  void render(RenderingContext context, RenderEngineState state) {
    context.font = '14pt Cambria';
    context.fillText(_fpsToString(), 3, state.height - 3);
  }

  String _fpsToString() {
    return 'FPS: ${_monitor.state.framesPerSecond}';
  }
}
