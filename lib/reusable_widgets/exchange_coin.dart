import 'dart:convert';
import 'package:dio/dio.dart';

class ExchangeRateService {
  final Dio _dio = Dio();

  Future<Map<String, double>> getExchangeRate(String baseCurrency,
      String targetCurrency) async {
    try {
      final response = await _dio.get(
          'https://v6.exchangerate-api.com/v6/257e90646060f905c184456d/latest/$baseCurrency');
      if (response.statusCode == 200) {
        final String responseBody = response.data.toString();

        final dynamic parsedData = json.decode(responseBody);
        if (parsedData is Map<String, dynamic> && parsedData['result'] == 'success') {
          final Map<String, dynamic> rates = parsedData['conversion_rates'];
          final Map<String, double> exchangeRates = {};
          for (String currencyCode in rates.keys) {
            final double rate = double.parse(rates[currencyCode].toString());
            exchangeRates[currencyCode] = rate;
          }
          return exchangeRates;
        } else {
          throw Exception('Failed to retrieve exchange rate');
        }
      } else {
        throw Exception('Failed to retrieve exchange rate');
      }
    } catch (e) {
      print('Error retrieving exchange rate: $e');
      throw e;
    }
  }
}
  class CurrencyData {
    final String currencyName;
    final double exchangeRate;
    final String buyRate;
    final String sellRate;

    CurrencyData({
      required this.currencyName,
      required this.exchangeRate,
      required this.buyRate,
      required this.sellRate,
    });

}
