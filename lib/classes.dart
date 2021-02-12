part of flutter_atoms;

//
// Atom Classes
//

class AtomConditionWith<T> {
  AtomConditionWith(this.read, this.comparator);

  Reader read;
  AtomComparatorWith<T> comparator;

  bool test([T value]) => comparator(read, value);
}

class AtomCondition {
  AtomCondition(this.read, this.comparator);

  Reader read;
  AtomComparator comparator;

  bool test() => comparator(read);
}

class AtomEvent<T> {
  final listeners = <ValueCallback<T>>{};

  void raise(T value) {
    for (final listener in listeners) {
      listener(value);
    }
  }

  VoidCallback register(ValueCallback<T> listener) {
    listeners.add(listener);
    return () => unregister(listener);
  }

  void unregister(ValueCallback<T> listener) {
    listeners.remove(listener);
  }
}

class AtomPairEvent<T, K> {
  final listeners = <PairCallback<T, K>>{};

  void raise(T previous, K next) {
    for (final listener in listeners) {
      listener(previous, next);
    }
  }

  VoidCallback register(PairCallback<T, K> listener) {
    listeners.add(listener);
    return () => unregister(listener);
  }

  void unregister(PairCallback<T, K> listener) {
    listeners.remove(listener);
  }
}

class AtomVoidEvent {
  final listeners = <VoidCallback>{};

  void raise() {
    for (final listener in listeners) {
      listener();
    }
  }

  VoidCallback register(VoidCallback listener) {
    listeners.add(listener);
    return () => unregister(listener);
  }

  void unregister(VoidCallback listener) {
    listeners.remove(listener);
  }
}

class AtomVariable<T> extends StateNotifier<T> {
  AtomVariable(
    T initialValue,
    this.changedEvent,
    this.changedWithHistoryEvent,
    this.read,
  ) : super(initialValue);

  Reader read;
  Provider<AtomEvent<T>> changedEvent;
  Provider<AtomPairEvent<T, T>> changedWithHistoryEvent;

  T get value => state;

  set value(T value) {
    if (value == state) return;
    if (changedEvent != null) {
      read(changedEvent).raise(value);
    }
    if (changedWithHistoryEvent != null) {
      read(changedWithHistoryEvent).raise(state, value);
    }
    state = value;
  }
}

class AtomConstant<T> {
  AtomConstant(T value) : _value = value;
  final T _value;
  T get value => _value;
}
