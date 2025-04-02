import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:payment_repository/payment_repository.dart';

part 'make_payment_event.dart';
part 'make_payment_state.dart';

class MakePaymentBloc extends Bloc<MakePaymentEvent, MakePaymentState> {
  MakePaymentBloc({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(const MakePaymentState(status: MakePaymentStatus.initial)) {
    on<MakePaymentEvent>((event, emit) {
      print('make payment event happened');
    });

    on<PaymentInitiated>(_onPaymentInitiated);
  }

  final PaymentRepository _paymentRepository;

  void _onPaymentInitiated(
    PaymentInitiated event,
    Emitter<MakePaymentState> emit,
  ) async {
    emit(
      const MakePaymentState(status: MakePaymentStatus.defaultPayment),
    );

    /// the client secret
    final clientSecret = await _paymentRepository.paymentIntent(event.amount);

    emit(
      state.copyWith(
        status: MakePaymentStatus.defaultPayment,
        amount: event.amount,
      ),
    );

    /// this is the specific ID for the saved payment method
    const paymentMethodId = 'pm_1O3H9GKtMrUMDgD4jU2rUdJ3';

    final output =
        await _paymentRepository.confirmPayment(clientSecret, paymentMethodId);

    if (output == PaymentStatus.success) {
      add(
        const PaymentStatusUpdated(status: MakePaymentStatus.success),
      ); // Trigger the PaymentSuccess event
    } else {
      const PaymentStatusUpdated(status: MakePaymentStatus.failed);
    }
  }
}
