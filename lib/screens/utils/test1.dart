import 'package:flutter/material.dart';
import 'itinerary_display_page.dart';
import 'package:http/http.dart' as http;

class ItineraryPage extends StatefulWidget {
  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  String? selectedCountry;
  DateTime? fromDate;
  DateTime? untilDate;
  TimeOfDay? arrivalTime;
  TimeOfDay? departureTime;

  Future<String> getOpenAIResponse(String input) async {
    final apiKey = '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'; // Replace with your OpenAI API key
    final apiUrl = 'https://api.openai.com/v1/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: '{"model": "text-davinci-003", "prompt": "$input", "temperature": 0.8, "max_tokens": 1500}', // Customize as needed
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get response from OpenAI');
    }
  }

  List<String> generateItinerary() {
    List<String> itinerary = [];

    if (selectedCountry == null || fromDate == null || untilDate == null || arrivalTime == null || departureTime == null) {
      return [];
    }

    // Add basic itinerary items
    itinerary.add('Visit $selectedCountry');
    itinerary.add('Arrival at ${arrivalTime!.format(context)}');
    itinerary.add('Departure at ${departureTime!.format(context)}');

    try {
      // Generate additional information using OpenAI API
      String input = 'Generate additional information for $selectedCountry itinerary';
      String response = await getOpenAIResponse(input);
      itinerary.add('Additional Information:');
      itinerary.addAll(response.split('\n').where((item) => item.trim().isNotEmpty));
    } catch (e) {
      print('Error fetching additional information: $e');
    }

    return itinerary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Itinerary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCountry,
              hint: const Text('Select a country'),
              items: ['Country 1', 'Country 2', 'Country 3'] // Add your country list
                  .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Add your date and time pickers here

            ElevatedButton(
              onPressed: () async {
                List<String> itinerary = generateItinerary();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItineraryDisplayPage(itinerary: itinerary),
                  ),
                );
              },
              child: Text('Create Itinerary'),
            ),
          ],
        ),
      ),
    );
  }
}
