import 'context.dart';
import 'state.dart';

abstract class Renderable {
  void render(RenderingContext context, RenderEngineState state);
}
