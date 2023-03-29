import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/reusable_widget.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("F1F9F6"),
            hexStringToColor("D1EEE1"),
            hexStringToColor("AFE1CE")
          ],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2,20 , 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UseName", Icons.person_outline, false, userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Your Email", Icons.email_outlined, false, emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.password_outlined, true, passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailTextController.text,
                      password: passwordTextController.text).then((value)  {
                        print("Create new account");
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
        ),
      )
    );
  }
}
