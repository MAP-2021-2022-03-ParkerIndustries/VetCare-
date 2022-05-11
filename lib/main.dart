import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';

void main() async {
  final WidgetBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep splash screen until initialization has completed
  FlutterNativeSplash.preserve(widgetsBinding: WidgetBinding);
  await initializeServiceLocator();
  // whenever your initialization is completed, remove the splash screen
  FlutterNativeSplash.remove;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      title: 'VetCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: Routes.homeRoute,
      onGenerateRoute: Routes.createRoute,
    );
  }
}

