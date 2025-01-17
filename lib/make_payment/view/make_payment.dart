import 'package:derosa_pay25/home/models/payment.dart';
import 'package:derosa_pay25/make_payment/make_payment.dart';

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Page> onGenerateLocationPages(MakePaymentState state, List<Page> pages) {
  return [
    MaterialPage<void>(child: PaymentSelectForm(), name: '/payment'),
    if (state.status == MakePaymentStatus.defaultPayment)
      const MaterialPage<void>(child: PaymentProcessing()),
    if (state.status == MakePaymentStatus.success)
      const MaterialPage<void>(child: PaymentComplete()),
  ];
}

class MakePayment extends StatelessWidget {
  const MakePayment({Key? key, required this.payment}) : super(key: key);

  final Payment payment;

  static Route<MakePaymentState> route(Payment payment) {
    return MaterialPageRoute(builder: (_) => MakePayment(payment: payment));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MakePaymentBloc(
        payment: payment,
      ),
      child: const _BuildFlow(),
    );
  }
}

class _BuildFlow extends StatelessWidget {
  const _BuildFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<MakePaymentState>(
      state: context.select((MakePaymentBloc bloc) => bloc.state),
      onGeneratePages: onGenerateLocationPages,
    );
  }
}
