# ⚛️ Flutter Atoms

_(WORK IN PROGRESS)_

A simple state management solution inspired by [Unity Atoms](https://unity-atoms.github.io/unity-atoms/) and built on [riverpod](https://pub.dev/packages/riverpod) and [flutter_hooks](https://pub.dev/packages/flutter_hooks)

This is bascially a thin wrapper on top of `riverpod` providers that exposes some preset factory functions to generate simple providers. Is it worth it?! I dunno. Feel free to let me know if you think it's worth continuing to develop.

FYI: You can do everything this package can do directly with `riverpod` providers.

## Features

- [x] Void Events
- [x] Value Events
- [x] Pair Events (Value events with history)
- [x] Variables (`StateNotifiers` with optional events)
- [x] Constants (immutable variables)
- [x] Void Conditions (pointless?)
- [x] Value Conditions (reusable conditions)

## Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_atoms/flutter_atoms.dart';

final changedEvent = createAtomEvent<String>();
final changedHistoryEvent = createAtomPairEvent<String, String>();
final textVariable = createAtomVariable(
  'hello world',
  changedEvent: changedEvent,
  changedWithHistoryEvent: changedHistoryEvent,
);

class AtomsExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useAtomEvent(changedEvent, (String value) {
      print('Text Updated: $value');
    });

    return Center(
      child: ElevatedButton(
        onPressed: () => context.read(changedEvent).raise('foo bar'),
        child: const Text('Update Text'),
      ),
    );
  }
}

class SomeOtherClass extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final myText = useAtomVariable(textVariable);

    useAtomPairEvent(changedHistoryEvent, (String previous, String current) {
      print('Text Updated from "$previous" to "$current"');
    });

    return Center(child: Text(myText));
  }
}

```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
