import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/about_us_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/indonesia_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/malaysia_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/taiwan_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/vietnam_screen.dart';
import 'package:travel_trip_application/screens/utils/test.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../reusable_widgets/dark_mode.dart';
import 'countryScreens/weatherapp_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    Color appBarColor = isDarkMode ? Colors.black : const Color(0xFF306550);

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('TravelTrip'),
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black38, Colors.black38]
                : [
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildImageRow(
              imagePath1: 'assets/images/Taiwan2.jpeg',
              text1: AppLocalizations.of(context).taiwan,
              onTap1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Taiwan_screen()),
                );
              },
              imagePath2: 'assets/images/Indonesia1.jpeg',
              text2: AppLocalizations.of(context).indonesia,
              onTap2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Indonesia_screen()),
                );
              },
            ),
            buildImageRow(
              imagePath1: 'assets/images/Malaysia1.jpeg',
              text1: AppLocalizations.of(context).malaysia,
              onTap1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Malaysia_screen()),
                );
              },
              imagePath2: 'assets/images/Vietnam1.jpg',
              text2: AppLocalizations.of(context).vietnam,
              onTap2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vietnam_screen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageRow({
    required String imagePath1,
    required String text1,
    required VoidCallback onTap1,
    required String imagePath2,
    required String text2,
    required VoidCallback onTap2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildImageCard(imagePath: imagePath1, text: text1, onTap: onTap1),
        buildImageCard(imagePath: imagePath2, text: text2, onTap: onTap2),
      ],
    );
  }

  Widget buildImageCard({
    required String imagePath,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Image(
            image: AssetImage(imagePath),
            width: 180,
            height: 350,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Opacity(
              opacity: 0.2,
              child: Container(
                width: 180,
                height: 350,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 12,
            top: 300,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
