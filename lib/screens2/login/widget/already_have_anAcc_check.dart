import 'package:flutter/material.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/screens2/login/login.dart';
import 'package:learning_app2/screens2/signup/sign_up.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccount({
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
          login ? "Dont't have an account?" : "Already have an account",
          style: TextStyle(color: kFont),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return SignUpScreen();
              }),
            );
          },
          child: Text(
            login ? "Sign Up" : "Sign In",
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
