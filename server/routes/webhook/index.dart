import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response.json(
        statusCode: 405, body: {'error': 'Method Not Allowed'});
  }

  final payload = await context.request.body();
  final event = jsonDecode(payload);

  if (event['type'] == 'payment_intent.succeeded') {
    return Response.json(body: {'status': 'Payment confirmed'});
  }

  return Response.json(
      statusCode: 400, body: {'error': 'Unhandled event type'});
}
