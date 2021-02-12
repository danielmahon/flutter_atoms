part of flutter_atoms;

//
// Sample Atoms (Providers)
//

final scaffoldKeyProvider =
    Provider((ref) => GlobalKey<ScaffoldMessengerState>());

final intVariable = createAtomVariable(10);
final stringVariable = createAtomVariable(
  'hello world',
  changedEvent: stringEvent,
  changedWithHistoryEvent: stringPairEvent,
);
final voidEvent = createAtomVoidEvent();
final stringEvent = createAtomEvent<String>();
final stringConstant = createAtomConstant('FOO BAR');
final stringPairEvent = createAtomPairEvent<String, String>();
final testCondition = createAtomConditionWith<String>((read, value) {
  final constant = read(stringConstant).value;
  return constant == value;
});
final testVoidCondition = createAtomCondition((read) {
  final constant = read(stringConstant).value;
  return constant == 'FOO BAR';
});

//
// Sample Widget
//

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

class AtomTest extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = useProvider(scaffoldKeyProvider);
    final myInt = useAtomVariable(intVariable);
    final myString = useAtomVariable(stringVariable);
    final myConstant = useAtomConstant(stringConstant);
    final isConditionPassed = useAtomConditionWith(testCondition);
    final isCondition2Passed = useAtomCondition(testVoidCondition);

    useAtomVoidEvent(voidEvent, () {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('VOID EVENT RAISED')),
      );
    });

    useAtomEvent(stringEvent, (String value) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('STRING EVENT RAISED: $value')),
      );
    });

    useAtomPairEvent(stringPairEvent, (String previous, String current) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('previous: $previous | current: $current')),
      );
    });

    print('BUILD AtomTest');

    if (isConditionPassed('FOO BAR')) {
      print('TEST PASSED');
    }

    if (isCondition2Passed()) {
      print('TEST 2 PASSED');
    }

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Atom Test', style: Theme.of(context).textTheme.headline5),
            Text('AtomConstant<${myConstant.runtimeType}>: $myConstant'),
            ElevatedButton(
              onPressed: () => context.read(intVariable).value =
                  DateTime.now().millisecondsSinceEpoch,
              child: const Text('Update Atom Variable'),
            ),
            Text('AtomVariable<${myInt.runtimeType}>: $myInt'),
            ElevatedButton(
              onPressed: () => context.read(stringVariable).value =
                  DateTime.now().second.toString(),
              child: const Text('Update Atom Variable'),
            ),
            Text('AtomVariable<${myString.runtimeType}>: $myString'),
            ElevatedButton(
              onPressed: () => context.read(voidEvent).raise(),
              child: const Text('Raise Atom Void Event'),
            ),
            ElevatedButton(
              onPressed: () => context.read(stringEvent).raise('hello world'),
              child: const Text('Raise Atom String Event'),
            ),
          ],
        ),
      ),
    );
  }
}
