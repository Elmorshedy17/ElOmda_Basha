import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:momentoo/features/about_us/about_screen.dart';
import 'package:momentoo/features/address_book/addressBook_screen.dart';
import 'package:momentoo/features/ads/ads_screen.dart';
import 'package:momentoo/features/all_trending/allTrending_screen.dart';
import 'package:momentoo/features/change_email/changeEmail_screen.dart';
import 'package:momentoo/features/change_password/changePassword_screen.dart';
import 'package:momentoo/features/edit_profile/editProfile_screen.dart';
import 'package:momentoo/features/favorites/favorites_screen.dart';
import 'package:momentoo/features/forget_password/forgetPassword_screen.dart';
import 'package:momentoo/features/help_support/helpSupport_screen.dart';
import 'package:momentoo/features/home/home_screen.dart';
import 'package:momentoo/features/invoice/invoice_screen.dart';
import 'package:momentoo/features/join_us/joinUsFirst_screen.dart';
import 'package:momentoo/features/join_us/joinUsSecond_screen.dart';
import 'package:momentoo/features/language/lang_screen.dart';
import 'package:momentoo/features/my_orders/myOrders_screen.dart';
import 'package:momentoo/features/near_by/currentMap_screen.dart';
import 'package:momentoo/features/near_by/getLocation_screen.dart';
import 'package:momentoo/features/near_by/manuallyMap_screen.dart';
import 'package:momentoo/features/near_by/nearBy_screen.dart';
import 'package:momentoo/features/new_address/newAddress_screen.dart';
import 'package:momentoo/features/notifications/notifications_screen.dart';
import 'package:momentoo/features/order_details/orderDetails_screen.dart';
import 'package:momentoo/features/privacy_policy/privacy_screen.dart';
import 'package:momentoo/features/profile/profile_screen.dart';
import 'package:momentoo/features/search/filter_screen.dart';
import 'package:momentoo/features/search/searchResult_screen.dart';
//import 'package:momentoo/features/search/search_screen.dart';
import 'package:momentoo/features/settings/settings_screen.dart';
import 'package:momentoo/features/shopping_cart/cart_screen.dart';
import 'package:momentoo/features/sign_in/signIn_screen.dart';
import 'package:momentoo/features/sign_up/signUp_screen.dart';
import 'package:momentoo/features/storeDetails/storeDetails_screen.dart';
import 'package:momentoo/features/terms_conditions/termsConditions_screen.dart';
import 'package:momentoo/features/trending_products/trendingProducts_screen.dart';
import 'package:momentoo/features/trending_stores/trendingStores_screen.dart';
import 'package:momentoo/features/welcome/welcome_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/connection_service.dart';
import 'package:momentoo/shared/services/fcm/pushNotification_service.dart';
import 'package:momentoo/shared/services/localizations/app_language.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:provider/provider.dart';

import 'features/edit_address/editAddress_screen.dart';
import 'features/product_details/productDetails_screen.dart';

Future<void> main() async {
  /*Set `enableInDevMode` to true to see reports while in debug mode
This is only to be used for confirming that reports are being submitted as expected.
It is not intended to be used for everyday development.*/
  Crashlytics.instance.enableInDevMode = true;
// Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await setupLocator().then((_) async {
      AppLanguage appLanguage = locator<AppLanguage>();
      await appLanguage.fetchLocale();
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      runApp(MomentooApp(
        appLanguage: appLanguage,
      ));
    }, onError: Crashlytics.instance.recordError);
  } catch (error) {
    print(error);
  }
}

class MomentooApp extends StatefulWidget {
  final AppLanguage appLanguage;

  const MomentooApp({@required this.appLanguage});

  @override
  _MomentooAppState createState() => _MomentooAppState();
}

class _MomentooAppState extends State<MomentooApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();
    locator<PushNotificationService>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => ConnectionCheckerService().getConnectionStatus$,
      child: ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
              title: 'Momento App',
              debugShowCheckedModeBanner: false,
              navigatorObservers: <NavigatorObserver>[observer],
              locale: model.appLocal,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ar', ''),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: ThemeData(
                primarySwatch: Colors.teal,
              ),
              home: AddressBookScreen(),
//              home: _getStartupScreen(),
              routes: {
                '/langScreen': (_) => LangScreen(),
                '/adsScreen': (_) => AdsScreen(),
                '/welcomeScreen': (_) => WelcomeScreen(),
                '/signInScreen': (_) => SignInScreen(),
                '/signUpScreen': (_) => SignUpScreen(),
                '/forgetPasswordScreen': (_) => ForgetPasswordScreen(),
                '/homeScreen': (_) => HomeScreen(),
                '/favoritesScreen': (_) => FavoritesScreen(),
                '/allTrendingScreen': (_) => AllTrendingScreen(),
                '/myOrdersScreen': (_) => MyOrdersScreen(),
                '/helpSupportScreen': (_) => HelpSupportScreen(),
                '/aboutScreen': (_) => AboutScreen(),
                '/addressBookScreen': (_) => AddressBookScreen(),
                '/notificationsScreen': (_) => NotificationsScreen(),
                '/privacyScreen': (_) => PrivacyScreen(),
                '/profileScreen': (_) => ProfileScreen(),
                '/termsConditionsScreen': (_) => TermsConditionsScreen(),
                '/nearByScreen': (_) => NearByScreen(),
                '/cartScreen': (_) => CartScreen(),
                '/settingsScreen': (_) => SettingsScreen(),
//                '/editProfileScreen': (_) => EditProfileScreen(),
//                '/newAddressScreen': (_) => NewAddressScreen(),
//                '/editAddressScreen': (_) => EditAddressScreen(),
                '/getLocationScreen': (_) => GetLocationScreen(),
                '/currentMapScreen': (_) => CurrentMapScreen(),
                '/manuallyMapScreen': (_) => ManuallyMapScreen(),
                // '/searchScreen': (_) => SearchScreen(),
                '/searchResultScreen': (_) => SearchResultScreen(),
                '/filterScreen': (_) => FilterScreen(),
                '/trendingStoresScreen': (_) => TrendingStoresScreen(),
                '/changePasswordScreen': (_) => ChangePasswordScreen(),
                '/invoiceScreen': (_) => InvoiceScreen(),
                '/orderDetailsScreen': (_) => OrderDetailsScreen(),
                '/joinUsFirstScreen': (_) => JoinUsFirstScreen(),
                '/joinUsSecondScreen': (_) => JoinUsSecondScreen(),
                '/StoreDetailsScreen': (_) => StoreDetailsScreen(),
                '/productDetailsScreen': (_) => ProductDetailsScreen(),
                '/ChangeEmailScreen': (_) => ChangeEmailScreen(),
                '/trendingProductsScreen': (_) => TrendingProductsScreen(),
              },
            );
          },
        ),
      ),
    );
  }

  Widget _getStartupScreen() {
    var prefsService = locator<PrefsService>();
    if (!prefsService.hasChosenLanguage) {
      return LangScreen();
    }
    return AdsScreen();
  }
}
