import 'package:flutter/material.dart';

class RatingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings Screen'),
      ),
      body: Center(
        child: Text('Display saved ratings here.'),
      ),
    );
  }
}
