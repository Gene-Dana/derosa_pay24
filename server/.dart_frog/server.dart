// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/webhook/index.dart' as webhook_index;
import '../routes/repos/index.dart' as repos_index;
import '../routes/repos/[id]/index.dart' as repos_$id_index;
import '../routes/payment/index.dart' as payment_index;

import '../routes/repos/[id]/_middleware.dart' as repos_$id_middleware;
import '../routes/payment/_middleware.dart' as payment_middleware;

void main() async {
  final address = InternetAddress.tryParse('') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/payment', (context) => buildPaymentHandler()(context))
    ..mount('/repos/<id>', (context,id,) => buildRepos$idHandler(id,)(context))
    ..mount('/repos', (context) => buildReposHandler()(context))
    ..mount('/webhook', (context) => buildWebhookHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildPaymentHandler() {
  final pipeline = const Pipeline().addMiddleware(payment_middleware.middleware);
  final router = Router()
    ..all('/', (context) => payment_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildRepos$idHandler(String id,) {
  final pipeline = const Pipeline().addMiddleware(repos_$id_middleware.middleware);
  final router = Router()
    ..all('/', (context) => repos_$id_index.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildReposHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => repos_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildWebhookHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => webhook_index.onRequest(context,));
  return pipeline.addHandler(router);
}

