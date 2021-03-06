import 'package:flutter/material.dart';
//import 'package:heed/locator.dart';
//import 'package:heed/src/services/prefs_Service.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = locator<PrefsService>();
    if (prefs.appLanguage == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.appLanguage);
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = locator<PrefsService>();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      prefs.appLanguage = 'ar';
      prefs.countryCode = '';
    } else {
      _appLocale = Locale("en");
      prefs.appLanguage = 'en';
      prefs.countryCode = 'US';
    }
    notifyListeners();
  }
}



//import 'package:flutter/material.dart';
//
//class AppLanguage extends ChangeNotifier {
//  Locale _appLocale = Locale('en');
//
//  Locale get appLocal => _appLocale ?? Locale("en");
//  fetchLocale() async {
//
//    return Null;
//  }
//
//  void changeLanguage(Locale type) async {
//    if (_appLocale == type) {
//      return;
//    }
//    if (type == Locale("ar")) {
//      _appLocale = Locale("ar");
//    } else {
//      _appLocale = Locale("en");
//    }
//    notifyListeners();
//  }
//}
