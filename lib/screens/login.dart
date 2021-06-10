import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data_providers/auth_data_provider.dart';
import '../data_providers/auth_provider.dart';
import '../coffee_router.dart';
import '../helpers/validators.dart';
import '../const.dart';
import 'menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    @required this.scaffoldKey,
  }) : assert(scaffoldKey != null);

  final scaffoldKey;

  static String routeName = 'loginScreen';
  static Route<LoginScreen> route(loginScaffoldKey) {
    return MaterialPageRoute<LoginScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => LoginScreen(
        scaffoldKey: loginScaffoldKey,
      ),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Login",
          semanticsLabel: 'logo',
        ),
        actions: [
          Image.asset(
            "assets/wired-brain-coffee-logo.png",
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: SvgPicture.asset(
                  "assets/coffee_break.svg",
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  semanticsLabel: 'Wire Brain Coffee',
                  fit: BoxFit.fitWidth,
                ),
              ),
              ..._buildInputs(),
              ..._buildForgotPassword(),
              ..._buildLoginButton(),
              ..._buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputs() {
    return <Widget>[
      TextFormField(
        key: Key('email'),
        controller: _emailFieldController,
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
        validator: Validators.validateEmail,
      ),
      SizedBox(height: 30),
      TextFormField(
        key: Key('password'),
        controller: _passwordFieldController,
        autocorrect: false,
        obscureText: true,
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
        validator: Validators.validatePassword,
      ),
      SizedBox(height: 10),
    ];
  }

  List<Widget> _buildForgotPassword() {
    return <Widget>[
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
    ];
  }

  List<Widget> _buildLoginButton() {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.fromLTRB(55, 15, 55, 15),
                  ),
                  backgroundColor: MaterialStateProperty.all(darkBrown),
                ),
                key: Key('signIn'),
                onPressed: _onSubmitLoginButton,
                child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
      SizedBox(height: 15),
    ];
  }

  List<Widget> _buildCreateAccount() {
    return <Widget>[
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
    ];
  }

  bool _isFormValidated() {
    final FormState? form = formKey.currentState;
    if (form != null) {
      return form.validate();
    }
    return false;
  }

  _onSubmitLoginButton() async {
    if (_isFormValidated()) {
      widget.scaffoldKey.currentState.showSnackBar(_loadingSnackBar());

      final BaseAuth? auth = AuthProvider.of(context)?.auth;
      if (auth == null) {
        return;
      }
      final String email = _emailFieldController.text;
      final String password = _passwordFieldController.text;
      final bool loggedIn = await auth.signInWithEmailAndPassword(
        email,
        password,
      );

      widget.scaffoldKey.currentState.hideCurrentSnackBar();

      if (loggedIn) {
        CoffeeRouter.instance.push(MenuScreen.route());
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Your username / password is incorrect'),
        );
        widget.scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  Widget _loadingSnackBar() {
    return SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 20,
          ),
          Text(" Signing-In...")
        ],
      ),
    );
  }
}
