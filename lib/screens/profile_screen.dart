import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/editprofile.dart';
import 'package:travel_trip_application/screens/personality_screen.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import 'package:travel_trip_application/screens/vietnam/itineraryProvider.dart';
import '../reusable_widgets/dark_mode.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:travel_trip_application/reusable_widgets/photo_utils.dart';
import 'package:path_provider/path_provider.dart';
import '../gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String gender;
  final String nationality;

  ProfilePage(
      {required this.name, required this.gender, required this.nationality});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();
  int selectedIndex = 0;
  List<File?> gridImages = List.generate(100, (index) => null);
  TextEditingController editingController = TextEditingController();
  bool isEditing = false;
  int editingIndex = -1;
  late TabController _tabController;
  final parser = EmojiParser();
  final US = Emoji('flag_us', '🇺🇸');

  Future<void> _selectImageForGrid(int index) async {
    if (gridImages[0] != null) {
      int newIndex = 1;
      while (gridImages[newIndex] != null) {
        newIndex++;
      }

      if (newIndex < 100) {
        index = newIndex;
      } else {
        return;
      }
    }

    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        gridImages[index] = File(pickedFile.path);
      });
    }
  }

  void _showDeleteMenu(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.delete),
              title: Text(AppLocalizations.of(context).deletephoto),
              onTap: () {
                setState(() {
                  gridImages[index] = null;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.visibility),
              title: Text(AppLocalizations.of(context).checkphoto),
              onTap: () {
                _viewImage(index);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _viewImage(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: gridImages[index] != null
                  ? Image.file(
                gridImages[index]!,
                fit: BoxFit.contain,
              )
                  : Text(AppLocalizations.of(context).Noimageavailable),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final itineraryProvider = Provider.of<ItineraryProvider>(context);

    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile),
        backgroundColor: isDarkMode ? Colors.black : Color(0xFF306550),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'option1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalityScreen(),
                  ),
                );
              } else if (value == 'option2') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      onProfileUpdated: (name, gender, nationality) {
                        setState(() {});
                      },
                    ),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option1',
                child: Text(AppLocalizations.of(context).PersonalityTest),
              ),
              PopupMenuItem<String>(
                value: 'option2',
                child: Text(AppLocalizations.of(context).EditProfile),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: isDarkMode ? Colors.black38 : Colors.white10,
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/47.jpg",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '@johndoe',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context).usa +
                            ' ' +
                            parser.emojify('🇺🇸'),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '9',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).posts,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '1000',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).followers,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '500',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).following,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context).posts),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context).ratings),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context).commets),
              ),
            ],
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.blueGrey,
            indicatorColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Posts page
                Container(
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
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    padding: EdgeInsets.all(4.0),
                    children: List.generate(
                      30,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            _selectImageForGrid(index);
                          },
                          onLongPress: () {
                            _showDeleteMenu(context, index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: gridImages[index] != null
                                  ? DecorationImage(
                                image: FileImage(gridImages[index]!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Ratings page
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var itinerary in itineraryProvider.itineraries)
                        ExpansionTile(
                          title: isEditing && editingIndex == itineraryProvider.itineraries.indexOf(itinerary)
                              ? TextFormField(
                            controller: editingController,
                            decoration: InputDecoration(
                              labelText: 'Edit Itinerary',
                              border: OutlineInputBorder(),
                            ),
                          )
                              : Text(
                            itinerary.generatedText,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            'Rating: ${itinerary.userRating}',
                            style: TextStyle(fontSize: 18),
                          ),
                          children: [
                            // Add any other widgets you want to display for each expanded itinerary
                            // This can include a more detailed view of the itinerary
                            if (isEditing && editingIndex == itineraryProvider.itineraries.indexOf(itinerary))
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    // Save the changes when the user clicks on Save button
                                    itinerary.generatedText = editingController.text;
                                    isEditing = false;
                                  });
                                },
                                child: Text('Save'),
                              ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  // Toggle editing mode when the user clicks on the edit icon
                                  isEditing = !isEditing;
                                  editingIndex = itineraryProvider.itineraries.indexOf(itinerary);
                                  editingController.text = itinerary.generatedText;
                                });
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),


                // Comments page
                Container(
                  child: Center(
                    child: Text(
                        AppLocalizations.of(context).Youhaventleaveanycommentsyet),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectImageForGrid(0);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
