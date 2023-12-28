import 'package:authentication_repository/authentication_repository.dart';
import 'package:derosa_pay24/app/bloc/app_bloc.dart';
import 'package:derosa_pay24/home/home.dart';
import 'package:firestore_payments_api/firestore_payments_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required FirestorePaymentsApi firestorePaymentsApi,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _firestorePaymentsApi = firestorePaymentsApi,
        super(key: key);
  final AuthenticationRepository _authenticationRepository;
  final FirestorePaymentsApi _firestorePaymentsApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _firestorePaymentsApi),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => AppBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
