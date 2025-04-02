import 'dart:convert';
import 'package:http/http.dart' as http;

enum PaymentStatus {
  success,
  requiresAction,
  failed,
  error,
}

/// {@template payment_repository}
/// My new Flutter package
/// {@endtemplate}
class PaymentRepository {
  /// {@macro payment_repository}
  const PaymentRepository();

  /// this functions calls upon the backend
  /// to get the client secret
  ///
  /// This is used in conjuction with the
  /// publishable key to make the payment call
  Future<String> paymentIntent(String amount) async {
    const url = 'https://stripe-payment.globeapp.dev/payment';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'amount': amount,
        'currency': 'USD',
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the `client_secret` directly
      final clientSecret = responseBody['clientSecret'] as String;

      print('client secret: $clientSecret');
      return clientSecret;
    } else {
      throw Exception(
          'Failed to create payment intent: ${response.statusCode}');
    }
  }

  /// Now that the payment intent has been created
  /// payment is  confirmed by hitting the Stripe api
  /// with the publishable key
  ///
  Future<PaymentStatus> confirmPayment(
      String clientSecret, String paymentMethodId) async {
    print('clientSecret: $clientSecret');
    // Extract Payment Intent ID from clientSecret
    final paymentIntentId = clientSecret.split('_secret')[0];

    print('paymentIntentId: $paymentIntentId');

    const publishableKey =
        'pk_live_51NwoUWKtMrUMDgD46YO0qjfLavpMfQBGkOhNQjUzsbChRFnpxOKFIiXtTKOeMhq2M7I6TdA1f3MrFniobrJv5g9v004D4ehm6s';

    final response = await http.post(
      Uri.parse(
        'https://api.stripe.com/v1/payment_intents/$paymentIntentId/confirm',
      ),
      headers: {
        'Authorization':
            'Bearer $publishableKey', // Only your publishable key on frontend
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_secret': clientSecret,
        'payment_method':
            paymentMethodId, // Card token or saved payment method ID
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('✅ Payment successful: ${responseBody['status']}');
      return PaymentStatus.success;
    } else {
      print('❌ Payment failed: ${responseBody['error']['message']}');
      return PaymentStatus.failed;
    }
  }
}
