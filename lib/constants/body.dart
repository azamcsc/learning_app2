import 'package:flutter/material.dart';
import 'package:learning_app2/constants/background.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/constants/rounded_button.dart';
import 'package:learning_app2/screens2/login/login.dart';
import 'package:learning_app2/screens2/signup/sign_up.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Opportunity to Learn Everywhere",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          Image.asset(
            "assets/images/Logo.png",
            height: 150,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'LOGIN',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 95, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'REGISTER',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (SignUpScreen())),
                );
              }),
        ],
      ),
    );
  }
}
