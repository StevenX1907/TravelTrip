import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/signup_screen.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';

import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  late BuildContext _context;
  bool isDarkMode = false;
  List<DropdownMenuItem<String>> languageItems = [
    DropdownMenuItem(
      value: 'tw',
      child: Row(
        children: [
          Image.asset('assets/icons/tw.jfif', width: 24),
          SizedBox(width: 8),
          const Text('中文(繁體)'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'vn',
      child: Row(
        children: [
          Image.asset('assets/icons/vn.jfif', width: 24),
          SizedBox(width: 8),
          const Text('Tiếng Việt'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'id',
      child: Row(
        children: [
          Image.asset('assets/icons/id.jfif', width: 24),
          SizedBox(width: 8),
          const Text('Bahasa Indonesia'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'my',
      child: Row(
        children: [
          Image.asset('assets/icons/id.jfif', width: 24),
          SizedBox(width: 8),
          const Text('Bahasa Melayu'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'us',
      child: Row(
        children: [
          Image.asset('assets/icons/en.jfif', width: 24),
          SizedBox(width: 8),
          const Text('English '),
        ],
      ),
    ),
  ];

  String selectedLanguage = 'us';



  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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

        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            children: <Widget>[
              logoWidget("assets/images/logo1.png"),
              const Text(
                "Travel Trip",
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 40,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  // Add other text style properties as desired
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              reusableTextField("Enter Email", Icons.email_outlined, false,
                  emailTextController, isDarkMode),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  passwordTextController, isDarkMode),
              const SizedBox(
                height: 30,
              ),
              signInSignUpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailTextController.text,
                        password: passwordTextController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
              signUpOption(),
              const SizedBox(
                height: 20,
              ),
              forgotPasswordOption(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    dropdownColor: Color(0xFFD1EEE1),
                    value: selectedLanguage,
                    items: languageItems,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ],
              ),


            ],
          ),
        )),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?  ",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row forgotPasswordOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Forgot password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
