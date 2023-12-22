import 'package:flutter/material.dart';

class Itinerary {
  String generatedText;
  double userRating;

  Itinerary(this.generatedText, this.userRating);
}

class ItineraryProvider extends ChangeNotifier {
  List<Itinerary> _itineraries = [];

  List<Itinerary> get itineraries => _itineraries;

  void addItinerary(String generatedText, double userRating) {
    _itineraries.add(Itinerary(generatedText, userRating));
    notifyListeners();
  }

  void removeItinerary(int index) {
    _itineraries.removeAt(index);
    notifyListeners();
  }
}
