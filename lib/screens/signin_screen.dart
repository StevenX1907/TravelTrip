import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/signup_screen.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../gen_l10n/app_localizations.dart';
import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'home_screen.dart';
import '../main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  void _changeLanguage(String selectedLanguage) {
    final locale = Locale(selectedLanguage);
    MyApp.setLocale(context, locale);
    Intl.defaultLocale = selectedLanguage; // Set the default locale for intl package
  }

  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  late BuildContext _context;
  bool isDarkMode = false;
  List<DropdownMenuItem<String>> languageItems = [
    DropdownMenuItem(
      value: 'en',
      child: Row(
        children: [
          Image.asset('assets/icons/en.jfif', width: 24),
          SizedBox(width: 8),
          const Text('English'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'zh',
      child: Row(
        children: [
          Image.asset('assets/icons/tw.jfif', width: 24),
          SizedBox(width: 8),
          const Text('中文(繁體)'),
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
      value: 'vi',
      child: Row(
        children: [
          Image.asset('assets/icons/vn.jfif', width: 24),
          SizedBox(width: 8),
          const Text('Tiếng Việt'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'ms',
      child: Row(
        children: [
          Image.asset('assets/icons/my.jfif', width: 24),
          SizedBox(width: 8),
          const Text('Bahasa Melayu'),
        ],
      ),
    ),
  ];

  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [
              Colors.black,
              Colors.black,
            ]
                : [
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                    color: Colors.black,
                    fontSize: 40,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                reusableTextField(AppLocalizations.of(context).enterEmail, Icons.email_outlined, false,
                    emailTextController, isDarkMode),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(AppLocalizations.of(context).enterPassword, Icons.lock_outline, true,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(context),
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
                          _changeLanguage(selectedLanguage);
                          print(selectedLanguage);// Call the method to change the locale
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).haveAccount,
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: Text(
            AppLocalizations.of(context).signUp,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Row forgotPasswordOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).forgotPassword,
          style:
          TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

