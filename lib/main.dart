import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orca/app/my_app.dart';

import 'config/environment.dart';
import 'core/initializer/init_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initApp(Environment.fromEnv(AppEnv.dev));
  runApp(const OrcaApp());
}
