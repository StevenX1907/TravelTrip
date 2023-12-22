import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../../../gen_l10n/app_localizations.dart';
import '../reusable_widgets/dark_mode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class FavoriteItem {
  final String title;
  final String description; // You can use this for a position or any other relevant information
  final String imageAsset; // Image asset path

  FavoriteItem({required this.title, required this.description, required this.imageAsset});
}

class FavoritesProvider extends ChangeNotifier {
  List<FavoriteItem> favorites = [];

  void addToFavorites(FavoriteItem newItem) {
    favorites.add(newItem);
    notifyListeners();
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritesPage();
}
class _FavoritesPage extends State<FavoritePage> {

  List<FavoriteItem> favorites = [
    FavoriteItem(
      title: 'Favorite Item 1',
      description: 'Description for Item 1',
      imageAsset: 'assets/indonesia/destinations/Kota Tua 1.jpeg',
    ),
    FavoriteItem(
      title: 'Favorite Item 2',
      description: 'Description for Item 2',
      imageAsset: '/Users/alexandersteven/TravelTrip/assets/indonesia/destinations/Bali_1.jpeg',
    ),
    // Add more favorite items as needed
  ];
  @override
  void initState() {
    super.initState();
    // Initialize the favorites list with the new favorites
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: Text('Favorite Destination'),
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
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return buildFavoriteCard(favorites[index]);
          },
        ),
      ),
    );
  }

  Widget buildFavoriteCard(FavoriteItem favorite) {
    return Card(
      // Customize the card appearance as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(favorite.imageAsset),
            radius: 50,
          ),
          const SizedBox(height: 10),
          Text(
            favorite.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            favorite.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


