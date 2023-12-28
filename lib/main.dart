import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_payments_api/firestore_payments_api.dart';
import 'package:flutter/material.dart';

import 'package:derosa_pay24/bootstrap.dart';
import 'package:derosa_pay24/firebase_options.dart';

import 'app/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authenticationRepository = AuthenticationRepository();

  final firestorePaymentsApi =
      FirestorePaymentsApi(firestore: FirebaseFirestore.instance);

  await bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
      firestorePaymentsApi: firestorePaymentsApi,
    ),
  );
}
