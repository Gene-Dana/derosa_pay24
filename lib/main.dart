import 'package:derosa_pay25/app/view/app.dart';
import 'package:flutter/material.dart';

import 'package:derosa_pay25/bootstrap.dart';
import 'package:payment_repository/payment_repository.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  const paymentRepository = PaymentRepository();

  await bootstrap(
    () => const App(
      paymentRepository: paymentRepository,
    ),
  );
}
