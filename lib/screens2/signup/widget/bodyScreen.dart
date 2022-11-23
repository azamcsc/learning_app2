import 'package:flutter/material.dart';
import 'package:learning_app2/constants/Elevated_button.dart';
import 'package:learning_app2/screens2/home/baseScreen.dart';
import 'package:learning_app2/screens2/login/login.dart';
import 'package:learning_app2/screens2/login/widget/already_have_anAcc_check.dart';
import 'package:learning_app2/screens2/login/widget/elevated_password_field.dart';
import 'package:learning_app2/screens2/signup/widget/AlreadyHaveAccSign.dart';
import 'package:learning_app2/screens2/signup/widget/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LET'S STEP UP YOUR KNOWLEDGE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/sign.png",
              height: 300,
            ),
            ElevatedInputField(
              hintText: "Your Email",
              onChanged: ((value) {}),
            ),
            ElevatedPasswordField(
              onChanged: ((value) {}),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                'SIGNUP',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (BaseScreen())),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            AlreadyHaveAccSign(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
