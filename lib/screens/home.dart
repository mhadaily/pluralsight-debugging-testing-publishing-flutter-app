import 'package:error_reporting_features_in_a_flutter_app/coffee_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../const.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';
  static Route<HomeScreen> route() {
    return MaterialPageRoute<HomeScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final loginScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              "assets/wired-brain-coffee-logo.png",
              height: 150,
              width: 150,
            ),
            SvgPicture.asset(
              "assets/ng_coffee.svg",
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              semanticsLabel: 'Wire Brain Coffee',
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Get the best coffee!",
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.brown),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(55, 15, 55, 15),
                      onPressed: () {
                        CoffeeRouter.instance.push(
                          LoginScreen.route(loginScaffoldKey),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: darkBrown,
                    )),
                OutlineButton(
                  key: Key('homeLoginButton'),
                  padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
                  onPressed: () {
                    Navigator.of(context).push(
                      LoginScreen.route(loginScaffoldKey),
                    );
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(color: darkBrown),
                  ),
                  borderSide: BorderSide(color: darkBrown),
                  shape: StadiumBorder(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
