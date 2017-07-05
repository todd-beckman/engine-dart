import 'dart:async';

import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'engine.dart';

@Factory()
UiFactory<RenderCanvasProps> renderCanvas;

@Props()
class RenderCanvasProps extends UiProps {
  @requiredProp
  EngineStore engine;
}

@Component()
class RenderCanvasComponent extends UiComponent<RenderCanvasProps> {
  List<StreamSubscription> _subs = <StreamSubscription>[];

  @override
  void componentDidMount() {
    _subs.add(props.engine.didResize.listen((_) => redraw()));
  }

  @override
  void componentWillUnmount() {
    _subs.forEach((sub) => sub.cancel());
    _subs.clear();
  }

  @override
  ReactElement render() {
    return (Dom.canvas()
      ..className = 'canvas'
      ..width = props.engine.state.width
      ..height = props.engine.state.height)();
  }
}
