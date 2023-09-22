import 'package:flutter/material.dart';

class ItineraryDisplayPage extends StatelessWidget {
  final List<String> itinerary;

  ItineraryDisplayPage({required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Itinerary'),
      ),
      body: ListView.builder(
        itemCount: itinerary.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itinerary[index]),
          );
        },
      ),
    );
  }
}
