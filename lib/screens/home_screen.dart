import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/screens/signin_screen.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> SignInScreen()));
          },
        ),
      ),
    );
  }
}