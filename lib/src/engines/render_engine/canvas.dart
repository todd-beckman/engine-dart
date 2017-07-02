import 'dart:async';

import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'render_engine.dart';

@Factory()
UiFactory<RenderCanvasProps> renderCanvas;

@Props()
class RenderCanvasProps extends UiProps {
  @requiredProp
  RenderEngine renderEngine;
}

@Component()
class RenderCanvasComponent extends UiComponent<RenderCanvasProps> {
  List<StreamSubscription> _subs = <StreamSubscription>[];

  @override
  void componentDidMount() {
    _subs.add(props.renderEngine.didResize.listen((_) => redraw()));
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
      ..width = props.renderEngine.state.width
      ..height = props.renderEngine.state.height)();
  }
}
