part of 'make_payment_bloc.dart';

enum MakePaymentStatus {
  initial,
  defaultPayment,
  intentReceived,
  success,
  failed
}

@immutable
class MakePaymentState extends Equatable {
  const MakePaymentState({
    required this.status,
    this.amount,
    this.currency,
  });

  final MakePaymentStatus status;
  final String? amount;
  final String? currency;

  MakePaymentState copyWith({
    MakePaymentStatus? status,
    String? amount,
    String? currency,
  }) {
    return MakePaymentState(
      status: status ?? this.status,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [status, amount, currency];
}
