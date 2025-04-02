// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:payment_repository/payment_repository.dart';

void main() {
  group('PaymentRepository', () {
    test('can be instantiated', () {
      expect(PaymentRepository(), isNotNull);
    });
  });
}
