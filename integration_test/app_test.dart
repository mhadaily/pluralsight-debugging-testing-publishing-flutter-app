import 'package:error_reporting_features_in_a_flutter_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Should login and see menu",
    (WidgetTester tester) async {
      app.main();

      await binding.traceAction(
        () async {
          await tester.pumpAndSettle();
          expect(
            find.byWidgetPredicate(
                (Widget widget) => widget is SpinKitFadingCircle),
            findsOneWidget,
          );
          await tester.pumpAndSettle(const Duration(seconds: 3));
          final loginFinder = find.byWidgetPredicate(
            (widget) =>
                widget is RaisedButton &&
                widget.child is Text &&
                (widget.child as Text).data.startsWith('Login'),
          );
          expect(loginFinder, findsOneWidget);
          await tester.tap(loginFinder);
          await tester.pumpAndSettle();
          final emailField = find.byKey(Key("email-field"));
          expect(emailField, findsOneWidget);
          await tester.tap(emailField);
          await tester.enterText(emailField, "test2@testmail.com");
          final passwordField = find.byKey(Key("password-field"));
          expect(passwordField, findsOneWidget);
          await tester.tap(passwordField);
          await tester.enterText(passwordField, "testtest");
          await tester.pump();
          final loginButton = find.byKey(Key("login-button"));
          expect(loginButton, findsOneWidget);
          await tester.tap(loginButton);
          await tester.pumpAndSettle(Duration(seconds: 10));

          expect(
            find.byWidgetPredicate((widget) => widget is LoginScreen),
            findsOneWidget,
          );
        },
      );
    },
  );
}
