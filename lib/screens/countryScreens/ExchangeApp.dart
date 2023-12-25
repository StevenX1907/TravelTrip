import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gen_l10n/app_localizations.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../utils/utils.dart';

// Import other necessary dependencies

class ExchangeApp extends StatefulWidget {
  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<ExchangeApp> {
  TextEditingController amountController = TextEditingController();
  String fromCurrency = 'New Taiwan Dollar (TWD)';
  String toCurrency = 'United States Dollar (USD)';
  Map<String, double> defaultExchangeRates = {
    'United States Dollar (USD)': 1.0,
    'Vietnamese Dong (VND)': 24.275,
    'New Taiwan Dollar (TWD)': 31.19,
    'Indonesian Rupiah (IDR)': 15.486,
    'Malaysian Ringgit (MYR)': 4.63,
  };

  @override
  Widget build(BuildContext context) {
    fromCurrency ??= AppLocalizations.of(context).twd;
    toCurrency ??= AppLocalizations.of(context).usd;
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).exchangerate),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFF306550),
      ),
      body: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Row: Amount Input
            Row(
              children: [
                Text(AppLocalizations.of(context).amount),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      convertCurrency();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).amountDes,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Second Row: From Currency Display
            Row(
              children: [
                Text(AppLocalizations.of(context).from + '     '),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: fromCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          fromCurrency = newValue!;
                          convertCurrency();
                        });
                      },
                      items: [
                        'United States Dollar (USD)',
                        'Vietnamese Dong (VND)',
                        'New Taiwan Dollar (TWD)',
                        'Indonesian Rupiah (IDR)',
                        'Malaysian Ringgit (MYR)',
                      ]
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                          .toList(),
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Third Row: To Currency Dropdown
            Row(
              children: [
                Text(AppLocalizations.of(context).to + '         '),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: toCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          toCurrency = newValue!;
                          convertCurrency();
                        });
                      },
                      items: [
                        'United States Dollar (USD)',
                        'Vietnamese Dong (VND)',
                        'New Taiwan Dollar (TWD)',
                        'Indonesian Rupiah (IDR)',
                        'Malaysian Ringgit (MYR)',
                      ]
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                          .toList(),
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Result: '),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Result',
                    ),
                    controller: TextEditingController(
                      text:
                      ' ${calculateConvertedAmount()} ',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void convertCurrency() {
    // Validate the entered amount
    double amount;
    try {
      amount = double.parse(amountController.text);
    } catch (e) {
      // Handle invalid amount
      return;
    }

    // Update the UI with the result

  }

  double calculateConvertedAmount() {
    // Validate the entered amount
    double amount;
    try {
      amount = double.parse(amountController.text);
    } catch (e) {
      // Handle invalid amount
      return 0.0; // Return a default value or handle it as appropriate for your use case
    }

    // Calculate the converted amount based on default exchange rates
    double exchangeRate = defaultExchangeRates[toCurrency]! / defaultExchangeRates[fromCurrency]!;

    // Use try-catch to handle potential errors during the calculation
    try {
      double result = amount * exchangeRate;
      return result;
    } catch (e) {
      // Handle any errors during the calculation
      return 0.0; // Return a default value or handle it as appropriate for your use case
    }
  }

}

// Add the necessary utility functions and classes (e.g., hexStringToColor, DarkModeExample) that are used in your code.
