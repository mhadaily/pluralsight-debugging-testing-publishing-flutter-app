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

void main() {
  // Flutter >= 2 and Dart >= 2.12
  runZonedGuarded<Future<void>>(() async {
    await Sentry.init(
      (options) {
        options.dsn =
            'https://2978833149db4fdb896bf711b6e14b82@o487263.ingest.sentry.io/5545856';
      },
    );
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
      await Sentry.captureException(error, stackTrace: stackTrace);
      final SentryEvent event = await getSentryEnvEvent(error);
      Sentry.captureEvent(event, stackTrace: stackTrace);
    }
  });

  // You only need to call this method if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    final dynamic exception = details.exception;
    final StackTrace? stackTrace = details.stack;
    if (isInDebugMode) {
      print('Caught Framework Error!');
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      if (stackTrace != null) {
        // In production mode report to the application zone
        Zone.current.handleUncaughtError(exception, stackTrace);
      }
    }
  };
}
