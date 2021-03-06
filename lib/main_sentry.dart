import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

import 'coffee_router.dart';
import 'screens/get_theme.dart';
import './sentry_event.dart';
import 'screens/splash_screen.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  // assert(inDebugMode = true);
  return inDebugMode;
}

final SentryClient _sentry = SentryClient(
  dsn:
      "https://2978833149db4fdb896bf711b6e14b82@o487263.ingest.sentry.io/5545856",
);

void main() {
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
  }, (error, stackTrace) async {
    print('Caught Dart Error!');
    if (isInDebugMode) {
      // in development, print error and stack trace
      print('$error');
      print('$stackTrace');
    } else {
      // report to a error tracking system in production
      final Event event = await getSentryEnvEvent(error, stackTrace);
      _sentry.capture(
        event: event,
      );
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
