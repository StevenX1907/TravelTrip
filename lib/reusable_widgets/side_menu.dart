import 'package:flutter/material.dart';
import 'package:travel_trip_application/screens/home_screen.dart';
import 'package:travel_trip_application/screens/itinerary.dart';
import 'package:travel_trip_application/screens/profile_screen.dart';
import 'package:travel_trip_application/screens/signin_screen.dart';
import 'package:travel_trip_application/reusable_widgets/dark_mode.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;
bool iconBool = false;

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    Color drawerHeaderColor = isDarkMode ? Colors.black45 : Colors.green;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: drawerHeaderColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/47.jpg"),
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'USA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Explore'),
            onTap: () => {Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen()))},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Create Itinerary'),
            onTap: () => {Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ItineraryPage()))},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            onTap: () => {Navigator.of(context).pop()}, //go back to screen
          ),
          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
                onTap: () {
                  darkModeProvider.toggleTheme();
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, //still unable to change alignment
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()))
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About Us'),
                    onTap: () => {Navigator.of(context).pop()},
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
