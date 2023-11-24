import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../reusable_widgets/dark_mode.dart';
import '../../reusable_widgets/side_menu.dart';
import '../utils/utils.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final apiKey = "fe65bdcc943ea9296fb86ce7009d0216";
  final apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=";
  final searchBoxController = TextEditingController();
  String cityName = "";
  String temperature = "0°C";
  String humidity = "0%";
  String windSpeed = "0 km/h";
  String weatherIcon = "assets/images/rain.png";
  String errorMessage = "";
  bool isErrorVisible = false;

  @override
  void dispose() {
    searchBoxController.dispose();
    super.dispose();
  }

  Future<void> checkWeather(String city) async {
    try {
      final response = await http.get(Uri.parse(apiUrl + city + "&appid=$apiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cityName = data['name'];
          temperature = "${data['main']['temp'].round()}°C";
          humidity = "${data['main']['humidity']}%";
          windSpeed = "${data['wind']['speed']} km/h";
          switch (data['weather'][0]['main']) {
            case "Clouds":
              weatherIcon = "assets/images/clouds.png";
              break;
            case "Clear":
              weatherIcon = "assets/images/clear.png";
              break;
            case "Rain":
              weatherIcon = "assets/images/rain.png";
              break;
            case "Drizzle":
              weatherIcon = "assets/images/drizzle.png";
              break;
            case "Mist":
              weatherIcon = "assets/images/mist.png";
              break;
            default:
              weatherIcon = "assets/images/rain.png";
          }
          isErrorVisible = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          errorMessage = "City not found.";
          isErrorVisible = true;
        });
      } else {
        setState(() {
          errorMessage = "An error occurred.";
          isErrorVisible = true;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred.";
        isErrorVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    Color appBarColor = isDarkMode ? Colors.black : const Color(0xFF306550);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelTrip'),
        backgroundColor: appBarColor,
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
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black38, Colors.black38]
                : [
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height:20),
                TextField(
                  controller: searchBoxController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    suffixIcon: IconButton(
                      onPressed: () {
                        checkWeather(searchBoxController.text);
                      },
                      icon: Icon(Icons.search),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Visibility(
                  visible: !isErrorVisible,
                  child: Column(
                    children: [
                      Image.asset(
                        weatherIcon,
                        width: 170.0,
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        temperature,
                        style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cityName,
                        style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                color: Colors.black,
                                'assets/images/humidity.png',
                                width: 50.0,
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                humidity,
                                style: TextStyle(fontSize: 28.0),
                              ),
                              Text(
                                'Humidity',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/wind.png',
                                width: 50.0,
                                color: Colors.black,
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                windSpeed,
                                style: TextStyle(fontSize: 28.0),
                              ),
                              Text(
                                'Wind Speed',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isErrorVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorMessage,
                        style: TextStyle(fontSize: 24.0, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
