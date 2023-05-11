import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/reusable_widget.dart';
import 'package:travel_trip_application/screens/signin_screen.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import 'package:intl/intl.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController nationalTextController = TextEditingController();
  CountryCode _selectedCountryCode = CountryCode.fromCountryCode('TW');
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(

        child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("F1F9F6"),
            hexStringToColor("D1EEE1"),
            hexStringToColor("AFE1CE")
          ],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.1 ,20 , 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter First Name", Icons.person_outline, false, firstNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Last Name", Icons.person_outline, false, lastNameTextController),
                const SizedBox(
                  height: 20,
                ),
              TextField(
                readOnly: true,
                controller: dateController,
                decoration: const InputDecoration(hintText: 'Pick your Date'),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    dateController.text = DateFormat('MM/dd/yyyy').format(date);
                  }
                },

              ),
                const SizedBox(
                      height: 20,
                    ),
                CountryCodePicker(
                  initialSelection: 'TW',
                  favorite: ['+886', 'TW'],
                  onChanged: (countryCode) {
                    setState(() {
                      _selectedCountryCode = countryCode!;
                    });
                  },
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  alignLeft: true,
                  flagDecoration: BoxDecoration(
                    color: Colors.black,

                    borderRadius: BorderRadius.circular(90),
                  ),
                ),

                // reusableTextField1("Enter National", Icons.flag, false, nationalTextController),
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
                reusableTextField("Re-type Password", Icons.password_outlined, true, passwordTextController),
                signInSignUpButton(context, false, (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailTextController.text,
                      password: passwordTextController.text).then((value)  {
                        print("Create new account");
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
        ),
      )
    ));
  }
}
