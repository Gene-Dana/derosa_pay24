import 'package:bloc/bloc.dart';
import 'package:derosa_pay25/home/models/payment.dart';
import 'package:equatable/equatable.dart';

part 'make_payment_event.dart';
part 'make_payment_state.dart';

class MakePaymentBloc extends Bloc<MakePaymentEvent, MakePaymentState> {
  MakePaymentBloc({
    required this.payment,
  }) : super(MakePaymentState.initial(payment)) {
    on<DefaultSelected>(_onDefaultSelected);

    on<PaymentSuccess>(_onPaymentSuccess);
  }

  final Payment payment;

  /// Event handler for the event when the default payment
  /// method is selected
  Future<void> _onDefaultSelected(
    DefaultSelected event,
    Emitter<MakePaymentState> emit,
  ) async {
    emit(
      state.copyWith(status: MakePaymentStatus.defaultPayment),
    );

    await Future.delayed(Duration(seconds: 2));
    add(PaymentSuccess()); // Trigger the PaymentSuccess event
  }

  /// Event handler for the event when the default payment
  /// method is selected
  void _onPaymentSuccess(
    PaymentSuccess event,
    Emitter<MakePaymentState> emit,
  ) {
    emit(
      state.copyWith(status: MakePaymentStatus.success),
    );
  }
}
