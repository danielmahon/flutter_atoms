library atoms;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'classes.dart';
part 'example.dart';
part 'hooks.dart';
part 'typedefs.dart';

//
// Atom Provider Factories
//

Provider<AtomEvent<T>> createAtomEvent<T>() =>
    Provider((ref) => AtomEvent(), name: 'AtomEvent<${T.toString()}>');

Provider<AtomPairEvent<T, K>> createAtomPairEvent<T, K>() =>
    Provider((ref) => AtomPairEvent(),
        name: 'AtomPairEvent<${T.toString()},${K.toString()}>');

Provider<AtomVoidEvent> createAtomVoidEvent() =>
    Provider((ref) => AtomVoidEvent(), name: 'AtomVoidEvent');

Provider<AtomConstant<T>> createAtomConstant<T>(T value) =>
    Provider((ref) => AtomConstant(value),
        name: 'AtomConstant<${T.toString()}>');

Provider<AtomConditionWith<T>> createAtomConditionWith<T>(
  AtomComparatorWith<T> comparator,
) =>
    Provider((ref) => AtomConditionWith(ref.read, comparator),
        name: 'AtomCondition');

Provider<AtomCondition> createAtomCondition(
  AtomComparator comparator,
) =>
    Provider((ref) => AtomCondition(ref.read, comparator),
        name: 'AtomCondition');

StateNotifierProvider<AtomVariable<T>> createAtomVariable<T>(
  T initialValue, {
  Provider<AtomEvent<T>> changedEvent,
  Provider<AtomPairEvent<T, T>> changedWithHistoryEvent,
}) =>
    StateNotifierProvider(
      (ref) => AtomVariable(
          initialValue, changedEvent, changedWithHistoryEvent, ref.read),
      name: 'AtomVariable<${T.toString()}>',
    );

// extension BuildContextX on BuildContext {
//   T atom<T>(ProviderBase<Object, T> provider) {
//     return ProviderScope.containerOf(this, listen: false).read(provider);
//   }
// }
