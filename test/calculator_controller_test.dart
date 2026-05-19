import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:la_central_del_norte/controllers/calculator_controller.dart';

void main() {
  group('CalculatorController.calculate', () {
    test('returns null when price text is not numeric', () {
      final result = CalculatorController.calculate(
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 11, minute: 0),
        priceText: 'abc',
      );

      expect(result, isNull);
    });
  });
}
