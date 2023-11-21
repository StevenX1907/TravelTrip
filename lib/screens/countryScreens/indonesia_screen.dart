import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../indonesia/destinations/borobudur_temple.dart';
import '../indonesia/destinations/komodo_park.dart';
import '../indonesia/destinations/kota_tua.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Indonesia_screen extends StatefulWidget {
  const Indonesia_screen({Key? key}) : super(key: key);

  @override
  State<Indonesia_screen> createState() => _IndonesiaScreenState();
}

class _IndonesiaScreenState extends State<Indonesia_screen> {
  int currentIndex = 0;
  String currentTemperature = "Loading...";
  double exchangeRate = 0.0;
  List<String> events = [
    'Event_Indonesia_1.jpeg',
    'Event_Indonesia_2.jpeg',
    'Event_Indonesia_3.jpeg',
    'Event_Indonesia_4.jpeg',
    'Event_Indonesia_5.jpeg'
  ];
  List<Map<String, String>> destinations = [
    {
      'name': 'Beaches of Bali',
      'image': 'assets/images/destinations/indonesia-beaches-of-bali.jpg',
    },
    {
      'name': 'Borobudur',
      'image': 'assets/images/destinations/indonesia-borobudur.jpg',
    },
    {
      'name': 'Gili Islands',
      'image': 'assets/images/destinations/indonesia-gili-islands.jpg',
    },
  ];
  List<Map<String, String>> hotels = [
    {
      'name': 'Dream of Aventus Hotel Kuta',
      'image': 'assets/images/hotels/Dream_of_Aventus_Hotel.jfif',
    },
    {
      'name': 'MaxOne Rejuvination',
      'image': 'assets/images/hotels/MaxOne_Rejuvination.jpg',
    },
    {
      'name': 'North Wing Canggu Resort',
      'image': 'assets/images/hotels/North_Wing_Canggu_Resort.jfif',
    },
  ];
  List<Map<String, String>> restaurants = [
    {
      'name': 'Jakarta Restaurants',
      'image': 'assets/images/restaurants/Jakarta_Restaurants.jfif',
    },
    {
      'name': 'Bandung Restaurants',
      'image': 'assets/images/restaurants/Jakarta_Restaurants.jfif',
    },
    {
      'name': 'Surabaya Restaurants',
      'image': 'assets/images/restaurants/Surabaya_Restaurants.jfif',
    },
  ];
  @override
  void initState() {
    super.initState();
    getCurrentTemperature();
    fetchExchangeRate();
  }
  Future<void> getCurrentTemperature() async {
    try {
      const apiKey = "";
      const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=Vietnam&appid=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final temperature = data['main']['temp'];
        setState(() {
          currentTemperature = "$temperature°C";
        });
      } else {
        setState(() {
          currentTemperature = "Error";
        });
      }
    } catch (e) {
      setState(() {
        currentTemperature = "Error";
      });
    }
  }

  void navigateToDetailPage(int index) {
    // You can replace these conditions with your actual logic
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => borobudurTemple()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => komodoPark()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => kotaTua()),
      );
    }
    // Add more conditions for other items as needed
  }


  Future<void> fetchExchangeRate() async {
    try {
      final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/IDR'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          exchangeRate = data['rates']['IDR'];
        });
      } else {
        setState(() {
          exchangeRate = 0.0;
        });
      }
    } catch (e) {
      setState(() {
        exchangeRate = 0.0;
      });
    }
  }
  void navigateToDestinationDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => komodoPark()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => borobudurTemple()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => kotaTua()),
      );
    }
    // Add more conditions for other items as needed
  }
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Indonesia'),
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

        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 210,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                initialPage: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: events.asMap().entries.map((entry) {
                int index = entry.key;
                String event = entry.value;
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        // Handle the image click here, e.g., navigate to a detail screen
                        // You can use the index to identify the selected image
                        navigateToDetailPage(index);
                        print('Image at index $index clicked');
                      },
                      child: Image.asset(
                        'assets/images/events/$event',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: events.map((event) {
                int index = events.indexOf(event);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.green : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  Current Temperature',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  WeatherApp()),
                    );
                  },
                  child: Text(
                    'More Detail',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Text(
            //   currentTemperature,
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Card(
              child: Container(
                child: Image.asset('assets/images/Indo_weather.png'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '   Exchange Rate',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: const Text(
                    'More Detail',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Text(
            //   '1 VND = ${exchangeRate.toStringAsFixed(2)} TWD',
            //   style: TextStyle(fontSize: 16),
            // ),
            Card(
              child: Container(
                width: 50,
                height:50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: isDarkMode
                        ? [
                      Colors.black38,
                      Colors.black38
                    ]
                        :[
                      Colors.grey.shade50,
                      Colors.grey.shade50,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '1 IDR = ${exchangeRate.toStringAsFixed(2)} TWD',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '   Destinations',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: const Text(
                    'More Detail',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle the destination image click here
                      navigateToDestinationDetail(index);
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              destinations[index]['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            destinations[index]['name']!,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '   Hotels',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: const Text(
                    'More Detail',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            hotels[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hotels[index]['name']!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Restaurants',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: const Text(
                    'More Detail',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            restaurants[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurants[index]['name']!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),

      ),

    );
  }
}
