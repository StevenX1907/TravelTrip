import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../reusable_widgets/dark_mode.dart';
import '../../reusable_widgets/side_menu.dart';
import '../utils/utils.dart';
import 'package:travel_trip_application/reusable_widgets/exchange_coin.dart';
void main() {
  runApp(ExchangeApp());
}

class ExchangeApp extends StatefulWidget {
  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<ExchangeApp> {
  final apiKey = "257e90646060f905c184456d";
  final apiUrl = "https://v6.exchangerate-api.com/v6/257e90646060f905c184456d/latest/USD";
  double usdRate = 0.0;
  double selectedRate = 0.0; // Represents the currently selected currency rate
  TextEditingController usdController = TextEditingController();
  TextEditingController foreignController = TextEditingController();

  final exchangeRateService = ExchangeRateService();

  List<String> currencies = ["TWD", "VND", "MYR", "IDR"];
  String selectedCurrency = "TWD"; // Default selected currency

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic parsedData = json.decode(response.body);
        if (parsedData is Map<String, dynamic> &&
            parsedData["result"] == "success") {
          final Map<String, dynamic> rates = parsedData["conversion_rates"];
          if (rates.containsKey("USD")) {
            usdRate = rates["USD"];
          }
          if (rates.containsKey(selectedCurrency)) {
            selectedRate = rates[selectedCurrency];
          }
        }
      }
    } catch (e) {
      print('Error retrieving exchange rates: $e');
    }
  }


  double convertCurrency(double amount, double rate) {
    return amount * rate;
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return MaterialApp(
      title: 'Exchange Coin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exchange Coin'),
          backgroundColor: isDarkMode ? Colors.black : const Color(0xFF306550),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/members/jie.jpg'),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/members/jie.jpg'),
                  ),
                ],
              ),
              Text(
                '1 USD to ${selectedCurrency} Exchange Rate: ${selectedRate.toStringAsFixed(4)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: usdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter USD'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (usdController.text.isNotEmpty) {
                    double usdAmount = double.parse(usdController.text);
                    double foreignResult = convertCurrency(usdAmount, selectedRate);
                    foreignController.text = foreignResult.toStringAsFixed(2);
                  }
                },
                child: Text('Convert to ${selectedCurrency}'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: foreignController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter ${selectedCurrency}'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (foreignController.text.isNotEmpty) {
                    double foreignAmount = double.parse(foreignController.text);
                    double usdResult = convertCurrency(foreignAmount, 1 / selectedRate);
                    usdController.text = usdResult.toStringAsFixed(2);
                  }
                },
                child: Text('Convert to USD'),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                    _fetchExchangeRates();
                  });
                },
                items: currencies.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


