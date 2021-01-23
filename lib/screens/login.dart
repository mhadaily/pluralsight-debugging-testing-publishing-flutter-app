import 'package:error_reporting_features_in_a_flutter_app/auth_data_provider.dart';
import 'package:error_reporting_features_in_a_flutter_app/coffee_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../const.dart';
import 'menu.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'loginScreen';
  static Route<LoginScreen> route() {
    return MaterialPageRoute<LoginScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          Image.asset(
            "assets/wired-brain-coffee-logo.png",
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/coffee_break.svg",
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    semanticsLabel: 'Wire Brain Coffee',
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'me@majidhajian.com',
                      labelStyle: TextStyle(color: darkBrown),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                    ),
                    cursorColor: darkBrown,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    autocorrect: false,
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'securepassword',
                      labelText: 'Password',
                      labelStyle: TextStyle(color: darkBrown),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                    ),
                    cursorColor: darkBrown,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: darkBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FlatButton(
                            padding: EdgeInsets.fromLTRB(55, 15, 55, 15),
                            onPressed: () {
                              if (AuthDataProvider.login(
                                username: usernameController.text,
                                password: passwordController.text,
                              )) {
                                CoffeeRouter.instance.push(MenuScreen.route());
                              } else {
                                print('Sorry!');
                              }
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: darkBrown,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don\'t have an account?",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        " Register",
                        style: TextStyle(
                          color: darkBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
