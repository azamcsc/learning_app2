import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_app2/screens/profile_page.dart';
import 'package:learning_app2/screens/backgroundL.dart';
import 'package:learning_app2/screens/colors.dart';
import 'package:learning_app2/screens/register_page.dart';
import 'package:learning_app2/utils/fire_auth.dart';
import 'package:learning_app2/utils/validator.dart';
import 'package:learning_app2/screens2/home/baseScreen.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BaseScreen(),//ProfilePage(user: user,),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:  Background(
            child: FutureBuilder(
              future: _initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "WELCOME BACK!2",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/LoginNew.png",
                          height: 300,
                        ),

                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              /* TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              decoration: InputDecoration(
                                hintText: "Email",
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: true,
                              validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                              decoration: InputDecoration(
                                hintText: "Password",
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.0),*/
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: kPrimaryLight,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child:TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(
                                      Icons.person,
                                      color: kPrimaryDark,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              SizedBox(height: 5.0),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: kPrimaryLight,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText: true,
                                  validator: (value) => Validator.validatePassword(
                                    password: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(
                                      Icons.lock,
                                      color: kPrimaryDark,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.visibility,
                                      color: kPrimaryDark,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.0),
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: () async {
                                      _focusEmail.unfocus();
                                      _focusPassword.unfocus();

                                      if (_formKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          _isProcessing = true;
                                        });

                                        User? user = await FireAuth
                                            .signInUsingEmailPassword(
                                          email: _emailTextController.text,
                                          password:
                                          _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });


                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  //ProfilePage(user: user),
                                              BaseScreen(),
                                            ),
                                          );
                                         /* Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BaseScreen(),// ProfilePage(user: user),
                                            ),
                                          );*/
                                        }else{
                                          showDialog(
                                            context: context,
                                            builder: (context) => new AlertDialog(
                                              title: new Text('Warning'),
                                              content: Text(
                                                  'Wrong password or email'),
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
                                      }
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),

                                  SizedBox(width: 54.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Dont't have an account?" ,
                                        style: TextStyle(color: kFont),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) {
                                              return RegisterPage();
                                            }),
                                          );
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            color: kPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  /*Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        _focusEmail.unfocus();
                                        _focusPassword.unfocus();

                                        if (_formKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });

                                          User? user = await FireAuth
                                              .signInUsingEmailPassword(
                                            email: _emailTextController.text,
                                            password:
                                            _passwordTextController.text,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(user: user),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 24.0),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Register',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),*/
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
