import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../reusable_widgets/dark_mode.dart';
import 'home_screen.dart';

class MultipleChoiceOption extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final Function(bool?) onChanged;

  MultipleChoiceOption({
    required this.optionText,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: onChanged,
        ),
        Text(optionText),
      ],
    );
  }
}

class PersonalityScreen extends StatefulWidget {
  const PersonalityScreen({Key? key}) : super(key: key);

  @override
  _PersonalityScreenState createState() => _PersonalityScreenState();
}

class _PersonalityScreenState extends State<PersonalityScreen> {
  Map<String, bool> selectedDestinations = {
    'Beaches': false,
    'Museum': false,
    'Mountain': false,
    'Cityscapes': false,
    'Shopping Malls': false,
  };

  Map<String, bool> idealWeekend = {
    'Sleeping': false,
    'Hiking': false,
    'Shopping': false,
    'Sightseeing': false,
    'Partying': false,
  };

  Map<String, bool?> season = {
    'Spring': false,
    'Summer': false,
    'Autumn': false,
    'Winter': false,
  };
  String? selectedSeason;

  Map<String, bool?> bookFlight = {
    'One year': false,
    '6 months': false,
    '3 months': false,
    '1 month' : false,
    '1 week': false,
  };
  String? selectedBook;

  Map<String, bool?> hotel = {
  'Read through a lot of reviews first': false,
  'Cheapest prices/hotels with discounts': false,
  'Discuss with friends':false,
  'Based on the most convenient or central location': false,
  'Based on how Instagrammable it is': false,
  };
  String? selectedHotel;

  Map<String, bool?> personality_1 = {
    'I love adrenaline-pumping activities and explore new locations': false,
    'I prefer to relax at a spa or on a quiet beach with a good book': false,
  };
  String? selectedPersonality_1;

  Map<String, bool?> personality_2 = {
    'I love to immerse myself in different cultures, try local food, and visit historical sites': false,
    'I find it peaceful to go to natural landscapes like forests, mountains, or beaches': false,
  };
  String? selectedPersonality_2;

  Map<String, bool?> personality_3 = {
    'I enjoy traveling with a group of friends or family': false,
    'I love to enjoy the freedom of solo traveling by myself': false,
  };
  String? selectedPersonality_3;

  Map<String, bool?> personality_4 = {
    'I plan every detail of my trip from accommodation to daily itineraries': false,
    'I prefer to go with the flow and make my decisions on the spot based on my mood.': false,
  };
  String? selectedPersonality_4;

  Map<String, bool?> personality_5 = {
    'I am willing to spend on luxury accommodation and a fine dining experience.': false,
    'I prioritize budget-friendly options and saving money during my travels.': false,
  };
  String? selectedPersonality_5;

  TextEditingController hobbyController = TextEditingController();
  TextEditingController favoriteFoodController = TextEditingController();

  void _onItemSelection(
      Map<String, bool> selectedItemMap,
      String itemKey,
      bool newValue,
      ) {
    setState(() {
      selectedItemMap[itemKey] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Color(0xFF306550),
        title: const Text('Personality Questions'),
      ),
      body: SingleChildScrollView(
        child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black, Colors.black]
                : [
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Which of these travel destinations do you prefer?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: selectedDestinations.keys.map((destination) {
                return Row(
                  children: [
                    Checkbox(
                      value: selectedDestinations[destination] ?? false,
                      onChanged: (bool? value) {
                        _onItemSelection(selectedDestinations, destination, value ?? false);
                      },
                    ),
                    Text(destination),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              '2. What is your ideal weekend activity?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: idealWeekend.keys.map((destination) {
                return Row(
                  children: [
                    Checkbox(
                      value: idealWeekend[destination] ?? false,
                      onChanged: (bool? value) {
                        _onItemSelection(idealWeekend, destination, value ?? false);
                      },
                    ),
                    Text(destination),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              '3. What is your most favorite season?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: season.keys.map((activity) {
                return Row(
                  children: [
                    Radio(
                      value: activity,
                      groupValue: selectedSeason,
                      onChanged: (newValue) {
                        setState(() {
                          selectedSeason = newValue.toString();
                        });
                      },
                    ),
                    Text(activity),
                  ],
                );
              }).toList(),
            ),
            Text(
              '\n4. How long in advance do you book your flight?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: bookFlight.keys.map((activity) {
                return Row(
                  children: [
                    Radio(
                      value: activity,
                      groupValue: selectedBook,
                      onChanged: (newValue) {
                        setState(() {
                          selectedBook = newValue.toString();
                        });
                      },
                    ),
                    Text(activity),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              '\n5. How do you choose the perfect hotel to stay in?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: hotel.keys.map((activity) {
                return Row(
                  children: [
                    Radio(
                      value: activity,
                      groupValue: selectedHotel,
                      onChanged: (newValue) {
                        setState(() {
                          selectedHotel = newValue.toString();
                        });
                      },
                    ),
                    Text(activity),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              'Which one do you prefer?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '\n6. Adventure Seeker vs. Relaxation Enthusiast',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: personality_1.keys.map((activity) {
                return Row(
                  children: [
                    Flexible(
                      flex: 0,
                      child: Radio(
                        value: activity,
                        groupValue: selectedPersonality_1,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPersonality_1 = newValue.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(activity),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              '\n7. Cultural Explorer vs. Nature Lover',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: personality_2.keys.map((activity) {
                return Row(
                  children: [
                    Flexible(
                      flex: 0,
                      child: Radio(
                        value: activity,
                        groupValue: selectedPersonality_2,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPersonality_2 = newValue.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(activity),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              '\n8. Group vs Solo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: personality_3.keys.map((activity) {
                return Row(
                  children: [
                    Flexible(
                      flex: 0,
                      child: Radio(
                        value: activity,
                        groupValue: selectedPersonality_3,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPersonality_3 = newValue.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(activity),
                    ),
                  ],
                );
              }).toList(),
            ),
            Text(
              '\n9. Planner vs Spontaneous',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: personality_4.keys.map((activity) {
                return Row(
                  children: [
                    Flexible(
                      flex: 0,
                      child: Radio(
                        value: activity,
                        groupValue: selectedPersonality_4,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPersonality_4 = newValue.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(activity),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              '\n10. Luxury vs Budget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: personality_5.keys.map((activity) {
                return Row(
                  children: [
                    Flexible(
                      flex: 0,
                      child: Radio(
                        value: activity,
                        groupValue: selectedPersonality_5,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPersonality_5 = newValue.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(activity),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  savePersonality();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust the padding as needed
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 15), // Adjust the font size as needed
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  void savePersonality() {
    // Handle saving the selected destinations, hobby, and favorite food.
    List<String> selectedDestinationList = selectedDestinations.keys
        .where((destination) => selectedDestinations[destination] == true)
        .toList();

    String hobby = hobbyController.text;
    String favoriteFood = favoriteFoodController.text;

    print('Selected Destinations: $selectedDestinationList');
    print('Hobby: $hobby');
    print('Favorite Food: $favoriteFood');
    print('Favorite Season: $selectedSeason');
    print('Advance Booking: $selectedBook');
    print('Perfect Hotel: $selectedHotel');
  }
}
