import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';

class ProfilePage extends StatefulWidget {
  final String name = 'John Doe';
  final String username = '@johndoe';
  final int posts = 9;
  final int followers = 1000;
  final int following = 500;
  final String nationality = 'American';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final parser = EmojiParser();
  final US = Emoji('flag_us', '🇺🇸');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Column(
        children: [
          Container(
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
                        widget.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
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
                                'Posts',
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
                                'Followers',
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
                                'Following',
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
              Tab(text: 'Posts'),
              Tab(text: 'Ratings'),
              Tab(text: 'Comments'),
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
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    padding: EdgeInsets.all(4.0),
                    children: List.generate(
                      9,
                      (index) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://picsum.photos/200?random=$index'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Reels page
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
    );
  }
}
