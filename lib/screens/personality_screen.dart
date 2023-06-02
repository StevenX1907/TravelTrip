import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/signup_screen.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';

import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'home_screen.dart';

class PersonalityScreen extends StatefulWidget {
  const PersonalityScreen({Key? key}) : super(key: key);

  @override
  _PersonalityScreenState createState() => _PersonalityScreenState();
}

class _PersonalityScreenState extends State<PersonalityScreen> {
  String? selectedPersonality;
  String? hobby;
  String? favoriteFood;

  List<String> personalityOptions = ['Introvert', 'Extrovert'];
  TextEditingController hobbyController = TextEditingController();
  TextEditingController favoriteFoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode?Colors.black:Color(0xFF306550),
        title: const Text('Personality'),
      ),
      body: Container(
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

        padding: EdgeInsets.all(16),
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Personality:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPersonality,
              onChanged: (value) {
                setState(() {
                  selectedPersonality = value;
                });
              },
              items: personalityOptions.map((personality) {
                return DropdownMenuItem<String>(
                  value: personality,
                  child: Text(personality),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hobby:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: hobbyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your hobby',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Favorite Food:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: favoriteFoodController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your favorite food',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                savePersonality();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void savePersonality() {
    final String? personality = selectedPersonality;
    final String? hobby = hobbyController.text;
    final String? favoriteFood = favoriteFoodController.text;

    // Do something with the saved personality data
    print('Selected Personality: $personality');
    print('Hobby: $hobby');
    print('Favorite Food: $favoriteFood');
  }
}
