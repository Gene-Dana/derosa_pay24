import 'package:derosa_pay26/home/view/home.dart';
import 'package:flutter/material.dart';

import 'package:derosa_pay26/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap(
    () => Home(),
  );
}
