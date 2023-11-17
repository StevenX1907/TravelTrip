
import 'package:firebase_core/firebase_core.dart';
import 'package:mysql1/mysql1.dart';
import 'package:travel_trip_application/screens/utils/VerifyEmailScreen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/screens/signin_screen.dart';
import 'package:travel_trip_application/reusable_widgets/dark_mode.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final conn = await MySqlConnection.connect(
  //   ConnectionSettings(
  //     host: 'localhost',
  //     port: 3306,
  //     user: 'root',
  //     password: '12345678',
  //     db: 'traveltrip',
  //   ),
  // );
    //连接成功，可以进行相应的操作

  runApp(
    MaterialApp( // Wrap your app with MaterialApp
      home: ChangeNotifierProvider<DarkModeExample>(
        create: (context) => DarkModeExample(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _appLocale;

  @override
  void initState() {
    super.initState();
    _appLocale = Locale('en'); // Initialize with a default locale
  }

  void setLocale(Locale newLocale) {
    setState(() {
      _appLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<DarkModeExample>().isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: _appLocale, // Use the _appLocale to set the locale
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('vi'),
        Locale('ms'),
        Locale('id')
      ],

      home: const Scaffold(
        body: SignInScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
