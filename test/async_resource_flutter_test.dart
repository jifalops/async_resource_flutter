import 'package:flutter_test/flutter_test.dart';
import 'package:async_resource_flutter/async_resource_flutter.dart';

void main() {
  final stringRes = StringPrefsResource('string');
  final boolRes = BoolPrefsResource('bool');
  final intRes = IntPrefsResource('int');
  final doubleRes = DoublePrefsResource('double');
  final stringListRes = StringListPrefsResource('list');
  test('adds one to input values', () async {
    expect('', await stringRes.get());
    // final calculator = new Calculator();
    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
    // expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });
}
