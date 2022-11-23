import 'package:flutter/material.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/screens2/login/login.dart';
import 'package:learning_app2/screens2/signup/sign_up.dart';

class AlreadyHaveAccSign extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAccSign({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Already have an account" : "Dont't have an account?",
          style: TextStyle(color: kFont),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }),
            );
          },
          child: Text(
            login ? "Login" : "Sign In",
            style: TextStyle(
              color: kPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
