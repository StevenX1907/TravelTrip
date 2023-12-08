import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
import 'package:travel_trip_application/screens/indonesia/destinations/Jakarta.dart';
import 'package:travel_trip_application/screens/indonesia/destinations/LabuanBajo.dart';
import 'package:travel_trip_application/screens/indonesia/destinations/bali_island.dart';
import 'package:travel_trip_application/screens/indonesia/events/AdiwanaUnagiSuites.dart';
import 'package:travel_trip_application/screens/indonesia/events/Padma_Resort.dart';
import 'package:travel_trip_application/screens/indonesia/events/four_seasons_bali.dart';
import 'package:travel_trip_application/screens/indonesia/events/gaia_bandung.dart';
import 'package:travel_trip_application/screens/indonesia/events/kempinski_jakarta.dart';
import 'package:travel_trip_application/screens/indonesia/restaurants/Feast%20by%20Kokiku.dart';
import 'package:travel_trip_application/screens/indonesia/restaurants/Kudeta.dart';
import 'package:travel_trip_application/screens/indonesia/restaurants/Soulfood.dart';
import 'package:travel_trip_application/screens/indonesia/restaurants/bandarDJakarta.dart';
import 'package:travel_trip_application/screens/indonesia/restaurants/blueTerrace.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../indonesia/destinations/borobudur_temple.dart';
import '../indonesia/destinations/kota_tua.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';
import '../../gen_l10n/app_localizations.dart';
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
  late List<Map<String, String>> destinations;
  late List<Map<String, String>> hotels;
  late List<Map<String, String>> restaurants;
  List<String> events = [
    'assets/indonesia/events/Event_Indonesia_1.jpeg',
    'assets/indonesia/events/Event_Indonesia_2.jpeg',
    'assets/indonesia/events/Event_Indonesia_3.jpeg',
    'assets/indonesia/events/Event_Indonesia_4.jpeg',
    'assets/indonesia/events/Event_Indonesia_5.jpeg'
  ];
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize lists with Indonesian content
    destinations = [
      {
        'name': AppLocalizations.of(context).baliIsland,
        'image': 'assets/indonesia/destinations/Bali_3.jpeg',
      },
      {
        'name': AppLocalizations.of(context).BorobudurTemple,
        'image': 'assets/indonesia/destinations/Borobudur 3.jpeg',
      },
      {
        'name': AppLocalizations.of(context).jakartaOldTown,
        'image': 'assets/indonesia/destinations/Kota Tua 1.jpeg',
      },
    ];

    hotels = [
      {
        'name': AppLocalizations.of(context).fourSeasons,
        'image': 'assets/indonesia/hotels/Four Seasons Bali 1.jpeg',
      },
      {
        'name': AppLocalizations.of(context).gaiaHotel,
        'image': 'assets/indonesia/hotels/Gaia Hotel 1.jpeg',
      },
      {
        'name': AppLocalizations.of(context).kempinski,
        'image': 'assets/indonesia/hotels/Kempinski 1.jpeg',
      },
    ];

    restaurants = [
      {
        'name': AppLocalizations.of(context).bandarDjakarta,
        'image': 'assets/indonesia/restaurants/Bandar 1.jpeg',
      },
      {
        'name': AppLocalizations.of(context).blueTerrace,
        'image': 'assets/indonesia/restaurants/Blue Terrace 1.jpeg',
      },
      {
        'name': AppLocalizations.of(context).kudeta,
        'image': 'assets/indonesia/restaurants/Kudeta 4.jpeg',
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    getCurrentTemperature();
    //fetchExchangeRate();
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

  void navigateToEventDetail(int index) {
    // You can replace these conditions with your actual logic
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => borobudurTemple()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => baliIsland()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => kotaTua()),
      );
    }
    // Add more conditions for other items as needed
  }

  void navigateToDestinationDetail(int index) {
    // You can replace these conditions with your actual logic
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => baliIsland()),
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
    else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Jakarta()),
      );
    }
    else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LabuanBajo()),
      );
      // Add more conditions for other items as needed
    }
  }

  void navigateToRestaurantDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => bandarDjakarta()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => blueTerrace()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => kudeta()),
      );
    }else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PadmaResort()),
      );
    }
    else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Adiwana()),
      );
      // Add more conditions for other items as needed
    }
    // Add more conditions for other items as needed
  }

  void navigateToHotelDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => fourSeasons()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => gaiaBandung()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => kempinskiJakarta()),
      );
    }
          else if (index == 3) {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Kokiku()),
          );
          }
          else if (index == 4) {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Soulfood()),
          );
          // Add more conditions for other items as needed
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

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
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
                        navigateToEventDetail(index);
                        print('Image at index $index clicked');
                      },
                      child: Image.asset(
                        '$event',
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
                  return GestureDetector(
                    onTap: () {
                      // Handle the destination image click here
                      navigateToHotelDetail(index);
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  '  Restaurants',
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
                  return GestureDetector(
                    onTap: () {
                      // Handle the destination image click here
                      navigateToRestaurantDetail(index);
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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