part of atoms;

//
// Atom Hooks
//

T useAtomVariable<T>(StateNotifierProvider<AtomVariable<T>> atomVariable) =>
    useProvider(atomVariable.state);

T useAtomConstant<T>(Provider<AtomConstant<T>> atomConstant) =>
    useProvider(atomConstant).value;

bool Function() useAtomCondition(Provider<AtomCondition> atomCondition) =>
    useProvider(atomCondition).test;

bool Function(T) useAtomConditionWith<T>(
        Provider<AtomConditionWith<T>> atomCondition) =>
    useProvider(atomCondition).test;

void useAtomEvent<T>(
  Provider<AtomEvent<T>> atomEvent,
  ValueCallback<T> listener,
) {
  final context = useContext();
  useEffect(
    () => context.read(atomEvent).register(listener),
    [context, atomEvent, listener],
  );
}

void useAtomPairEvent<T, K>(
  Provider<AtomPairEvent<T, K>> atomPairEvent,
  PairCallback<T, K> listener,
) {
  final context = useContext();
  useEffect(
    () => context.read(atomPairEvent).register(listener),
    [context, atomPairEvent, listener],
  );
}

void useAtomVoidEvent(
  Provider<AtomVoidEvent> atomEvent,
  VoidCallback listener,
) {
  final context = useContext();
  useEffect(
    () => context.read(atomEvent).register(listener),
    [context, atomEvent, listener],
  );
}
