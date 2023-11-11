import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class DestinationDesc extends StatefulWidget {
  const DestinationDesc({Key? key}) : super(key: key);

  @override
  State<DestinationDesc> createState() => _DestinationDescState();
}

class _DestinationDescState extends State<DestinationDesc> {
  bool isLiked = false; // State for the like button
  List<String> comments = [
    'Great place!',
    'Love the atmosphere.',
    'Would recommend visiting.',
  ]; // List of comments (you can initialize it with your existing comments)

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFF306550),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                      color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/destinations/indonesia-borobudur.jpg'),
                        fit: BoxFit.cover,
                      ),
                  ),
                  // child: YourImageWidget(), // Uncomment and replace with your image widget
                ),
                const SizedBox(height: 16),
                Text(
                  'Borobudur Temple',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF306550),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Description goes here. You can provide a long description or other relevant information about the destination.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                        Text(
                          'Like',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          ' 4.5 / 5', // Replace with your actual rating value
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SocialMediaButton(
                          icon: Icons.facebook,
                          onPressed: () {
                            // Add Facebook button action
                          },
                        ),
                        SizedBox(width: 8),
                        SocialMediaButton(
                          icon: FontAwesomeIcons.twitter,
                          onPressed: () {
                            // Add Twitter button action
                          },
                        ),
                        SizedBox(width: 8),
                        SocialMediaButton(
                          icon: FontAwesomeIcons.instagram,
                          onPressed: () {
                            // Add Instagram button action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Add action for the button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isDarkMode ? Colors.blueGrey : const Color(0xFF306550),
                  ),
                  child: Text('Save'),
                ),
                const SizedBox(height: 16),
                Text(
                  'Photos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Add action for tapping the first photo
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color, replace with your image
                            borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/destinations/Borobudur 1.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          // child: YourImageWidget(), // Uncomment and replace with your image widget
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Add action for tapping the second photo
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color, replace with your image
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/destinations/Borobudur 2.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // child: YourImageWidget(), // Uncomment and replace with your image widget
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Add action for tapping the third photo
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color, replace with your image
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/destinations/Borobudur 3.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // child: YourImageWidget(), // Uncomment and replace with your image widget
                        ),
                      ),
                    ),
                  ],
                ),
                // Divider(
                //   color: Colors.grey[400],
                //   thickness: 2,
                // ),
                const SizedBox(height: 16),
                Text(
                  'More Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Open Hours: 9:00 AM - 6:00 PM'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Address: No. 123, XYZ Street, Taipei, Taiwan'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact: +123 456 789'),
                ),
                // Comment Section
                const SizedBox(height: 16),
                Text(
                  'Comments',
                  style: TextStyle(
                    color: const Color(0xFF306550),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.comment),
                      title: Text(comments[index]),
                    );
                  },
                ),
                // Add a text field and button for users to add new comments
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    style: ElevatedButton.styleFrom(
                      primary: isDarkMode ? Colors.blueGrey : const Color(0xFF306550),
                    );
                    // Implement the logic to add the new comment
                    String newComment = 'New Comment'; // Replace with user input
                    setState(() {
                      comments.add(newComment);
                    });
                  },
                  child: Text('Add Comment'),
                  style: ElevatedButton.styleFrom(
                    primary: isDarkMode ? Colors.blueGrey : const Color(0xFF306550),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const SocialMediaButton({
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: const Color(0xFF306550), // Customize the color as needed
    );
  }
}
