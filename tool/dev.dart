library tool.dev;

import 'dart:async';
import 'package:dart_dev/dart_dev.dart' show dev, config;

Future main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  // Perform task configuration here as necessary.

  // Available task configurations:
  config.analyze
    ..strong = true
    ..entryPoints = ['lib/engine.dart'];

  // config.copyLicense
  // config.coverage
  // config.docs
  // config.examples
  config.format..paths = ['lib/engine.dart', 'example/web/main.dart'];
  // config.test

  await dev(args);
}
