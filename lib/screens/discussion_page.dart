import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../reusable_widgets/dark_mode.dart';
import 'package:image_picker/image_picker.dart';


class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key? key}) : super(key: key);

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    Color appBarColor = isDarkMode ? Colors.black : const Color(0xFF306550);

    return Scaffold(
      drawer: const SideMenu(),
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/46.jpg",
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      'alphadelta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '3 m',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.more_horiz),
                  ],
                ),
                subtitle: Text(
                  'test app',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 70,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/destinations/indonesia-borobudur.jpg'),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Icon(Icons.chat_bubble_outline),
                          SizedBox(width: 10),
                          Icon(Icons.cached),
                          SizedBox(width: 10),
                          Icon(Icons.send),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            '190 replies. 29 likes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            SliverToBoxAdapter(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/46.jpg",
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      'jennifer11',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '3 m',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.more_horiz),
                  ],
                ),
                subtitle: Text(
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 70,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Icon(Icons.chat_bubble_outline),
                          SizedBox(width: 10),
                          Icon(Icons.cached),
                          SizedBox(width: 10),
                          Icon(Icons.send),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            '10 replies. 2 likes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            SliverToBoxAdapter(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/6.jpg",
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      'wangzixuan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '3 m',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.more_horiz),
                  ],
                ),
                subtitle: Text(
                  'hi',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 70,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/destinations/kenting_national_park.jpg'),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Icon(Icons.chat_bubble_outline),
                          SizedBox(width: 10),
                          Icon(Icons.cached),
                          SizedBox(width: 10),
                          Icon(Icons.send),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            '190 replies. 29 likes.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          onPressed: () {
            _showPostDialog(context);
          },
          backgroundColor: Color(0xFF306550),
          elevation: 8,
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),

    );
  }

  void _showPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create a New Post"),
          content: Container(
            height: 350.0,
            width: 600.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add border decoration
            ),
            child: TextField(
              controller: _postController,
              maxLines: 5,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12.0), // Add padding inside the text field
                hintText: "What's on your mind?",
                border: InputBorder.none, // Remove the default border
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                print('Icon tapped!');
              },
              icon: Icon(Icons.image_outlined), // Replace with your desired icon
            ),
            ElevatedButton(
              onPressed: () {
                String postText = _postController.text;
                if (postText.isNotEmpty) {
                  // You can save the post to your data source or perform other actions
                  // For now, print the post text
                  print("New Post: $postText");
                }
                _postController.clear();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Post"),
            ),
            ElevatedButton(
              onPressed: () {
                _postController.clear();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
