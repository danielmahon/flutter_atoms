import 'package:flutter_test/flutter_test.dart';

class Calculator {
  int value = 0;
  int addOne(int addition) {
    return value += addition;
  }
}

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
