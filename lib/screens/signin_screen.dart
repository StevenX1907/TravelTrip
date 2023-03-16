import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';

import '../reusable_widgets/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE")
            ],begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB
                (20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/logotravel.png"),
                    SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false, emailTextController),
                    SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline, true, passwordTextController),
                    SizedBox(
                      height: 30,
                    ),
                    signInSignUpButton(context, true, () {})
                  ]
              ),
            )
        ),
      ),
    );
  }
}
