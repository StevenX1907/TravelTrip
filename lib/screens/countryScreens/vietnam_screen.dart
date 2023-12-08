  import 'dart:convert';
  import 'dart:typed_data';
  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
  import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
import 'package:travel_trip_application/screens/vietnam/destinations/Hue.dart';
import 'package:travel_trip_application/screens/vietnam/destinations/Phong%20Nha-Ke%20Bang%20National%20Park.dart';
import 'package:travel_trip_application/screens/vietnam/hotels/Havana%20Nha%20Trang%20Hotel.dart';
import 'package:travel_trip_application/screens/vietnam/hotels/RAON.dart';
import 'package:travel_trip_application/screens/vietnam/hotels/The%20Oriental%20Jade%20Hotel.dart';
import 'package:travel_trip_application/screens/vietnam/restaurants/Cuc%20Gach%20Quan.dart';
import 'package:travel_trip_application/screens/vietnam/restaurants/Era.dart';
import 'package:travel_trip_application/screens/vietnam/restaurants/Man%20Moi.dart';
import 'package:travel_trip_application/screens/vietnam/restaurants/terraco.dart';
import 'package:travel_trip_application/screens/vietnam/restaurants/terracoSkyBar.dart';
  import '../../gen_l10n/app_localizations.dart';
import '../../reusable_widgets/dark_mode.dart';
  import '../utils/utils.dart';
  import 'dart:async';
  import 'package:carousel_slider/carousel_slider.dart';
  import 'package:http/http.dart' as http;

import '../vietnam/destinations/danang.dart';
import '../vietnam/destinations/haiphong.dart';
import '../vietnam/destinations/halongbay.dart';
import '../vietnam/hotels/eden.dart';
import '../vietnam/hotels/metooHomestay.dart';

  class Vietnam_screen extends StatefulWidget {
    const Vietnam_screen({Key? key}) : super(key: key);

    @override
    State<Vietnam_screen> createState() => _VietnamScreenState();
  }

  class _VietnamScreenState extends State<Vietnam_screen> {
    int currentIndex = 0;
    String currentTemperature = "Loading...";
    double exchangeRate = 0.0;
    Map<String, dynamic>? countryData;
    bool isCountryDataLoaded = false;
    late List<Map<String, String>> destinations;
    late List<Map<String, String>> hotels;
    late List<Map<String, String>> restaurants;
    List<String> events = [
      'vn.jfif',
      'vn1.jfif',
      'vn2.jfif',
      'vn3.jfif',
    ];
    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      // Initialize lists with translated text
      destinations = [
        {
          'name': AppLocalizations.of(context).DanangScreen,
          'image': 'assets/images/events/Da_nang1.jfif',
        },
        {
          'name': AppLocalizations.of(context).haLongBay,
          'image': 'assets/images/events/Ha_long_bay.jfif',
        },
        {
          'name': AppLocalizations.of(context).haiPhong,
          'image': 'assets/images/events/haiphong.jfif',
        },
      ];

      hotels = [
        {
          'name': AppLocalizations.of(context).edenHotels,
          'image': 'assets/images/hotels/eden_hotel.jpg',
        },
        {
          'name': AppLocalizations.of(context).metooHomestay,
          'image': 'assets/images/hotels/metoo_homestay.jpg',
        },
        {
          'name': AppLocalizations.of(context).raonHotels,
          'image': 'assets/images/hotels/RAON_hotel.jpg',
        },
      ];
      restaurants = [
        {
          'name': AppLocalizations.of(context).terracoSkyBar,
          'image': 'assets/images/restaurants/terraco-sky-bar-offers.jpg',
        },
        {
          'name': AppLocalizations.of(context).eraRes,
          'image': 'assets/images/restaurants/era.jpg',
        },
        {
          'name': AppLocalizations.of(context).caugoRes,
          'image': 'assets/vietnam/restaurants/caugores4.jpg',
        },
      ];
    }

    @override
    void initState() {
      super.initState();
      getCurrentTemperature();
      fetchExchangeRate();
      // if (countryData == null) {
      //   fetchCountryFromServer(1); // Gọi hàm này chỉ khi chưa có dữ liệu
      // }else {
      //   isCountryDataLoaded = true;
      // }
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

    Future<void> fetchExchangeRate() async {
      try {
        final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/VND'));
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
    void navigateToDestinationDetail(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DanangScreen()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Halongbay()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const haiphong()),
        );
      }else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Hue()),
        );
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Phong()),
        );
      }
      // Add more conditions for other items as needed
    }
    void navigateToHotelsDetail(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const edenHotels()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const metooHomestay()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RAONHotel()),
        );
      }else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Jade()),
        );
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Hav()),
        );
      }
      // Add more conditions for other items as needed
    }
    void navigateToRestaurantDetail(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const terracoSkyBar()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EraRes()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const terracoRes()),
        );
      }else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Cuc()),
        );
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ManMoi()),
        );
      }
      // Add more conditions for other items as needed
    }
    @override
    Widget build(BuildContext context) {
      final darkModeProvider = Provider.of<DarkModeExample>(context);
      final isDarkMode = darkModeProvider.isDarkMode;
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).vietnam),
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
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                  child: Image.asset('assets/images/VN_weather.png'),
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

                    },
                    child: Text(
                      AppLocalizations.of(context).moreDetail,
                      style: const TextStyle(fontSize: 16, color: Colors.blue),
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
                      '1 VND = ${exchangeRate.toStringAsFixed(2)} TWD',
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