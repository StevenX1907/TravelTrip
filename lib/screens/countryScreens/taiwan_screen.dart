import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
import 'package:http/http.dart' as http;
import '../../reusable_widgets/dark_mode.dart';
import '../../reusable_widgets/destination_details.dart';
import '../utils/utils.dart';
import 'ExchangeApp.dart';
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
  List<String> events = [
    'taiwan.jfif',
    'taiwan1.jfif',
    'taiwan2.jfif',
    'taiwan3.jfif',
  ];

  List<Map<String, String>> destinations = [
    {
      'name': 'Wulai',
      'image': 'assets/images/destinations/wulai.jpg',
    },
    {
      'name': ' Kenting National Park',
      'image': 'assets/images/destinations/kenting_national_park.jpg',
    },
    {
      'name': 'Kinmen Islands',
      'image': 'assets/images/destinations/kinmen_islands.jpg',
    },

  ];
  List<Map<String, String>> hotels = [
    {
      'name': 'Grand Hyatt Taipei',
      'image': 'assets/images/hotels/Grand_Hyatt.jfif',
    },
    {
      'name': 'WORK INN at Taipei 101',
      'image': 'assets/images/hotels/WORKINN.jfif',
    },
    {
      'name': 'Hanns House',
      'image': 'assets/images/hotels/HannsHouse.jfif',
    },
  ];
  List<Map<String, String>> restaurants = [
    {
      'name': 'Mosun Teppanyaki',
      'image': 'assets/images/hotels/Mosun_Teppanyaki.jfif',
    },
    {
      'name': '食令Shabu',
      'image': 'assets/images/hotels/Shabu.jfif',
    },
    {
      'name': 'Matsusaka Tei',
      'image': 'assets/images/hotels/MatsusakaTei.jfif',
    },
  ];

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
  Future<Map<String, dynamic>> fetchDestinationDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/getDestination/$id'));
      if (response.statusCode == 200) {
        Map<String, dynamic> destinationData = jsonDecode(response.body);
        return {
          'imageData': destinationData['imgData'],
          'destinationName': destinationData['destinationName'],
          // 'destination_description': destinationData['description'],
        };
      } else {
        throw Exception('Failed to load destination details');
      }
    } catch (e) {
      print('Error fetching destination details: $e');
      throw e;
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




  void _onDestinationTap(Map<String, dynamic> destination) {
    int id = destinationList.indexOf(destination) + 1; // Assuming ids start from 1

    // Thực hiện fetchDestinationDetails ở đây và sau đó mở DestinationDetailsScreen
    fetchDestinationDetails(id).then((destinationData) {
      // Chuyển đổi destinationData từ Map<String, dynamic> sang Map<String, String>
      Map<String, String> convertedData = Map<String, String>.from(destinationData);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DestinationDetailsScreen(
            image: destination['image']!,
            name: destination['destination_name']!,
            description: convertedData['destination_description'] ?? 'No description available',
          ),
        ),
      );
    }).catchError((error) {
      print('Error fetching destination details: $error');
    });
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
                const Text(
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
                  child: const Text(
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
                child: Image.asset('assets/images/taiwan_weather.png'),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ExchangeApp()),
                    );
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
            FutureBuilder<Map<String, dynamic>>(
              future: fetchDestinationDetails(1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final countryData = snapshot.data!;
                  final String countryName = countryData['destinationName'] ?? 'Unknown';
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
            const SizedBox(height: 10),
            Container(
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinationList.length,
                itemBuilder: (BuildContext context, int index) {
                  final destination = destinationList[index];
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () async {
                        final destinationData = await fetchDestinationDetails(destination['id']);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DestinationDetailsScreen(
                              image: destinationData['image'] ?? 'assets/images/Taiwan1.jpeg',
                              name: destinationData['destination_name'] ?? 'Unknown',
                              description: destinationData['destination_description'] ?? 'No description available',
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Flexible(
                            child: Image.memory(
                              base64.decode(destination['image'] ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            destination['destination_name'] ?? '',
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
                      mainAxisSize: MainAxisSize.min,
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
                      mainAxisSize: MainAxisSize.min,
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
