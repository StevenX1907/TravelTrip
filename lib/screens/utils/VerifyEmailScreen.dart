import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../personality_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  // Add a boolean variable to track whether the email is verified
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    // Check the email verification status when the screen is loaded
    checkEmailVerificationStatus();
  }

  Future<void> checkEmailVerificationStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      // Email is not verified, show a message to verify the email
      // Optionally, you can send the verification email again here if needed
      print("Email not verified. Send verification email again if needed.");
    } else if (user != null && user.emailVerified) {
      // Email is verified
      setState(() {
        isEmailVerified = true;
      });
    } else {
      print("User is null or email verification status unknown.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Email Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Please check your email and follow the instructions to verify your account.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Continue button to navigate to the PersonalityScreen

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalityScreen(),
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
          ],
        ),
      ),
    );
  }
}
