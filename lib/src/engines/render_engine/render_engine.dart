import 'dart:html';

import 'package:engine_dart/engine.dart';

import 'state.dart';

class RenderEngine extends EngineStore<RenderEngineState> {
  // TODO: don't expose the context to consumers; a limited API has better guarantees
  CanvasRenderingContext2D _context;

  RenderEngine() {
    CanvasElement canvasElement =
        document.querySelector('#canvas') as CanvasElement;
    _context = canvasElement.context2D;
  }

  @override
  void onStep() {
    // TODO: render in layers
    state.assets.forEach((asset) {
      asset.render(_context);
    });
  }

  @override
  RenderEngineState get initialState => new RenderEngineState.initial();
}
