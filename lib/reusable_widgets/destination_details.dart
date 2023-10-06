import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DestinationDetailsScreen extends StatelessWidget {
  final String image;
  final String name;
  final String description;

  DestinationDetailsScreen({required this.image, required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: description.isNotEmpty
                ? Text(description)
                : Center(child: CircularProgressIndicator()), // Show loading indicator
          ),
        ],
      ),
    );
  }
}
