import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../../../gen_l10n/app_localizations.dart';
import '../../../reusable_widgets/dark_mode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Rainbow extends StatefulWidget {
  const Rainbow({Key? key}) : super(key: key);

  @override
  State<Rainbow> createState() => _Rainbow();
}

class _Rainbow extends State<Rainbow> {
  bool isLiked = false; // State for the like button
  List<String> comments = [
    'Love this place!',
    'Absolutely enormous the atmosphere.',
    'Would definitely come back again.',
  ];
  // List of comments (you can initialize it with your existing comments)

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rainbow Village'),
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
                          'assets/taiwan/destinations/Rainbow Village1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: YourImageWidget(), // Uncomment and replace with your image widget
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context).Rainbow,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF306550),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).RainbowDescription,
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
                          ' 5 / 5', // Replace with your actual rating value
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
                  child: Text('Add to Favorite'),
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
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => imageDialog(
                              'Rainbow Village',
                              'assets/taiwan/destinations/Rainbow Village2.jpg',
                              context,
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/taiwan/destinations/Rainbow Village2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => imageDialog(
                              'Rainbow Village',
                              'assets/taiwan/destinations/Rainbow Village3.jpg',
                              context,
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color, replace with your image
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/taiwan/destinations/Rainbow Village3.jpg'),
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
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => imageDialog(
                              'Rainbow Village',
                              'assets/taiwan/destinations/Rainbow Village4.jpg',
                              context,
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color, replace with your image
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/taiwan/destinations/Rainbow Village4.jpg'),
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
                  title: Text('Open Hours: 24 hours'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Address: Jakarta, Indonesia'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact: -'),
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

Widget imageDialog(text, path, context) {
  return Dialog(
    // backgroundColor: Colors.transparent,
    // elevation: 0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              //   icon: Icon(Icons.close_rounded),
              //   color: Colors.redAccent,
              // ),
            ],
          ),
        ),
        Container(
          width: 220,
          height: 200,
          child: Image.asset(
            '$path',
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );}