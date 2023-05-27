import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/countryScreens/indonesia_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/malaysia_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/taiwan_screen.dart';
import 'package:travel_trip_application/screens/countryScreens/vietnam_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BuildContext _context;
  bool isDarkMode = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('TravelTrip'),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Taiwan_screen()),
                  );
                },
                child: Stack(
                  children: [
                    Image(
                        image: AssetImage('assets/images/Taipei.jpg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover),
                    Positioned(
                      left: 38,
                      top: 50,
                      child: Text(
                        'Taiwan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
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
                    Image(
                        image: AssetImage('assets/images/Indonesia.jpg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover),
                    Positioned(
                      right: 20,
                      top: 50,
                      child: Text(
                        'Indonesia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Malaysia_screen()),
                  );
                },
                child: Stack(
                  children: [
                    Image(
                        image: AssetImage('assets/images/Malaysia.jpg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover),
                    Positioned(
                      left: 25,
                      bottom: 300,
                      child: Text(
                        'Malaysia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vietnam_screen()),
                  );
                },
                child: Stack(
                  children: [
                    Image(
                        image: AssetImage('assets/images/Vietnam.jpg'),
                        width: 180,
                        height: 350,
                        fit: BoxFit.cover),
                    Positioned(
                      right: 28,
                      bottom: 300,
                      child: Text(
                        'Vietnam',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
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
