import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medicine/localizations/app_language.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/views/screens/after_order.dart';
import 'package:medicine/src/views/screens/change_password.dart';
import 'package:medicine/src/views/screens/contact_admin.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/screens/first_lang_screen.dart';
import 'package:medicine/src/views/screens/follow_order.dart';
import 'package:medicine/src/views/screens/history.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/src/views/screens/money_transform.dart';
import 'package:medicine/src/views/screens/my_account.dart';
import 'package:medicine/src/views/screens/my_orders.dart';
import 'package:medicine/src/views/screens/new_order.dart';
import 'package:medicine/src/views/screens/notifications.dart';
import 'package:medicine/src/views/screens/order_details.dart';
import 'package:medicine/src/views/screens/pre_reg.dart';
import 'package:medicine/src/views/screens/present_recived.dart';
import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/src/views/screens/register.dart';
import 'package:medicine/src/views/screens/single_product.dart';
import 'package:medicine/src/views/screens/verificationCode.dart';
import 'package:medicine/src/views/screens/wallet.dart';
import 'package:medicine/src/views/widgets/loading_indicator.dart';
import 'package:medicine/theme_setting.dart';
import 'package:provider/provider.dart';

//import 'localizations/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await setupLocator();
    AppLanguage appLanguage = locator<AppLanguage>();
    await appLanguage.fetchLocale();
    runApp(MyApp(appLanguage: appLanguage));
  } catch (error) {
    print('Locator setup has failed');
  }
}

//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  // setup locator
//  setupLocator();
//
//  runApp(MyApp());
//}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  static var MainSavedPage = locator<PrefsService>().userType == "delegate"?DeliveyHomePage(locator<PrefsService>().saveUserId):HomePage(locator<PrefsService>().saveUserId);
  var mainPago = locator<PrefsService>().saveUserId == null ?FirstLangScreen():MainSavedPage;

//  var mainPage = PreRegistration();
MyApp({this.appLanguage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
            theme: ThemeData(

//        primarySwatch: const Color(0xFF166EDC),
//        accentColor: accentColor,
        primaryColor: Color(0xFF166EDC),
        accentColor: Color(0xFFFF6768),
        //canvasColor: Colors.transparent,
        fontFamily: 'Bahij',
      ),

          debugShowCheckedModeBanner: false,
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
          builder: (context, widget) {
            return Stack(
              children: [
                widget,
                StreamBuilder(
                    stream: locator<IsLoadingManager>().isLoading,
                    builder: (context, snapshot) {
                      return loadingIndicator(snapshot.data, context);
                    }
                ),
              ],
            );
          },
          home: (locator<PrefsService>().userType == null || locator<PrefsService>().userType == "")? FirstLangScreen():mainPago,
//          locator<PrefsService>().saveUserId == null ? PreRegistration():,
        );
      }),
    );

//      MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//
////        primarySwatch: const Color(0xFF166EDC),
////        accentColor: accentColor,
//        primaryColor: Color(0xFF166EDC),
//        accentColor: Color(0xFFFF6768),
//        //canvasColor: Colors.transparent,
//        fontFamily: 'Bahij',
//      ),
//      supportedLocales: [
//        Locale('en', 'US'),
//        Locale('ar', ''),
//      ],
//      localizationsDelegates: [
//        AppLocalizations.delegate,
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//      ],
//      home:
//      //MyOrdersScreen(),
//      PreRegistration(),
//    );
  }
}

