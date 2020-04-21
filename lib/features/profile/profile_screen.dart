import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentoo/features/edit_profile/editProfile_screen.dart';
import 'package:momentoo/features/language/lang_screen.dart';
import 'package:momentoo/features/profile/_manager.dart';
import 'package:momentoo/features/profile/_model.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomObserver(
              stream: locator<ProfileManager>().getData(),
              onSuccess: (_, ProfileModel model) {
//                var content = model.data;
//                print("content${content.Data}");
              return Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
//                          AppLocalizations.of(context).translate('profile_str'),
                          model.message
                         , style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: locator<PrefsService>().appLanguage == 'en'
                                ? 'en'
                                : 'ar',
                          ),
                        ),
                        ButtonTheme(
                          height: 25,
                          child: RaisedButton(
                              color: Colors.teal.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.teal.shade900),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('editProfile_str'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage == 'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ),
                              onPressed: () {
//                                Navigator.of(context).pushNamed('/editProfileScreen');
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext
                                        context) =>
                                            EditProfileScreen(
                                                model.data.user)));
                              }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Card(
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${model.data.user.firstName} ${model.data.user.lastName}",
                                  style: TextStyle(
                                    color: Colors.teal.shade900,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage == 'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                                Text(
                                  model.data.user.email,
                                  style: TextStyle(
                                    fontFamily:
                                        locator<PrefsService>().appLanguage == 'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
//                      height: 600,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .translate('name_str'),
                                    style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${model.data.user.firstName} ${model.data.user.middleName} ${model.data.user.lastName}",
                                    style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                ),
                                Divider(
                                  endIndent: 15,
                                  indent: 15,
                                  height: 5,
                                  color: Colors.black12,
                                ),
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .translate('address_str'),
                                    style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                  subtitle: Text(
                                    model.data.user.address,
                                    style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                ),
                                Divider(
                                  endIndent: 15,
                                  indent: 15,
                                  height: 5,
                                  color: Colors.black12,
                                ),
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .translate('phoneNumber_str'),
                                    style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                  subtitle: Text(
                                    model.data.user.phone,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                ),
                                Divider(
                                  endIndent: 15,
                                  indent: 15,
                                  height: 5,
                                  color: Colors.black12,
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/addressBookScreen');
                                  },
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .translate('addressBook_str'),
                                    style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
//                          Divider(
//                            endIndent: 15,
//                            indent: 15,
//                            height: 5,
//                            color: Colors.black12,
//                          ),
//                          ListTile(
//                            onTap: () {
//                              Navigator.of(context)
//                                  .pushNamed('/termsConditionsScreen');
//                            },
//                            leading: Icon(
//                              Icons.error,
//                              color: Colors.greenAccent,
//                            ),
//                            title: Text(
//                              AppLocalizations.of(context)
//                                  .translate('termsOfUse_str'),
//                              style: TextStyle(
//                                fontFamily:
//                                    locator<PrefsService>().appLanguage == 'en'
//                                        ? 'en'
//                                        : 'ar',
//                              ),
//                            ),
//                            trailing: Icon(Icons.arrow_forward_ios),
//                          ),
//                          Divider(
//                            endIndent: 15,
//                            indent: 15,
//                            height: 5,
//                            color: Colors.black12,
//                          ),
//                          ListTile(
//                            onTap: () {
//                              Navigator.of(context).pushNamed('/privacyScreen');
//                            },
//                            leading: Icon(
//                              Icons.lock,
//                              color: Colors.yellow,
//                            ),
//                            trailing: Icon(Icons.arrow_forward_ios),
//                            title: Text(
//                              AppLocalizations.of(context)
//                                  .translate('privacyPolicy_str'),
//                              style: TextStyle(
//                                fontFamily:
//                                    locator<PrefsService>().appLanguage == 'en'
//                                        ? 'en'
//                                        : 'ar',
//                              ),
//                            ),
//                          ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 100,
                                child: RaisedButton(
                                    color: Colors.teal.shade900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          locator<PrefsService>().appLanguage == 'en'
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(5.0),
                                                  bottomLeft: Radius.circular(5.0),
                                                )
                                              : BorderRadius.only(
                                                  topRight: Radius.circular(5.0),
                                                  bottomRight: Radius.circular(5.0),
                                                ),
                                      side: BorderSide(
                                        color: Colors.teal.shade900,
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('signOut_str'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            locator<PrefsService>().appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar',
                                      ),
                                    ),
                                    onPressed: () {
                                      locator<PrefsService>().clearAllPrefs();
//                                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext
                                              context) =>
                                                  LangScreen()));


                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}
