import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import '../gen_l10n/app_localizations.dart';
import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/side_menu.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Notifications'),
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
        child: NotificationList(),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<NotificationItem> notificationItems = [
      NotificationItem(
        username: 'john_doe',
        action: 'liked your post',
        profileImageUrl: "https://randomuser.me/api/portraits/men/47.jpg",
      ),
      NotificationItem(
        username: 'sarahsmith123',
        action: 'commented on your photo',
        profileImageUrl: "https://randomuser.me/api/portraits/women/23.jpg",
      ),
      NotificationItem(
        username: 'alicejohnson',
        action: 'started following you',
        profileImageUrl: "https://randomuser.me/api/portraits/women/32.jpg",
      ),
      NotificationItem(
        username: 'kien001',
        action: 'liked your post',
        profileImageUrl: "https://randomuser.me/api/portraits/men/90.jpg",
      ),
      // Add more notification items here with different profile image URLs
    ];

    return ListView.builder(
      itemCount: notificationItems.length,
      itemBuilder: (context, index) {
        final item = notificationItems[index];
        return NotificationCard(item: item);
      },
    );
  }
}

class NotificationItem {
  final String username;
  final String action;
  final String profileImageUrl;

  NotificationItem({
  required this.username,
  required this.action,
  required this.profileImageUrl,
});
}

class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeExample>(
      builder: (context, darkModeProvider, child) {
        bool isDarkMode = darkModeProvider.isDarkMode;
        Color buttonColor = isDarkMode ? Colors.black : const Color(0xFF306550);

        return Card(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: InkWell(
            onTap: () {
              // Add action when the notification is tapped, e.g., open the related post.
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(item.profileImageUrl),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.username}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${item.action}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add action when the notification is tapped, e.g., open the related post.
                    },
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor, // Set the button color here
                    ),
                    child: Text('View'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

