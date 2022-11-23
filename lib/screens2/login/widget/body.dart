import 'package:flutter/material.dart';
import 'package:learning_app2/constants/Elevated_button.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/constants/text_field_container.dart';
import 'package:learning_app2/screens2/home/baseScreen.dart';
import 'package:learning_app2/screens2/login/widget/already_have_anAcc_check.dart';
import 'package:learning_app2/screens2/login/widget/backgroundL.dart';
import 'package:learning_app2/screens2/login/widget/elevated_password_field.dart';
import 'package:learning_app2/screens2/signup/sign_up.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME BACK!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/images/LoginNew.png",
              height: 300,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
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
                'LOGIN',
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
              height: 30,
            ),
            AlreadyHaveAnAccount(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
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
