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
            gradient: LinearGradient(colors: isDarkMode
                ? [
              Colors.black38,
              Colors.black38
            ]
                :[
              hexStringToColor("F1F9F6"),//yhghghjhjgjhnbnbn
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        child: Stack(
          children: [

            Positioned(
              left: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  TestPage()),
                  );
                },
                child: Stack(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/Taiwan2.jpeg'),
                      width: 180,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.2, // Adjust the opacity value as needed
                        child: Container(
                          width: 180,
                          height: 350,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 30,
                      top: 300,
                      child: Text(
                        'Taiwan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.5,
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
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Indonesia_screen()),
                  );
                },
                child: Stack(
                  children: [
                    const Image(
                        image: AssetImage('assets/images/Indonesia1.jpeg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.2, // Adjust the opacity value as needed
                        child: Container(
                          width: 180,
                          height: 350,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 4,
                      top: 300,
                      child: Text(
                        'Indonesia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.5,
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
              ),
            ),
            Positioned(
              left: 20,
              bottom: 70,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Malaysia_screen()),
                  );
                },
                child: Stack(
                  children: [
                    const Image(
                        image: AssetImage('assets/images/Malaysia1.jpeg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.2, // Adjust the opacity value as needed
                        child: Container(
                          width: 180,
                          height: 350,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 15,
                      bottom: 10,
                      child: Text(
                        'Malaysia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.5,
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
              ),
            ),
            Positioned(
              right: 20,
              bottom: 70,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Vietnam_screen()),
                  );
                },
                child: Stack(
                  children: [
                    const Image(
                        image: AssetImage('assets/images/Vietnam1.jpg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.2, // Adjust the opacity value as needed
                        child: Container(
                          width: 180,
                          height: 350,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 15,
                      bottom: 10,
                      child: Text(
                        'Vietnam',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.5,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}