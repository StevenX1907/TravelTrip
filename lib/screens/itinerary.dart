import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';

import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/side_menu.dart';

class ItineraryPage extends StatefulWidget {
  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  String? selectedCountry;
  List<String> selectedAreas = [];
  List<String> selectedCategories = [];
  DateTime? fromDate;
  DateTime? untilDate;
  TimeOfDay? arrivalTime;
  TimeOfDay? departureTime;

  List<String> areas = [];
  List<String> categories = [
    'Natural Landscape',
    'Shopping District',
    'Historical Place',
    'Religious Place',
    'Theme Park',
  ];

  Map<String, List<String>> areasByCountry = {
    'Indonesia': ['Sumatra', 'Java', 'Kalimantan', 'Sulawesi', 'Papua'],
    'Taiwan': ['North', 'Central', 'South', 'East'],
    'Vietnam': ['North', 'South'],
    'Malaysia': ['West', 'East'],
  };


  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Itinerary'),
        backgroundColor: isDarkMode?Colors.black:Colors.green,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: isDarkMode
              ? [Colors.black38, Colors.black38]
              : [hexStringToColor("F1F9F6"), hexStringToColor("D1EEE1"), hexStringToColor("AFE1CE")],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCountry,
              hint: Text('Select a country'),
              items: ['Indonesia', 'Malaysia', 'Taiwan', 'Vietnam']
                  .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedAreas.clear();
                  selectedCategories.clear();
                  areas = areasByCountry[value]??[];
                });
              },
            ),
            const SizedBox(height: 16.0),
            if (selectedCountry != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Select area(s)'),
                  Wrap(
                    children: areas.map((area) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selectedAreas.contains(area),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null && value) {
                                  selectedAreas.add(area);
                                } else {
                                  selectedAreas.remove(area);
                                }
                              });
                            },
                          ),
                          Text(area),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Select category(s)'),
                Wrap(
                  children: categories.map((category) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: selectedCategories.contains(category),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null && value) {
                                selectedCategories.add(category);
                              } else {
                                selectedCategories.remove(category);
                              }
                            });
                          },
                        ),
                        Text(category),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text('From'),
              subtitle: Text(fromDate != null ? DateFormat('yyyy-MM-dd').format(fromDate!) : 'Select a date'),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                setState(() {
                  fromDate = selectedDate;
                });
              },
            ),

            ListTile(
              title: Text('Until'),
              subtitle: Text(untilDate != null ? DateFormat('yyyy-MM-dd').format(untilDate!) : 'Select a date'),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                setState(() {
                  untilDate = selectedDate;
                });
              },
            ),
            ListTile(
              title: Text('Departure Estimation'),
              subtitle: Text(departureTime != null
                  ? departureTime!.format(context)
                  : 'Select a time'),
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  departureTime = selectedTime;
                });
              },
            ),
            ListTile(
              title: Text('Arrival Estimation'),
              subtitle: Text(arrivalTime != null
                  ? arrivalTime!.format(context)
                  : 'Select a time'),
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  arrivalTime = selectedTime;
                });
              },
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform filtering logic or navigate to the next page with the selected choices
              },
              child: Text('Create Itinerary'),
            ),
          ],
        ),
      ),
    );
  }
}
