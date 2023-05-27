import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';


class DarkModeExample with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    backgroundColor:  Colors.black ;

    notifyListeners();
  }
}

class _DarkModeExample extends StatefulWidget with ChangeNotifier{
  @override
  _DarkModeExampleState createState() => _DarkModeExampleState();
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class _DarkModeExampleState extends State<_DarkModeExample> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeExample>(
      builder: (context, darkMode, _) {
        return MaterialApp(
          // debugShowCheckedModeBanner: false,
          // // theme: darkMode.isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
          // home: Scaffold(
          //   appBar: AppBar(
          //     title: Text('Dark Mode'),
          //   ),
          //   body: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // Switch(
          //           // value: darkMode.isDarkModeEnabled,
          //           onChanged: (value) {
          //             darkMode.toggleTheme();
          //           },
          //         ),
          //         Text(
          //           // darkMode.isDarkModeEnabled ? 'Dark Mode Enabled' : 'Dark Mode Disabled',
          //           style: TextStyle(fontSize: 18),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
