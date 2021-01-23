import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'coffee_router.dart';
import 'screens/get_theme.dart';
import 'screens/splash_screen.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  // assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> main() async {
  if (isInDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  // Flutter >= 1.17 and Dart >= 2.8
  runZonedGuarded<Future<void>>(() async {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        navigatorKey: CoffeeRouter.instance.navigatorKey,
        theme: getTheme(),
      ),
    );

    await Firebase.initializeApp();
  }, (error, stackTrace) async {
    print('Caught Dart Error!');
    if (isInDebugMode) {
      // in development, print error and stack trace
      print('$error');
      print('$stackTrace');
    } else {
      // report to a error tracking system in production
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  });

  // You only need to call this method if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    final dynamic exception = details.exception;
    final StackTrace stackTrace = details.stack;
    if (isInDebugMode) {
      print('Caught Framework Error!');
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone
      Zone.current.handleUncaughtError(exception, stackTrace);
    }
  };
}
