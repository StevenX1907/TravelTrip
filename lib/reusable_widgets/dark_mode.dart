import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class DarkModeExample with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class _DarkModeExample extends StatefulWidget with ChangeNotifier{
  @override
  _DarkModeExampleState createState() => _DarkModeExampleState();
}

class _DarkModeExampleState extends State<_DarkModeExample> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeExample>(
      builder: (context, darkMode, _) {
        return MaterialApp(
        );
      },
    );
  }
}