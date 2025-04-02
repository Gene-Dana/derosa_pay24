import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_repository/payment_repository.dart';
import 'package:tester_app/make_payment/make_payment.dart';

class MakePayment extends StatelessWidget {
  const MakePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MakePaymentBloc(paymentRepository: context.read<PaymentRepository>()),
      child: const MakePaymentView(),
    );
  }
}

class MakePaymentView extends StatelessWidget {
  const MakePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.read<MakePaymentBloc>().state.status;
    return Column(
      children: [
        Text('Status: $status'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<MakePaymentBloc>()
                  .add(const PaymentInitiated(amount: '399', currency: 'USD'));
            },
            child: const Text('initiate payment'),
          ),
        )
      ],
    );
  }
}
