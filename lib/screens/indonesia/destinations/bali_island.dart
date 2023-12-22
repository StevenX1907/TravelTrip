import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../../../gen_l10n/app_localizations.dart';
import '../../../reusable_widgets/dark_mode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_trip_application/screens/favorite_destination.dart';
import 'package:url_launcher/url_launcher.dart';

class baliIsland extends StatefulWidget {
  const baliIsland({Key? key}) : super(key: key);

  @override
  State<baliIsland> createState() => _baliIsland();
}

class _baliIsland extends State<baliIsland> {
  late List<String> comments;
  TextEditingController commentController = TextEditingController();
  late List<FavoriteItem> favorites;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize comments list with translation keys

    comments = [
      AppLocalizations.of(context).greatPlace,
      AppLocalizations.of(context).loveTheAtmosphere,
      AppLocalizations.of(context).recommendVisiting,
    ];
    favorites = [];
    loadComments();
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void addToFavorites() {
    FavoriteItem newItem = FavoriteItem(
      title: AppLocalizations.of(context).bali,
      description: AppLocalizations.of(context).indonesia,
      imageAsset: 'assets/indonesia/destinations/Bali_1.jpeg',
    );

    setState(() {
      favorites.add(newItem);
    });

    Provider.of<FavoritesProvider>(context, listen: false).addToFavorites(newItem);
    // Optionally, you can save the favorites list to persistent storage (e.g., SharedPreferences).
    // Save logic goes here...
  }
  // List of comments (you can initialize it with your existing comments)

  Future<void> loadComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      comments = prefs.getStringList('comments') ?? [];
      print('Comments loaded: $comments');
    });
  }

  Future<void> saveComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('comments', comments);
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Comment'),
          content: Text('Are you sure you want to delete this comment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  comments.removeAt(index);
                  saveComments(); // Save updated comments to SharedPreferences
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    bool isLiked = Provider.of<LikeProvider>(context).isLiked;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).bali),
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
                          'assets/indonesia/destinations/Bali_1.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: YourImageWidget(), // Uncomment and replace with your image widget
                ),
                const SizedBox(height: 16),
                Text(
                    AppLocalizations.of(context).bali,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF306550),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).baliDescription,
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
                            Provider.of<LikeProvider>(context, listen: false).toggleLike();
                          },
                        ),
                        Text(
                          AppLocalizations.of(context).like,
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
                            launchUrl('https://www.facebook.com/profile.php?id=61554327453343&mibextid=LQQJ4d');
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
                            launchUrl('https://www.instagram.com/im_traveltrip/');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    addToFavorites();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isDarkMode ? Colors.blueGrey : const Color(0xFF306550),
                  ),
                  child: Text(AppLocalizations.of(context).AddtoFavorite),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context).Photos,
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
                              'Bali Beach',
                              'assets/indonesia/destinations/Bali_2.jpg',
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
                              image: AssetImage('assets/indonesia/destinations/Bali_2.jpg'),
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
                              'Kuta Beach',
                              'assets/indonesia/destinations/Bali_3.jpeg',
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
                                  'assets/indonesia/destinations/Bali_3.jpeg'),
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
                              'Bali\'s Temple',
                              'assets/indonesia/destinations/Bali_4.jpeg',
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
                                  'assets/indonesia/destinations/Bali_4.jpeg'),
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
                  AppLocalizations.of(context).MoreInformation,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(AppLocalizations.of(context).open),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(AppLocalizations.of(context).ads),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(AppLocalizations.of(context).DanangContact),
                ),
                // Comment Section
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context).Comments,
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
                    return GestureDetector(
                      onLongPress: () {
                        _showDeleteConfirmationDialog(index);
                      },
                      child: ListTile(
                        leading: Icon(Icons.comment),
                        title: Text(comments[index]),
                      ),
                    );
                  },
                ),
                // Add a text field and button for users to add new comments
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).AddtoComment,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    style: ElevatedButton.styleFrom(
                      primary: isDarkMode ? Colors.blueGrey : const Color(0xFF306550),
                    );
                    // Implement the logic to add the new comment
                    String newComment = commentController.text; // Replace with user input
                    setState(() {
                      comments.add(newComment);
                    });
                    saveComments();
                  },
                  child: Text(AppLocalizations.of(context).AddComment),
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

class LikeProvider extends ChangeNotifier {
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void toggleLike() {
    _isLiked = !_isLiked;
    notifyListeners();
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
  );
}