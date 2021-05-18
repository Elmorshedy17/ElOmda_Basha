import 'dart:convert';

//import 'package:heed/src/models/api_models/POST/login_model.dart';
// import 'package:heed/src/models/api_models/POST/register_model.dart'
//     as registerModel;
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService _instance;
  static SharedPreferences _preferences;

  static const String APP_LANGUAGE_KEY = 'language_code';
  static const String APP_COUNTRY_CODE = 'countryCode';
  static const String HAS_CHOSEN_LANGUAGE = 'hasChosenLanguage';
  static const String SIGN_UP_KEY = 'signedUp';
  static const String LOG_IN_KEY = 'loggedIn';
  static const String NOTIFICATION_FlAG = 'notificationFlag';
  static const String SaveUser_ID = 'saveUserId';
  static const String USER_TYPE = 'userType';
  static const String USERIMAGE_PROFILE = 'userImageProfile';
  static const dynamic USERIMAGEPATH_PROFILE = 'userImagePathProfile';
  static const String USERNAME_PROFILE = 'userNameProfile';
  static const String USEREEMAIL_PROFILE = 'userEmailProfile';

  static const String USERELASTNAME_PROFILE = 'userLastName';
  static const dynamic USERPHONE_PROFILE = 'userPhoneProfile';
  static const dynamic USERPHONE_CODE_PROFILE = 'userPhoneCodeProfile';
  static const dynamic USERWHATSAPP_PROFILE = 'userWhatsAppProfile';
  static const dynamic USERWHATSAPP_CODE_PROFILE = 'userWhatsAppCodeProfile';
  static const dynamic COUNTERYID_PROFILE = 'CounteryIdProfile';
  static const dynamic CITYID_PROFILE = 'CityIdProfile';
  static const dynamic NOTIFYSEND = 'notifySend';
  static const dynamic NOTIFICATIONSCOUNT = 'NotiCount';
  static const dynamic COUNTERY_CODE = 'counteryCode';
  static const dynamic CITY_CODE = 'cityCode';





//  static const String NOTIFICATIONS_COUNT = 'notificationsCount';
  // static const String USER_AUTH = 'userAuth';
  // static const String USER_NAME = 'userName';
  // static const String USER_EMAIL = 'userEmail';
  // static const String USER_PHONE = 'userPhone';
  // static const String USER_OBJ_REGISTER = 'registerUser';
  static const String USER_OBJ = 'user';
  // static const String USER_OBJ_LOGIN = 'loginUser';
  static const String USER_PASSWORD = 'userPassword';

  static Future<PrefsService> getInstance() async {
    if (_instance == null) {
      _instance = PrefsService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic _getFromPrefs(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  // updated _saveToDisk function that handles all types
  void _saveToPrefs<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  // remove from Prefs
  void _removeFromPrefs(String key) {
    _preferences.remove(key);
  }

  // clear all Prefs
  void clearAllPrefs() {
    _preferences.clear();
  }



/////////////////////////////////////////////////////////////////////////////////
  int get NotiCount => _getFromPrefs(NOTIFICATIONSCOUNT)??0;
  set NotiCount(int value) => _saveToPrefs(NOTIFICATIONSCOUNT, value);
  removeNotiCount() => _removeFromPrefs(NOTIFICATIONSCOUNT);

////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  bool get notificationFlag => _getFromPrefs(NOTIFICATION_FlAG) ?? true;
  set notificationFlag(bool value) => _saveToPrefs(NOTIFICATION_FlAG, value);
////////////////////////////////////////////////////////////////////////////////
//   static const dynamic COUNTERY_CODE = 'counteryCode';
//   static const dynamic CITY_CODE = 'cityCode';
/////////////////////////////////////////////////////////////////////////////////
  bool get counteryCode => _getFromPrefs(COUNTERY_CODE) ?? true;
  set counteryCode(bool value) => _saveToPrefs(COUNTERY_CODE, value);
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  bool get cityCode => _getFromPrefs(CITY_CODE) ?? true;
  set cityCode(bool value) => _saveToPrefs(CITY_CODE, value);
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  String get saveUserId => _getFromPrefs(SaveUser_ID);
  set saveUserId(String value) => _saveToPrefs(SaveUser_ID, value);
   removeSaveUserId() => _removeFromPrefs(SaveUser_ID);
////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
  String get userType => _getFromPrefs(USER_TYPE);
  set userType(String value) => _saveToPrefs(USER_TYPE, value);
  removeUserType() => _removeFromPrefs(USER_TYPE);

////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////
  String get userImageProfile => _getFromPrefs(USERIMAGE_PROFILE);
  set userImageProfile(String value) => _saveToPrefs(USERIMAGE_PROFILE, value);
  removeUserImageProfile() => _removeFromPrefs(USERIMAGE_PROFILE);

  dynamic get userImagePathProfile => _getFromPrefs(USERIMAGEPATH_PROFILE);
  set userImagePathProfile(dynamic value) => _saveToPrefs(USERIMAGEPATH_PROFILE, value);
  removeUserImagePathProfile() => _removeFromPrefs(USERIMAGEPATH_PROFILE);



  String get userNameProfile => _getFromPrefs(USERNAME_PROFILE);
  set userNameProfile(String value) => _saveToPrefs(USERNAME_PROFILE, value);
  removeUserNameProfile() => _removeFromPrefs(USERNAME_PROFILE);

  String get userLastName => _getFromPrefs(USERELASTNAME_PROFILE);
  set userLastName(String value) => _saveToPrefs(USERELASTNAME_PROFILE, value);
  removeUserLastName() => _removeFromPrefs(USERELASTNAME_PROFILE);

  dynamic get userPhoneProfile => _getFromPrefs(USERPHONE_PROFILE);
  set userPhoneProfile(dynamic value) => _saveToPrefs(USERPHONE_PROFILE, value);
  removeUserPhoneProfile() => _removeFromPrefs(USERPHONE_PROFILE);

  dynamic get userPhoneCodeProfile => _getFromPrefs(USERPHONE_CODE_PROFILE);
  set userPhoneCodeProfile(dynamic value) => _saveToPrefs(USERPHONE_CODE_PROFILE, value);
  removeUserPhoneCodeProfile() => _removeFromPrefs(USERPHONE_CODE_PROFILE);

  dynamic get userWhatsAppProfile => _getFromPrefs(USERWHATSAPP_PROFILE);
  set userWhatsAppProfile(dynamic value) => _saveToPrefs(USERWHATSAPP_PROFILE, value);
  removeUserWhatsAppProfile() => _removeFromPrefs(USERWHATSAPP_PROFILE);

  dynamic get userWhatsAppCodeProfile => _getFromPrefs(USERWHATSAPP_CODE_PROFILE);
  set userWhatsAppCodeProfile(dynamic value) => _saveToPrefs(USERWHATSAPP_CODE_PROFILE, value);
  removeUserWhatsAppCodeProfile() => _removeFromPrefs(USERWHATSAPP_CODE_PROFILE);

  dynamic get CounteryIdProfile => _getFromPrefs(COUNTERYID_PROFILE);
  set CounteryIdProfile(dynamic value) => _saveToPrefs(COUNTERYID_PROFILE, value);
  removeCounteryIdProfile() => _removeFromPrefs(COUNTERYID_PROFILE);

  dynamic get CityIdProfile => _getFromPrefs(CITYID_PROFILE);
  set CityIdProfile(dynamic value) => _saveToPrefs(CITYID_PROFILE, value);
  removeCityIdProfile() => _removeFromPrefs(CITYID_PROFILE);


  dynamic get notifySend => _getFromPrefs(NOTIFYSEND) ?? 1;
  set notifySend(dynamic value) => _saveToPrefs(NOTIFYSEND, value);
  removeNOTIFYSEND() => _removeFromPrefs(NOTIFYSEND);


  String get userEmailProfile => _getFromPrefs(USEREEMAIL_PROFILE);
  set userEmailProfile(String value) => _saveToPrefs(USEREEMAIL_PROFILE, value);
  removeUserEmailProfile() => _removeFromPrefs(USEREEMAIL_PROFILE);



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  bool get hasSignedUp => _getFromPrefs(SIGN_UP_KEY) ?? false;
  set hasSignedUp(bool value) => _saveToPrefs(SIGN_UP_KEY, value);
////////////////////////////////////////////////////////////////////////////////
  bool get hasLoggedIn => _getFromPrefs(LOG_IN_KEY) ?? false;
  set hasLoggedIn(bool value) => _saveToPrefs(LOG_IN_KEY, value);
////////////////////////////////////////////////////////////////////////////////
  // getter for notificationsCount
//  int get notificationsCount => _getFromPrefs(NOTIFICATIONS_COUNT) ?? 0;
//  // setter for notificationsCount
//  set notificationsCount(int value) => _saveToPrefs(NOTIFICATIONS_COUNT, value);
//  // remove notificationsCount
//  removeNotificationsCount() => _removeFromPrefs(NOTIFICATIONS_COUNT);
////////////////////////////////////////////////////////////////////////////////
  // getter for App language.
  String get appLanguage => _getFromPrefs(APP_LANGUAGE_KEY);
  // setter for App language.
  set appLanguage(String value) => _saveToPrefs(APP_LANGUAGE_KEY, value);
// ////////////////////////////////////////////////////////////////////////////////
  // getter for UserPassword.
  String get userPassword => _getFromPrefs(USER_PASSWORD);
  // setter for UserPassword.
  set userPassword(String value) => _saveToPrefs(USER_PASSWORD, value);
////////////////////////////////////////////////////////////////////////////////
  // getter for country code.
  String get countryCode => _getFromPrefs(APP_COUNTRY_CODE);
  // setter for country code.
  set countryCode(String value) => _saveToPrefs(APP_COUNTRY_CODE, value);
////////////////////////////////////////////////////////////////////////////////
  bool get hasChosenLanguage => _getFromPrefs(HAS_CHOSEN_LANGUAGE) ?? false;
  set hasChosenLanguage(bool value) => _saveToPrefs(HAS_CHOSEN_LANGUAGE, value);
////////////////////////////////////////////////////////////////////////////////
//  // getter for USER_OBJECT from RegisterModel.
//  User get userObj {
//    var userJson = _getFromPrefs(USER_OBJ);
//    if (userJson == null) {
//      return null;
//    }
//
//    return User.fromJson(json.decode(userJson));
//  }
//
//  // setter for USER_OBJECT.
//  set userObj(User userToSave) {
//    _saveToPrefs(USER_OBJ, json.encode(userToSave.toJson()));
//  }
//
//  // Remove UserObj
//  removeUserObj() => _removeFromPrefs(USER_OBJ);
////////////////////////////////////////////////////////////////////////////////
//   // getter for UserAuth.
//   String get userAuth => _getFromPrefs(USER_AUTH);
//   // setter for UserAuth.
//   set userAuth(String value) => _saveToPrefs(USER_AUTH, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // getter for USER_NAME.
//   String get userName => _getFromPrefs(USER_NAME);
//   // setter for USER_NAME.
//   set userName(String value) => _saveToPrefs(USER_NAME, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // getter for USER_EMAIL.
//   String get userEmail => _getFromPrefs(USER_EMAIL);
//   // setter for USER_EMAIL.
//   set userEmail(String value) => _saveToPrefs(USER_EMAIL, value);
////////////////////////////////////////////////////////////////////////////////

  // // getter for USER_PHONE.
  // String get userPhone => _getFromPrefs(USER_PHONE);
  // // setter for USER_PHONE.
  // set userPhone(String value) => _saveToPrefs(USER_PHONE, value);
////////////////////////////////////////////////////////////////////////////////

  // getter for USER_OBJECT from RegisterModel.
  // registerModel.User get registerUser {
  //   var userJson = _getFromPrefs(USER_OBJ_REGISTER);
  //   if (userJson == null) {
  //     return null;
  //   }

  //   return registerModel.User.fromJson(json.decode(userJson));
  // }

  // // setter for USER_OBJECT.
  // set registerUser(registerModel.User userToSave) {
  //   _saveToPrefs(USER_OBJ_REGISTER, json.encode(userToSave.toJson()));
  // }

  // removeRegisterUser() => _removeFromPrefs(USER_OBJ_REGISTER);
////////////////////////////////////////////////////////////////////////////////

}
