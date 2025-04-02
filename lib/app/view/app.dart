import 'package:derosa_pay25/home/home.dart';
import 'package:derosa_pay25/make_payment/view/make_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_repository/payment_repository.dart';

class App extends StatelessWidget {
  const App({required PaymentRepository paymentRepository, super.key})
      : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _paymentRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
