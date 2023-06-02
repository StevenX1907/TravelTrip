import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/reusable_widgets/exchange_coin.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

class Malaysia_screen extends StatefulWidget {
  const Malaysia_screen({Key? key}) : super(key: key);
  @override
  State<Malaysia_screen> createState() => _MalaysiaScreenState();
}

class _MalaysiaScreenState extends State<Malaysia_screen> {
  final ExchangeRateService exchangeRateService = ExchangeRateService();
  final List<String> currencies = ['USD', 'GBP', 'EUR'];


  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
        backgroundColor: isDarkMode?Colors.black:Color(0xFF306550),
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('TravelTrip'),
        ),
      body: FutureBuilder<Map<String, double>>(
        future: exchangeRateService.getExchangeRate('CNY','AND'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
            } else if (snapshot.hasData) {
              final exchangeRates = snapshot.data!;
              final currencyDataList = currencies.map((currency) {
                final exchangeRate = exchangeRates[currency] ?? 0.0;

                return CurrencyData(
                  currencyName: currency,
                  exchangeRate: exchangeRate,
                  buyRate: '10',
                  sellRate: '10',
                );
              }).toList();

              return GridView.count(
                crossAxisCount: 3,
                children: List.generate(currencyDataList.length, (index) {
                  final currencyData = currencyDataList[index];
                  return GridTile(
                    child: Container(
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
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currencyData.currencyName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Buy: ${currencyData.buyRate}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Sell: ${currencyData.sellRate}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Exchange Rate: ${currencyData.exchangeRate}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }
            return const SizedBox.shrink();
          },
        ),
    );
  }
}