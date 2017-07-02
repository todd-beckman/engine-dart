import 'dart:async';
import 'dart:html';

import 'package:logging/logging.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

import 'package:engine_dart/engine.dart';

main() async {
  react_client.setClientConfiguration();
  hierarchicalLoggingEnabled = true;

  var engine = new Engine();
  engine.load();

  react_dom.render(engine.components.content(), querySelector('#body'));

  while (true) {
    await new Future.delayed(new Duration(milliseconds: 10));
    engine.api.step();
  }
}