import 'package:payment_repository/payment_repository.dart';
import 'package:tester_app/app/app.dart';
import 'package:tester_app/bootstrap.dart';

void main() {
  const paymentRepository = PaymentRepository();

  bootstrap(() => const App(
        paymentRepository: paymentRepository,
      ));
}
