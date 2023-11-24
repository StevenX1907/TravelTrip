import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travel_trip_application/screens/taiwan/destinations/wulai.dart';
import 'package:travel_trip_application/screens/taiwan/hotels/Hanns.dart';
import 'package:travel_trip_application/screens/taiwan/hotels/grandTaipei.dart';
import 'package:travel_trip_application/screens/taiwan/restaurants/matsusaka.dart';
import 'package:travel_trip_application/screens/taiwan/restaurants/mosun.dart';
import 'package:travel_trip_application/screens/taiwan/restaurants/shabu.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../../reusable_widgets/destination_details.dart';
import '../taiwan/destinations/kenting.dart';
import '../taiwan/destinations/kinmen.dart';
import '../taiwan/hotels/workINN.dart';
import '../utils/utils.dart';
import 'ExchangeApp.dart';
import '../../gen_l10n/app_localizations.dart';
class Taiwan_screen extends StatefulWidget {
  const Taiwan_screen({Key? key}) : super(key: key);

  @override
  State<Taiwan_screen> createState() => _TaiwanScreenState();
}

class _TaiwanScreenState extends State<Taiwan_screen> {
  List<Map<String, dynamic>> destinationList = [];
  int currentIndex = 0;
  String currentTemperature = "Loading...";
  double exchangeRate = 0.0;
  late List<Map<String, String>> destinations;
  late List<Map<String, String>> hotels;
  late List<Map<String, String>> restaurants;
  List<String> events = [
    'taiwan.jfif',
    'taiwan1.jfif',
    'taiwan2.jfif',
    'taiwan3.jfif',
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     destinations = [
      {
        'name': AppLocalizations.of(context).wulai,
        'image': 'assets/images/destinations/wulai.jpg',
      },
      {
        'name': AppLocalizations.of(context).kenting,
        'image': 'assets/images/destinations/kenting_national_park.jpg',
      },
      {
        'name': AppLocalizations.of(context).kinmen,
        'image': 'assets/images/destinations/kinmen_islands.jpg',
      },

    ];
     hotels = [
      {
        'name': AppLocalizations.of(context).grandTaipei,
        'image': 'assets/images/hotels/Grand_Hyatt.jfif',
      },
      {
        'name': AppLocalizations.of(context).workinn,
        'image': 'assets/images/hotels/WORKINN.jfif',
      },
      {
        'name': AppLocalizations.of(context).hanns,
        'image': 'assets/images/hotels/HannsHouse.jfif',
      },
    ];
    restaurants = [
      {
        'name': AppLocalizations.of(context).mosun,
        'image': 'assets/images/hotels/Mosun_Teppanyaki.jfif',
      },
      {
        'name': AppLocalizations.of(context).shabu,
        'image': 'assets/images/hotels/Shabu.jfif',
      },
      {
        'name': AppLocalizations.of(context).matsu,
        'image': 'assets/images/hotels/MatsusakaTei.jfif',
      },
    ];
  }


  get index => 1;
  @override
  void initState() {
    super.initState();
    getCurrentTemperature();
    fetchExchangeRate();
    fetchDestinations();
  }
  Future<void> getCurrentTemperature() async {
    try {
      const apiKey = "";
      const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=Taiwan&appid=$apiKey";
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

  Future<void> fetchExchangeRate() async {
    try {
      final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/TWD'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          exchangeRate = data['rates']['TWD'];
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

  Future<void> fetchDestinations() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/getDestinations'));
      if (response.statusCode == 200) {
        List<dynamic> destinationData = jsonDecode(response.body);
        setState(() {
          destinationList = List<Map<String, dynamic>>.from(destinationData);
        });
      } else {
        throw Exception('Failed to load destinations');
      }
    } catch (e) {
      print('Error fetching destinations: $e');
    }
  }



  // void _onDestinationTap(Map<String, dynamic> destination) {
  //   int id = destinationList.indexOf(destination) + 1; // Assuming ids start from 1
  //
  //   // Thực hiện fetchDestinationDetails ở đây và sau đó mở DestinationDetailsScreen
  //   fetchDestinationDetails(id).then((destinationData) {
  //     // Chuyển đổi destinationData từ Map<String, dynamic> sang Map<String, String>
  //     Map<String, String> convertedData = Map<String, String>.from(destinationData);
  //
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => DestinationDetailsScreen(
  //           image: destination['image']!,
  //           name: destination['destination_name']!,
  //           description: convertedData['destination_description'] ?? 'No description available',
  //         ),
  //       ),

  void navigateToDestinationDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const wulai()),

      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Kenting()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const kinmen()),
      );
    }
    // Add more conditions for other items as needed
  }
  void navigateToHotelsDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const grandTaipei()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkINN()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const hanns()),
      );
    }
    // Add more conditions for other items as needed
  }
  void navigateToRestaurantDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const mosun()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const shabu()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const matsusaka()),
      );
    }
    // Add more conditions for other items as needed
  }
  // Future<void> getCurrentTemperature() async {
  //   try {
  //     const apiKey = "fe65bdcc943ea9296fb86ce7009d0216";
  //     const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=Vietnam&appid=$apiKey";
  //     final response = await http.get(Uri.parse(apiUrl));
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final temperature = data['main']['temp'];
  //       setState(() {
  //         currentTemperature = "$temperature°C";
  //       });
  //     } else {
  //       setState(() {
  //         currentTemperature = "Error";
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       currentTemperature = "Error";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Taiwan'),
        backgroundColor: isDarkMode?Colors.black:const Color(0xFF306550),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // height: 600,
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
              items: events.map((event) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      'assets/images/events/$event',
                      fit: BoxFit.cover,
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
                  AppLocalizations.of(context).currentTemperature,
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
                    AppLocalizations.of(context).moreDetail,
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
                child: Image.asset('assets/images/taiwan_weather.png'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  AppLocalizations.of(context).exchangeRate,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ExchangeApp()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).moreDetail,
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
                    '1 TWD = ${exchangeRate.toStringAsFixed(2)} USD',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).destinations,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppLocalizations.of(context).moreDetail,
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).hotels,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppLocalizations.of(context).moreDetail,
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
                      navigateToHotelsDetail(index);
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
                Text(
                  AppLocalizations.of(context).restaurants,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppLocalizations.of(context).moreDetail,
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
