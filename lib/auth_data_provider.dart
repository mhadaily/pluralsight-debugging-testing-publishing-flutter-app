import "package:http/http.dart" as http;

Future<http.Response> fakeGet() async {
  final res = await http.get('https://jsonplaceholder.typicode.com/users/1');
  print(res.headers);
  return res;
}

class AuthDataProvider {
  static bool login({String username, String password}) {
    fakeGet();
    return username.trim().isNotEmpty && password.isNotEmpty;
  }
}










