import 'dart:async';
import 'dart:html';

import 'package:logging/logging.dart';
import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;

import 'package:engine_dart/engine.dart';
import 'package:engine_dart/fps.dart';

Future<Null> main() async {
  react_client.setClientConfiguration();
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) => print(record));

  var engine = new RenderEngine();

  var fps = new FpsMonitor();

  var canvas = renderCanvas()..renderEngine = engine;

  react_dom.render(canvas(), querySelector('#body'));

  await engine.load().then((_) {
    engine.addRenderable(new FpsComponent(fps));
    engine.step(null);
  });
}
