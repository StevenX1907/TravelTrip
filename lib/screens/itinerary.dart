import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import 'package:travel_trip_application/screens/vietnam/RatingsScreen.dart';
import 'package:travel_trip_application/screens/vietnam/itineraryProvider.dart';
import 'itinerary_display_page.dart';
import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/side_menu.dart';
import '../gen_l10n/app_localizations.dart';

class Itinerary {
  final String generatedText;
  final double userRating;

  Itinerary(this.generatedText, this.userRating);
}

// class ItineraryProvider extends ChangeNotifier {
//   String _generatedText = '';
//   double _userRating = 0.0;
//
//   String get generatedText => _generatedText;
//   double get userRating => _userRating;
//
//   void saveItineraryAndRating(String generatedText, double userRating) {
//     _generatedText = generatedText;
//     _userRating = userRating;
//     notifyListeners();
//   }
// }

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
  double userRating = 0.0;
  bool isItinerarySaved = false;
  late List<String> categories;
  late Map<String, List<String>> areasByCountry;
  List<Itinerary> savedItineraries = [];

  Future<String> getOpenAIResponse(String input) async {
    final apiKey = ''; // Replace with your OpenAI API key
    final apiUrl = 'https://api.openai.com/v1/completions';
    print('Prompt: $input');
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': '$input',
        'temperature': 0.8,
        'max_tokens': 1500,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get response from OpenAI');
    }
  }

  String truncateInput(String input, int maxTokens) {
    List<String> tokens = input.split(' ');
    if (tokens.length > maxTokens) {
      tokens = tokens.sublist(0, maxTokens);
    }
    return tokens.join(' ');
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categories = [
    AppLocalizations.of(context).a1,
      AppLocalizations.of(context).a2,
      AppLocalizations.of(context).a3,
      AppLocalizations.of(context).a4,
      AppLocalizations.of(context).a5,
    ];
    areasByCountry = {
      AppLocalizations.of(context).indonesia:
      [AppLocalizations.of(context).b1,
        AppLocalizations.of(context).b2,
        AppLocalizations.of(context).b3,
        AppLocalizations.of(context).b4,
        AppLocalizations.of(context).b5,],
    AppLocalizations.of(context).taiwan:
    [AppLocalizations.of(context).c1,
      AppLocalizations.of(context).c2,
      AppLocalizations.of(context).c3,
      AppLocalizations.of(context).c4,],
    AppLocalizations.of(context).vietnam:
    [AppLocalizations.of(context).d1,
      AppLocalizations.of(context).d2,],
    AppLocalizations.of(context).malaysia:
    [AppLocalizations.of(context).d3,
      AppLocalizations.of(context).d4,],
    };
  }
  List<String> areas = [];



  List<String> generateItinerary() {
    List<String> itinerary = [];

    if (selectedCountry == null ||
        selectedAreas.isEmpty ||
        selectedCategories.isEmpty ||
        fromDate == null ||
        untilDate == null ||
        arrivalTime == null ||
        departureTime == null) {
      return [];
    }

    for (String area in selectedAreas) {
      for (String category in selectedCategories) {
        itinerary.add('Visit ${area} - ${category}');
      }
    }

    return itinerary;
  }

  String generateItineraryPrompt() {
    List<String> itinerary = generateItinerary();

    if (itinerary.isEmpty || fromDate == null || untilDate == null) {
      throw Exception('Please fill in all the required fields.');
    }

    String input = '';

    for (String item in itinerary) {
      input += '- $item\n';
    }

    String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromDate!);
    String formattedUntilDate = DateFormat('yyyy-MM-dd').format(untilDate!);

    // Kiểm tra null trước khi sử dụng AppLocalizations
    var appLocalizations = AppLocalizations.of(context);
    if (appLocalizations != null) {
      input += '${appLocalizations.z14} $formattedFromDate ${appLocalizations.z15} $formattedUntilDate ${appLocalizations.z16} $selectedAreas in $selectedCountry ${appLocalizations.z17} $selectedCategories';
      input += '${appLocalizations.z13}';
    } else {
      // Xử lý trường hợp AppLocalizations là null
      // Điều này có thể là do không tìm thấy localization trong context hoặc có lỗi khác.
      throw Exception('Localization not found.');
    }

    return input;
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    final itineraryProvider = Provider.of<ItineraryProvider>(context);

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context).z1),
        backgroundColor: isDarkMode ? Colors.black : Color(0xFF306550),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.black38, Colors.black38]
                  : [
                hexStringToColor("F1F9F6"),
                hexStringToColor("D1EEE1"),
                hexStringToColor("AFE1CE")
              ],
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
                hint: Text(AppLocalizations.of(context).z2),
                items: [AppLocalizations.of(context).indonesia,
                  AppLocalizations.of(context).malaysia,
                  AppLocalizations.of(context).taiwan,
                  AppLocalizations.of(context).vietnam,]
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
                    areas = areasByCountry[value] ?? [];
                  });
                },
              ),
              const SizedBox(height: 16.0),
              if (selectedCountry != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context).z3),
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
                  Text(AppLocalizations.of(context).z4),
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
                title: Text(AppLocalizations.of(context).z5),
                subtitle: Text(fromDate != null
                    ? DateFormat('yyyy-MM-dd').format(fromDate!)
                    : AppLocalizations.of(context).z11),
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
                title: Text(AppLocalizations.of(context).z6),
                subtitle: Text(untilDate != null
                    ? DateFormat('yyyy-MM-dd').format(untilDate!)
                    : AppLocalizations.of(context).z11),
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
                title: Text(AppLocalizations.of(context).z7),
                subtitle: Text(departureTime != null
                    ? departureTime!.format(context)
                    : AppLocalizations.of(context).z12),
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
                title: Text(AppLocalizations.of(context).z8),
                subtitle: Text(arrivalTime != null
                    ? arrivalTime!.format(context)
                    : AppLocalizations.of(context).z12),
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

              // Display the generated itinerary

              ElevatedButton(
                onPressed: () async {
                  try {
                    String input = generateItineraryPrompt();
                    String response = await getOpenAIResponse(input);

                    Map<String, dynamic> jsonResponse = jsonDecode(response);
                    String generatedText = jsonResponse['choices'][0]['text'];

                    // Show the generated itinerary in the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Generated Itinerary'),
                          content: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.8,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  for (String item in generatedText
                                      .split('\n')
                                      .where((item) => item.isNotEmpty)) ...[
                                    Text('- $item'),
                                  ],
                                  SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Rate this itinerary:'),
                                InkWell(
                                  onTap: () {
                                    // Save the itinerary when the heart icon is clicked
                                    itineraryProvider.addItinerary(generatedText, userRating);

                                    // Update the state to reflect the change
                                    setState(() {
                                      isItinerarySaved = !isItinerarySaved;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      isItinerarySaved
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isItinerarySaved
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar.builder(
                                  initialRating: userRating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      userRating = rating;
                                    });
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    // Handle errors as before
                    print('Error: $e');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(
                            'Failed to generate itinerary. Please try again.',
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(AppLocalizations.of(context).z9),
              ),


            ],
          ),
        ),
      ),
    );
  }
}