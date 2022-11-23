import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app2/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isSigningOut = false;
  @override
  void initState() {
    super.initState();
  }
  TextEditingController nameTextController =  TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController oldpasswordTextController = TextEditingController();


  /*void _changePassword(String password) async {
    User? user = await User.instance.currentUser();
    String email = user.email;

    //Create field for user to input old password

    //pass the password here
    String password = "password";
    String newPassword = "password";

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.updatePassword(newPassword).then((_){
        print("Successfully changed password");
      }).catchError((error){
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }*/

  Future<bool> _changePassword(String currentPassword, String newPassword) async {
    bool success = false;

    //Create an instance of the current user.
    var user = await FirebaseAuth.instance.currentUser!;
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

    final cred = await EmailAuthProvider.credential(email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        success = true;
        //usersRef.doc(uid).update({"password": newPassword});
      }).catchError((error) {
        print(error);
      });
    }).catchError((err) {
      print(err);
    });

    return success;
  }


  Future resetEmail(String newEmail,String name,String newpass,String oldpass) async {
    var message;
    print("xxxxxxxxxxx");
    print(newEmail);
    print(name);
    print(newpass);
    print("xxxxxxxxxxx");
   // FirebaseAuth auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;

    //FirebaseUser firebaseUser = await _firebaseAuth.currentUser;
    if(name!=""){
    await  user?.updateDisplayName(name)
          .then(
            (value){
              print("a");
              setState(() {
                message = 'Success';
              });
          }
      )
          .catchError((onError) {
            setState(() {
              message = 'error';
            });

      } );
    }
     if(newEmail!=""){

      await user?.updateEmail(newEmail)
          .then(
            (value){
              setState(() {
                print("ab");
                message = 'Success';
              });
            }
      )
          .catchError((onError){
        setState(() {
          message = 'error';
        });
      } );
    }



        if(newpass!="" && oldpass!=""){
          _changePassword(oldpass,newpass);
          /* await user?.updatePassword(newpass)
          .then(
            (value){

            setState(() {
              print("ac");
              message = 'Success';
            });
          }
      )
          .catchError((onError){
        setState(() {
          message = 'error';
        });
      } );*/
    }


    if(message=="Success"){
      showDialog(
        context: context,
        builder: (context) =>  AlertDialog(
          title:  Text('Warning'),
          content: Text(
              '$message Update detail,please login again to retrive new detail'),
          actions: <Widget>[
             MaterialButton(
              onPressed: () async{
                Navigator.of(context, rootNavigator: true)
                    .pop();
                /*setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );*/
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Get.width * 0.06),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                color: Colors.blue.shade300,
              ),
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    'Hello Learners!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Image.asset(
                    'assets/icons/students.png',
                    scale: 5,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(Get.width * 0.04),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                          controller: nameTextController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: 'Name',
                            ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Old Password',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                            controller: oldpasswordTextController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: '*******',
                            ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ), Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Password',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                            controller: passwordTextController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: '*******',
                            ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                          controller: emailTextController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: 'Email',
                            ))
                      ],
                    ),
                  ],
                ).paddingAll(Get.width * 0.05),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //(String newEmail,String name,String newpass)
                  resetEmail(emailTextController.text,nameTextController.text,passwordTextController.text,oldpasswordTextController.text);
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );*/
                }),
            _isSigningOut
                ? CircularProgressIndicator()
                :
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async{
                setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }




}
