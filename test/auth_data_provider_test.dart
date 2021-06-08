import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../lib/data_providers/auth_data_provider.dart';
import '../lib/data_providers/http_client.dart';

class MockHttpClient extends Mock implements CoffeeHttpClient {}

main() {
  group('DataProvider', () {
    group('SignInWithPasswordUsername', () {
      test('should return true with correct username and password', () async {
        // arrange
        final CoffeeHttpClient mockHttpClient = MockHttpClient();
        final AuthDataProvider authDataProvider = AuthDataProvider(
          http: mockHttpClient,
        );
        final String password = 'password';
        final String email = 'username';

        when(() => mockHttpClient.post(any(), any())).thenAnswer(
          (_) => Future.value(
            http.Response('success', 200),
          ),
        );

        // act
        final bool res =
            await authDataProvider.signInWithEmailAndPassword(email, password);

        // assert
        expect(res, true);
      });
    });

    group('signOut', () {
      test('should return true with log out', () async {
        // arrange
        final CoffeeHttpClient mockHttpClient = MockHttpClient();
        final AuthDataProvider authDataProvider = AuthDataProvider(
          http: mockHttpClient,
        );

        when(() => mockHttpClient.get(any())).thenAnswer(
          (realInvocation) => Future.value(
            http.Response('success', 200),
          ),
        );

        // act
        final bool res = await authDataProvider.signOut();

        // assert
        expect(res, true);
      });
    });
  });
}
