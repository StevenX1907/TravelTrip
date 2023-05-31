import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';

import '../utils/utils.dart';

class Taiwan_screen extends StatefulWidget {
  const Taiwan_screen({Key? key}) : super(key: key);

  @override
  State<Taiwan_screen> createState() => _TaiwanScreenState();
}

class _TaiwanScreenState extends State<Taiwan_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('TravelTrip'),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringToColor("F1F9F6"),
                  hexStringToColor("D1EEE1"),
                  hexStringToColor("AFE1CE")
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Stack(
          children: [
            Positioned(
                left: 20,
                top: 20,
                child: Image(
                  image: AssetImage('assets/images/Taipei.jpg'),
                )),
          ],
        )));
  }
}
