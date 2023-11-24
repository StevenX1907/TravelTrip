import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:travel_trip_application/screens/indonesia/destinations/kota_tua.dart';
import 'package:travel_trip_application/screens/indonesia/restaurants/Kudeta.dart';
import 'package:travel_trip_application/screens/taiwan/hotels/grandTaipei.dart';
import 'package:travel_trip_application/screens/vietnam/destinations/danang.dart';
import 'package:travel_trip_application/screens/vietnam/restaurants/terracoSkyBar.dart';

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('ms'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?  '**
  String get haveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @logInCaps.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get logInCaps;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @indonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get indonesian;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @malay.
  ///
  /// In en, this message translates to:
  /// **'Malay'**
  String get malay;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @createItinerary.
  ///
  /// In en, this message translates to:
  /// **'Create Itinerary'**
  String get createItinerary;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;
  String get posts;
  String get ratings;
  String get commets;
  String get followers;
  String get following;
  String get AddtoFavorite;
  String get Photos;
  String get MoreInformation;
  String get Comments;
  String get AddtoComment;
  String get AddComment;
  String get greatPlace;
  String get loveTheAtmosphere;
  String get recommendVisiting;
  String get vietnam;
  String get currentTemperature;
  String get moreDetail;
  String get exchangeRate;
  String get destinations;
  String get restaurants;
  String get hotels;
  String get img;
  String get like;
  //indonesia
  String get BorobudurTemple;
  String get borobudurTempleDescription;
  String get indonesia;
  String get baliIsland;
  String get jakartaOldTown;
  String get fourSeasons;
  String get gaiaHotel;
  String get kempinski;
  String get bandarDjakarta;
  String get blueTerrace;
  String get kudeta;

  //taiwan
  String get taiwan;

  //vietnam
  String get DanangScreen;
  String get DanangDescription;
  String get DanangOpenHours;
  String get DanangAddress;
  String get DanangContact;

  String get haLongBay;
  String get haLongBayDescription;
  String get haLongBayAddress;
  String get haiPhong;
  String get haiphongDescription;
  String get haiPhongAddress;
  String get edenHotels;
  String get edenDescription;
  String get metooHomestay;
  String get metooDescription;
  String get MetooAddress;
  String get raonHotels;
  String get raonDescription;
  String get eraRes;
  String get eraDescription;
  String get terracoSkyBar;
  String get terracoSkyBarDescription;
  String get caugoRes;
  String get caugoResDescription;

  //malaysia
  String get malaysia;
  //taiwan
  String get kenting;
  String get kentingDescription;
  String get kinmen;
  String get kinmenDescription;
  String get wulai;
  String get wulaiDescription;
  String get grandTaipei;
  String get grandTaipeiDescription;
  String get workinn;
  String get workinnDescription;
  String get hanns;
  String get hannsDescription;
  String get hannsContact;
  String get hannsAddress;
  String get mosun;
  String get mosunDescription;
  String get shabu;
  String get shabuDescription;
  String get matsu;
  String get matsuDescription;
  String get matsuContact;
  String get matsuAddress;
  String get deletephoto;
  String get checkphoto;
  String get Noimageavailable;
  String get PersonalityTest;
  String get EditProfile;
  String get Youdonthaveanyratingsyet;
  String get Youhaventleaveanycommentsyet;
  String get N1;
  String get N2;
  String get N3;
  String get N4;
  String get N5;
  String get A1;
  String get A2;
  String get A3;
  String get A4;
  String get A5;
  String get A6;
  String get A7;
  String get A8;
  String get A9;
  String get itenary;
  String get Selectacountry;

  String get MountKinabaluScreen;
  String get MountKinabaluDescription;
  String get MountKinabaluAddress;
  String get MantananiScreen;
  String get MantananiDescription;
  String get MantananiAddress;
  String get LangkawiScreen;
  String get LangkawiDescription;
  String get LangkawiAddress;
  String get MovHotels;
  String get MovHotelsDescription;
  String get SunwayPutraHotel;
  String get SunwayPutraHotelDescription;
  String get PacificSuteraHotel;
  String get PacificSuteraHotelDescription;
  String get EnakKL;
  String get EnakKLDescription;
  String get RestoranSamy;
  String get RestoranSamyDescription;
  String get LeQueRestaurant;
  String get LeQueRestaurantDescription;
  String get amount;
  String get amountDes;
  String get exchangerate;
  String get from;
  String get to;
  String get tranfer;
  String get usd;
  String get vnd;
  String get twd;
  String get idr;
  String get myr;
  String get bali;
  String get baliDescription;
  String get kotaTua;
  String get kotaTuaDescription;
  String get open;
  String get ads;
  String get kotaads;
  String get four;
  String get fourDescription;
  String get gaia;
  String get gaiaDescription;
  String get kempin;
  String get kempinDescription;
  String get bandar;
  String get bandarDescription;
  String get blue;
  String get blueDesription;
  String get kudeta1;
  String get kudeta1Description;
  String get kudeta1ads;
  String get kudeta1open;
  String get kudetaContact;
  String get usa;
  String get male;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id', 'ms', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
    case 'ms': return AppLocalizationsMs();
    case 'vi': return AppLocalizationsVi();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
