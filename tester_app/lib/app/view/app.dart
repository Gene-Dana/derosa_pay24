import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_repository/payment_repository.dart';
import 'package:tester_app/counter/counter.dart';
import 'package:tester_app/l10n/l10n.dart';
import 'package:tester_app/make_payment/view/make_payment.dart';

class App extends StatelessWidget {
  const App({required PaymentRepository paymentRepository, super.key})
      : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepositoryProvider(
        create: (context) => const PaymentRepository(),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MakePayment();
  }
}
