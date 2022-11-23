import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FireAuth {
  // For registering a new user

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required var context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    var j;


    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        var j = "The password provided is too weak.";
        print('The password provided is too weak.');
        screenLoadingx(context,j);

      } else if (e.code == 'email-already-in-use') {
        var j = "The account already exists for that email.";
        screenLoadingx(context,j);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

      return user;



  }

  // For signing in an user (have already registered)
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }








}

Future<void> screenLoadingx(context,title) async {
  showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Warning'),
      content: Text(title),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('OK'),
        ),
      ],
    ),
  );

}
