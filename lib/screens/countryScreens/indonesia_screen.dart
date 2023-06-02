import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Indonesia_screen extends StatefulWidget {
  const Indonesia_screen({Key? key}) : super(key: key);

  @override
  State<Indonesia_screen> createState() => _IndonesiaScreenState();
}

class _IndonesiaScreenState extends State<Indonesia_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('TravelTrip'),
      ),
      body: const WebView(
        initialUrl: 'assets/html/index.html',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
