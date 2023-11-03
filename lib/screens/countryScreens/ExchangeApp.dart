import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../reusable_widgets/dark_mode.dart';
import '../../reusable_widgets/side_menu.dart';
import '../utils/utils.dart';
import 'package:travel_trip_application/reusable_widgets/exchange_coin.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
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
  double ntdRate = 0.0;

  final exchangeRateService = ExchangeRateService();

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
          if (rates.containsKey("AFN")) {
            usdRate = rates["AFN"];
          }
          if (rates.containsKey("TWD")) {
            ntdRate = rates["TWD"];
          }
        }
      }
    } catch (e) {
      print('Error retrieving exchange rates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          title: const Text('Rate Exchange'),
          backgroundColor: isDarkMode ? Colors.black : const Color(0xFF306550),
        ),
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: isDarkMode
                  ? [
                Colors.black38,
                Colors.black38
              ]
                  : [
                hexStringToColor("F1F9F6"),
                hexStringToColor("D1EEE1"),
                hexStringToColor("AFE1CE")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      height: 80,
                      width: 100,
                      child: Image.asset(
                          'assets/members/jie.jpg', fit: BoxFit.contain),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 80,
                      width: 100,
                      child: Image.asset(
                          'assets/members/jie.jpg', fit: BoxFit.contain),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'AED Exchange Rate: ${usdRate.toStringAsFixed(4)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 30, height: 90),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TWD Exchange Rate: ${ntdRate.toStringAsFixed(4)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}




