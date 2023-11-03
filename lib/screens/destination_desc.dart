import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';
import 'package:travel_trip_application/mysql.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';

import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/side_menu.dart';

class DestinationDesc extends StatefulWidget {
  const DestinationDesc({Key? key}) : super(key: key);

  @override
  State<DestinationDesc> createState() => _State();
}

class _State extends State<DestinationDesc> {
  var db = Mysql(); // Initialize your MySQL connection
  var country_name = '123';

  @override
  void initState() {
    super.initState();
  }

  void _getName () {
    db.getConnection().then((conn) {
      String sql = 'SELECT country_name FROM traveltrip.country_tab WHERE country_id = 1;';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            country_name = '456';
          });
        }
      });
      conn.close();
    });
  }


  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFF306550),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'country_name:',
            ),
            Text(
              '$country_name',
              // style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getName,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
