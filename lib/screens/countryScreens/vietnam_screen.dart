  import 'dart:convert';
  import 'dart:typed_data';

  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
  import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
  import '../../reusable_widgets/dark_mode.dart';
  import '../utils/utils.dart';
  import 'dart:async';
  import 'package:carousel_slider/carousel_slider.dart';
  import 'package:http/http.dart' as http;

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
    bool _hasFetchedData = false;
    String countryName = 'Unknown';
    String base64ImageData = '';
    List<String> events = [
      'vn.jfif',
      'vn1.jfif',
      'vn2.jfif',
      'vn3.jfif',
    ];
    List<Map<String, String>> destinations = [
      {
        'name': 'Da Nang',
        'image': 'assets/images/events/Da_nang1.jfif',
      },
      {
        'name': 'Ha Long Bay',
        'image': 'assets/images/events/Ha_long_bay.jfif',
      },
      {
        'name': 'Hai Phong',
        'image': 'assets/images/events/haiphong.jfif',
      },
    ];
    List<Map<String, String>> hotels = [
      {
        'name': 'Eden Hotel',
        'image': 'assets/images/hotels/eden_hotel.jpg',
      },
      {
        'name': 'Metoo Homestay',
        'image': 'assets/images/hotels/metoo_homestay.jpg',
      },
      {
        'name': 'RAON hotel',
        'image': 'assets/images/hotels/RAON_hotel.jpg',
      },
    ];
    List<Map<String, String>> restaurants = [
      {
        'name': 'Terraço Sky Bar & Restaurant',
        'image': 'assets/images/restaurants/terraco-sky-bar-offers.jpg',
      },
      {
        'name': 'Era Restaurant',
        'image': 'assets/images/restaurants/era.jpg',
      },
      {
        'name': 'Terraço',
        'image': 'assets/images/restaurants/terraco-sky-bar-offers.jpg',
      },
    ];
    @override
    void initState() {
      super.initState();
      getCurrentTemperature();
      fetchExchangeRate();
      if (countryData == null) {
        fetchCountryFromServer(1); // Gọi hàm này chỉ khi chưa có dữ liệu
      }
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
    Future<Map<String, dynamic>> fetchCountryFromServer(int id) async {
      try {
        final response = await http.get(Uri.parse('http://10.0.2.2:8080/getCountry/$id'));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return {
            'countryName': data['countryName'],
            'imageData': data['imageData'],
          };
        } else {
          throw Exception('Failed to load country data');
        }
      } catch (e) {
        throw Exception('Error: $e');
      }
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
          title: const Text('Vietnam'),
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
              FutureBuilder<Map<String, dynamic>>(
                future: fetchCountryFromServer(1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final countryData = snapshot.data!;
                    final String countryName = countryData['countryName'] ?? 'Unknown';
                    final String base64ImageData = countryData['imageData'] ?? ''; // Dữ liệu hình ảnh Base64

                    double desiredWidth = 100.0;
                    double desiredHeight = 100.0;

                    // Chuyển dữ liệu Base64 thành mảng bytes
                    Uint8List bytes = base64.decode(base64ImageData);

                    return Column(
                      children: [
                        Text('Country Name: $countryName'),
                        SizedBox(height: 10),
                        // Sử dụng Image.memory để hiển thị hình ảnh từ dữ liệu Base64
                        Image.memory(
                          bytes,
                          width: desiredWidth,
                          height: desiredHeight,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  } else {
                    return Text('No country data.');
                  }
                },
              ),


              Card(
                child: Container(
                  child: Image.asset('assets/images/VN_weather.png'),
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
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
                  );
                },
              ),
            ),
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
                    '   Restaurants',
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