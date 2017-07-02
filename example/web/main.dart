import 'dart:async';
import 'dart:html';

import 'package:logging/logging.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

import 'package:engine_dart/engine.dart';

Future<Null> main() async {
  react_client.setClientConfiguration();
  hierarchicalLoggingEnabled = true;

  var engine = new RenderEngine();

  bool shouldContinue = true;
  while (shouldContinue) {
    window.requestAnimationFrame((_) => engine.step(null));
  }
}