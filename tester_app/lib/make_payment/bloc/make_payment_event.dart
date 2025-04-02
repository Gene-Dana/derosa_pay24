part of 'make_payment_bloc.dart';

@immutable
sealed class MakePaymentEvent extends Equatable {
  const MakePaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentInitiated extends MakePaymentEvent {
  const PaymentInitiated({required this.amount, required this.currency});

  final String amount;
  final String currency;

  @override
  List<Object?> get props => [amount, currency];
}

class PaymentStatusUpdated extends MakePaymentEvent {
  const PaymentStatusUpdated({required this.status});

  final MakePaymentStatus status;

  @override
  List<Object?> get props => [status];
}
