import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../gen_l10n/app_localizations.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../../reusable_widgets/side_menu.dart';
import '../utils/utils.dart';
import 'package:travel_trip_application/reusable_widgets/exchange_coin.dart';


class ExchangeApp extends StatefulWidget {
  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}


class _ExchangeAppState extends State<ExchangeApp> {
  TextEditingController amountController = TextEditingController();
  String fromCurrency = 'New Taiwan Dollar (TWD)';
  String toCurrency = 'United States Dollar (USD)';


  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize fromCurrency and toCurrency with translated values
  //   fromCurrency ??= AppLocalizations.of(context).twd;
  //   toCurrency ??= AppLocalizations.of(context).usd;
  // }
  // Helper function to get the full currency name
  String getFullCurrencyName(String currencyCode) {
    // Add logic to get the full currency name based on the currency code
    // For simplicity, I'm just returning the same code for now
    return currencyCode;
  }

  @override
  Widget build(BuildContext context) {
    fromCurrency ??= AppLocalizations.of(context).twd;
    toCurrency ??= AppLocalizations.of(context).usd;
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context).exchangerate),
        backgroundColor: isDarkMode?Colors.black:const Color(0xFF306550),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: isDarkMode
                ? [
              Colors.black38,
              Colors.black38
            ]
                :[
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

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
                Text(AppLocalizations.of(context).from),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: fromCurrency, // Change this line to use fromCurrency instead of toCurrency
                      onChanged: (String? newValue) {
                        setState(() {
                          fromCurrency = newValue!;
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
                      underline: Container(), // Removes the underline
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Third Row: To Currency Dropdown
            Row(
              children: [
                Text(AppLocalizations.of(context).to),
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
                      underline: Container(), // Removes the underline
                    ),
                  ),
                ),
              ],
            ),

            // Fourth Row: Transfer Button centered
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform the currency conversion logic here
                // You can use the entered amount, fromCurrency, and toCurrency
                // to make an API call or perform the necessary calculations
                // Update the UI or show the result accordingly
              },
              child: Text(AppLocalizations.of(context).tranfer),
            ),
          ],
        ),
      ),
    );
  }
}
