import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeExample with ChangeNotifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    notifyListeners();
  }

  Color get backgroundColor =>
      _isDarkModeEnabled ? Colors.black : Colors.white;
}

class _DarkModeExample extends StatefulWidget {
  @override
  _DarkModeExampleState createState() => _DarkModeExampleState();
}

class _DarkModeExampleState extends State<_DarkModeExample> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeExample>(
      builder: (context, darkMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: darkMode.isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Dark Mode'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: darkMode.isDarkModeEnabled,
                    onChanged: (value) {
                      darkMode.toggleTheme();
                    },
                  ),
                  Text(
                    darkMode.isDarkModeEnabled ? 'Dark Mode Enabled' : 'Dark Mode Disabled',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
