import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/editprofile.dart';
import 'package:travel_trip_application/screens/utils/post.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import 'package:travel_trip_application/screens/personality_screen.dart';
import '../reusable_widgets/dark_mode.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:travel_trip_application/reusable_widgets//photo_utils.dart';
import 'package:path_provider/path_provider.dart';
import '../gen_l10n/app_localizations.dart';
import 'utils/post.dart';



class ProfilePage extends StatefulWidget {
  final String name ;
  final String gender ;
  final String nationality;
  final int posts = 30;
  final int followers = 1000;
  final int following = 500;
  ProfilePage({required this.name,required this.gender,required this.nationality});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}
class UserProfile {
  String name;
  String gender;
  String nationality;

  UserProfile(this.name, this.gender, this.nationality);
}

//class UserProfileProvider extends ChangeNotifier {
 // UserProfile _userProfile;

 // UserProfile get userProfile => _userProfile;

 // void updateUserProfile(String name, String gender, String nationality) {
  //  _userProfile = UserProfile(name, gender, nationality);
  //  notifyListeners();
  //}
//}
class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();
  int selectedIndex = 0;
  List<File?> gridImages = List.generate(100, (index) => null);

  late TabController _tabController;
  final parser = EmojiParser();
  final US = Emoji('flag_us', '🇺🇸');


  Future<void> _selectImageForGrid(int index) async {
    if (gridImages[0] != null) {
      // 如果第一个格子已经有图片，将图片放入第二个格子
      int newIndex = 1;

      while (gridImages[newIndex] != null) {
        newIndex++; // 寻找下一个空的格子
      }

      if (newIndex < 100) {
        index = newIndex;
      } else {
        // 如果所有格子都已被填满，可以在此处添加处理逻辑
        // 例如显示一个提示或清空第一个格子
        // 你可以根据需求进行定制
        return;
      }
    }

    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
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
              title: Text('刪除照片'),
              onTap: () {
                // 執行刪除照片的操作
                setState(() {
                  gridImages[index] = null; // 將圖片設置為 null，表示刪除
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.visibility),
              title: Text('查看照片'),
              onTap: () {
                // 執行查看照片的操作
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
                  : Text('No image available'),
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
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: SideMenu(),

      appBar:
      AppBar(
        title: Text(widget.name),
        backgroundColor: isDarkMode ? Colors.black : Color(0xFF306550),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection here
              if (value == 'option1') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalityScreen()));
              } else if (value == 'option2') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage(onProfileUpdated:(name,gender,nationality){
                    setState(() {
                    });
                    })));
                // Do something for option 2
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option1',
                child: Text('Personality Test'),
              ),
              PopupMenuItem<String>(
                value: 'option2',
                child: Text('Edit Profile'),
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
                      "https://randomuser.me/api/portraits/men/47.jpg"),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${widget.name}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gender: ${widget.gender}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.nationality + ' ' + parser.emojify('🇺🇸'),
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
              Text(AppLocalizations.of(context).posts),
              Text(AppLocalizations.of(context).ratings),
              Text(AppLocalizations.of(context).commets),
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
                              _showDeleteMenu(context, index); // 显示删除菜单
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
                ),// Reels page
                Container(
                  child: const Center(
                    child: Text("You don't have any ratings yet"),
                  ),
                ),
                // Photos of You page
                Container(
                  child: Center(
                    child: Text("You haven't leave any comments yet"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectImageForGrid(0); // 这里假设你要将图片放入第一个格子
        },
        child: Icon(Icons.add),
      ),
    );
  }

}

