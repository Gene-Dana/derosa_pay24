part of 'make_payment_bloc.dart';

enum MakePaymentStatus { initial, defaultPayment, inProgress, success }

class MakePaymentState extends Equatable {
  const MakePaymentState._({
    required this.status,
    required this.payment,
  });

  const MakePaymentState.initial(Payment payment)
      : this._(
          status: MakePaymentStatus.initial,
          payment: payment,
        );

  const MakePaymentState.inProgress(Payment payment)
      : this._(
          status: MakePaymentStatus.inProgress,
          payment: payment,
        );

  const MakePaymentState.success(Payment payment)
      : this._(
          status: MakePaymentStatus.success,
          payment: payment,
        );

  final MakePaymentStatus status;
  final Payment payment;
  @override
  List<Object> get props => [status, payment];

  MakePaymentState copyWith({
    MakePaymentStatus? status,
    Payment? payment,
  }) {
    return MakePaymentState._(
      status: status ?? this.status,
      payment: payment ?? this.payment,
    );
  }
}
