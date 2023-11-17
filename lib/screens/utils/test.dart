import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenAiApi {
  final String apiKey;

  OpenAiApi(this.apiKey);

  Future<String> generateCompletion(String basePrompt) async {
    final apiUrl = 'https://api.openai.com/v1/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: '{"model": "text-davinci-003", "prompt": "$basePrompt", "temperature": 0.8, "max_tokens": 1500}',
    );

    if (response.statusCode == 200) {
      final data = response.body;
      return data;
    } else {
      throw Exception('Failed to fetch data from the server');
    }
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController countryController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController monthController = TextEditingController();

  bool includeRestaurants = true;
  bool includeHotels = true;

  String apiOutput = '';
  bool isGenerating = false;

  Future<void> callGenerateEndpoint() async {
    setState(() {
      isGenerating = true;
    });

    String basePrompt =
        'Write me an itinerary for ${durationController.text} days to ${countryController.text} in the coming ${monthController.text}. Describe the weather that month, and also 5 things to take note about this country\'s culture. Keep to a maximum travel area to the size of Hokkaido, if possible, to minimize traveling time between cities.\n\nFor each day, list me the following:\n- Attractions suitable for that season\n';

    if (includeHotels) {
      basePrompt += '- Hotel (prefer not to change it unless traveling to another city)\n';
    }

    if (includeRestaurants) {
      basePrompt += '- 2 Restaurants, one for lunch and another for dinner, with shortened Google Map links\n';
    }

    basePrompt += 'and give me a daily summary of the above points into a paragraph or two.\n';

    try {
      final openAiApi = OpenAiApi('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'); // Replace with your OpenAI API key
      final response = await openAiApi.generateCompletion(basePrompt);

      setState(() {
        apiOutput = response;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Your existing UI widgets for capturing user input
            TextField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Select a country'),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(labelText: 'Number of days'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: monthController,
              decoration: InputDecoration(labelText: 'Select a month'),
            ),
            CheckboxListTile(
              title: Text('Include Restaurants'),
              value: includeRestaurants,
              onChanged: (value) {
                setState(() {
                  includeRestaurants = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Hotels'),
              value: includeHotels,
              onChanged: (value) {
                setState(() {
                  includeHotels = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: isGenerating ? null : callGenerateEndpoint,
              child: Text(isGenerating ? 'Applying magic now...' : 'Generate'),
            ),
            SizedBox(height: 20),
            // Display the generated output
            apiOutput.isNotEmpty
                ? Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(apiOutput),
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestPage(),
  ));
}
