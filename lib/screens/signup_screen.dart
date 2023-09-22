import 'dart:developer';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/reusable_widget.dart';
import 'package:travel_trip_application/screens/utils/VerifyEmailScreen.dart';
import 'package:travel_trip_application/screens/personality_screen.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../reusable_widgets/dark_mode.dart';
import 'personality_screen.dart';
import 'package:travel_trip_application/screens/utils/Service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController retypePasswordTextController = TextEditingController(); // New controller for retype password
  bool showPassword = false; // Variable to toggle password visibility
  Service service = Service();


  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: isDarkMode
                ? [
              Colors.black,
              Colors.black
            ]
                :[
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        child: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery
              .of(context)
              .size
              .height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              // const SizedBox(
              //   height: 20,
              // ),
              // reusableTextField("Enter Username", Icons.person_outline, false,
              //     userNameTextController, isDarkMode),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Your Email", Icons.email_outlined, false,
                  emailTextController, isDarkMode),
              const SizedBox(
                height: 20,
              ),
              // Password field with show password icon
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  reusableTextField(
                      "Enter Password", Icons.password_outlined, !showPassword,
                      passwordTextController, isDarkMode),
                ],
              ),
              const SizedBox(height: 20),
              reusableTextField(
                  "Retype Password", Icons.password_outlined, !showPassword,
                  retypePasswordTextController, isDarkMode),
              const SizedBox(height: 20),
              nextButton(context, () {
                service.saveUser(
                  emailTextController.text,
                  passwordTextController.text,
                );

                try {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailTextController.text.trim(),
                    password: passwordTextController.text.trim(),
                  )
                      .then((value) {
                    User? user = FirebaseAuth.instance.currentUser;
                    user?.sendEmailVerification().then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalityScreen(),
                        ),
                      );
                    }).catchError((error) {
                      if (kDebugMode) {
                        print("Error sending email verification: ${error.toString()}");
                      }
                    });
                  }).onError((error, stackTrace) {
                    if (kDebugMode) {
                      print("Error ${error.toString()}");
                    }
                  });
                } on FirebaseAuthException catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}