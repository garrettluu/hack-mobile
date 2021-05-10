import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hackmobile/services/AuthService.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Center(
        child: SignInButton(
          Buttons.Google,
          onPressed: () {
            authService.googleSignIn();
          },
        ),
      ),
    );
  }
}
