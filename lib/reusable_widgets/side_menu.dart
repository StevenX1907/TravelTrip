import 'package:flutter/material.dart';
import 'package:travel_trip_application/screens/discussion_page.dart';
import 'package:travel_trip_application/screens/home_screen.dart';
import 'package:travel_trip_application/screens/itinerary.dart';
import 'package:travel_trip_application/screens/profile_screen.dart';
import 'package:travel_trip_application/screens/signin_screen.dart';
import 'package:travel_trip_application/reusable_widgets/dark_mode.dart';
import 'package:provider/provider.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';
import '../screens/about_us_screen.dart';
import '../screens/chat_screen.dart';

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;
bool iconBool = false;
class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}
class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    Color drawerHeaderColor = isDarkMode ? Colors.black : Color(0xFF306550);
    return Drawer(
      backgroundColor: isDarkMode?Colors.grey[1]:Colors.white,
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
            leading: const Icon(Icons.house),
            title: Text(AppLocalizations.of(context).home),
            onTap: () => {Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const DiscussionPage()))},
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: Text(AppLocalizations.of(context).profile),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage(name:"John Doe",gender:"Female",nationality:"America")))},
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: Text(AppLocalizations.of(context).explore),
            onTap: () => {Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()))},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(AppLocalizations.of(context).createItinerary),
            onTap: () => {Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ItineraryPage()))},
          ),
          // ListTile(
          //   leading: const Icon(Icons.ac_unit),
          //   title: const Text('Chat box'),
          //   onTap: () => {Navigator.pushReplacement(context,
          // //       MaterialPageRoute(builder: (context) => ChatScreen()))},
          // ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(AppLocalizations.of(context).notification),
            onTap: () => {Navigator.of(context).pop()}, //go back to screen
          ),
          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context).settings),
            children: <Widget>[
              ExpansionTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context).language),
                children: <Widget>[
                  ListTile(
                    title: Text(EmojiParser().emojify('🇺🇸') + ' ' + AppLocalizations.of(context).english),
                    onTap: () => {MyApp.setLocale(context, Locale('en'))},
                  ),
                  ListTile(
                    title: Text(EmojiParser().emojify('🇹🇼') + ' ' + AppLocalizations.of(context).chinese),
                    onTap: () => {MyApp.setLocale(context, Locale('zh'))},
                  ),
                  ListTile(
                    title: Text(EmojiParser().emojify('🇮🇩') + ' ' + AppLocalizations.of(context).indonesian),
                    onTap: () => {MyApp.setLocale(context, Locale('id'))},
                  ),
                  ListTile(
                    title: Text(EmojiParser().emojify('🇻🇳') + ' ' + AppLocalizations.of(context).vietnamese),
                    onTap: () => {MyApp.setLocale(context, Locale('vi'))},
                  ),
                  ListTile(
                    title: Text(EmojiParser().emojify('🇲🇾') + ' ' + AppLocalizations.of(context).malay),
                    onTap: () => {MyApp.setLocale(context, Locale('ms'))},
                  ),
                ],
              ),

              ListTile(
                leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                title: Text(isDarkMode ? AppLocalizations.of(context).lightMode : AppLocalizations.of(context).darkMode),
                onTap: () {
                  darkModeProvider.toggleTheme();
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: Text(AppLocalizations.of(context).logOut),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(AppLocalizations.of(context).aboutUs),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  ),
                },
              ),
            ],
          )

        ],
      ),
    );
  }
}
