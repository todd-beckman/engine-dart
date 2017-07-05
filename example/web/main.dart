import 'dart:async';
import 'dart:html';

import 'package:logging/logging.dart';
import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;

import 'package:engine_dart/engine.dart' as ed;

Future<Null> main() async {
  react_client.setClientConfiguration();
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) => print(record));

  var engine = new ed.RenderEngine();

  var canvas = ed.renderCanvas()..renderEngine = engine;

  react_dom.render(canvas(), querySelector('#body'));

  await engine.load().then((_) {
    engine.toggleFpsMonitor(null);
    engine.step(null);
  });
}
