import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => await _makePayment(context.request),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Future<Response> _makePayment(Request request) async {
  // Load environment variables before handling any requests
  final apiKey = Platform.environment['API_KEY'];

  try {
    final {
      "amount": String? amount,
      "currency": String? currency,
    } = Map<String, dynamic>.from(await request.json());

    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': amount.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Response.json(body: {
        'clientSecret': responseBody['client_secret'],
      });
    } else {
      return Response.json(
        statusCode: response.statusCode,
        body: responseBody,
      );
    }
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Failed to create Payment Intent'},
    );
  }
}
