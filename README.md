# Engine-Dart

This project is intended to be an implementation of a basic
game engine written in Dart. It is not ready for consumption.

## Development

There are plans to leverage [built_value.dart](https://github.com/google/built_value.dart)
for state management. Though this is not yet set up, this
does enforce strong mode for this project. Consumers should
also use strong mode to maintain the static guarantees of
built values and collections.

This package makes use of [dart_dev](https://github.com/Workiva/dart_dev).

Helpful commands:
- Dependencies:`pub get`
- Analysis

See the [Examples Readme](example/README.md) for running
instructions.
