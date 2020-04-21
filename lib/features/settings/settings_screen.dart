import 'package:flutter/material.dart';
import 'package:momentoo/features/privacyPolicy&Terms/privacy&terms_screen.dart';
import 'package:momentoo/features/settings/notificationSwitch_manager.dart';
import 'package:momentoo/features/settings/settings_manager.dart';
import 'package:momentoo/features/settings/settings_model.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/main_drawer.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('sittings_str'),
            style: TextStyle(
              color: Colors.white,
              fontFamily:
                  locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: <Widget>[
            NotificationWidget(
              onPressedNotifications: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pushNamed('/notificationsScreen');

                locator<PrefsService>().notificationFlag = false;
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: CustomObserver(
                stream: locator<SettingsManager>().getData(),
                onSuccess: (_, SettingsModel model) => ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
//                      height: 600,
                        child: Column(
                          children: <Widget>[
                            locator<PrefsService>().userObj != null
                                ? ListTile(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .pushNamed('/addressBookScreen');
                                    },
                                    title: Text(
                                      AppLocalizations.of(context)
                                          .translate('changeYourEmail_str'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                    ),
                                    subtitle: Text(
                                      model.data.email,
                                      style: TextStyle(fontFamily: 'en'),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  )
                                : Container(),
                            locator<PrefsService>().userObj != null
                                ? Divider(
                                    endIndent: 15,
                                    indent: 15,
                                    height: 5,
                                    color: Colors.black12,
                                  )
                                : Container(),
                            locator<PrefsService>().userObj != null
                                ? ListTile(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .pushNamed('/termsConditionsScreen');
                                    },
                                    title: Text(
                                      AppLocalizations.of(context)
                                          .translate('changeYourPassword_str'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                    ),
                                    subtitle: Text('***********'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  )
                                : Container(),
                            locator<PrefsService>().userObj != null
                                ? Divider(
                                    endIndent: 15,
                                    indent: 15,
                                    height: 5,
                                    color: Colors.black12,
                                  )
                                : Container(),
                            ListTile(
                              onTap: () {
                                // Navigator.of(context).pushNamed('/privacyScreen');
                              },
                              trailing: Icon(Icons.arrow_forward_ios),
                              title: Text(
                                AppLocalizations.of(context)
                                    .translate('country_str'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                              subtitle: Text(
                                model.data.country.name,
                                // AppLocalizations.of(context)
                                //     .translate('Kuwait_str'),
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
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
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: model.data.pages?.length ?? 0,
                              separatorBuilder: (_, index) => Divider(
                                endIndent: 15,
                                indent: 15,
                                height: 5,
                                color: Colors.black12,
                              ),
                              itemBuilder: (_, index) => ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/privacyScreen',
                                      arguments: PrivacyTermsScreenArguments(
                                          page: model.data.pages[index]));
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                                title: Text(
                                  model.data.pages[index].title,
                                  // AppLocalizations.of(context)
                                  //     .translate('privacyPolicy_str'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ),
                            ),
                            // ListTile(
                            //   onTap: () {
                            //     // Navigator.of(context).pushNamed('/privacyScreen');
                            //   },
                            //   trailing: Icon(Icons.arrow_forward_ios),
                            //   title: Text(
                            //     AppLocalizations.of(context)
                            //         .translate('terms&Conditions_str'),
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontFamily:
                            //           locator<PrefsService>().appLanguage ==
                            //                   'en'
                            //               ? 'en'
                            //               : 'ar',
                            //     ),
                            //   ),
                            // ),
                            // Divider(
                            //   endIndent: 15,
                            //   indent: 15,
                            //   height: 5,
                            //   color: Colors.black12,
                            // ),
                            // ListTile(
                            //   onTap: () {
                            //     Navigator.of(context).pushNamed(
                            //         '/privacyScreen',
                            //         arguments: PrivacyScreenArguments(
                            //             pages: model.data.pages));
                            //   },
                            //   trailing: Icon(Icons.arrow_forward_ios),
                            //   title: Text(
                            //     AppLocalizations.of(context)
                            //         .translate('privacyPolicy_str'),
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontFamily:
                            //           locator<PrefsService>().appLanguage ==
                            //                   'en'
                            //               ? 'en'
                            //               : 'ar',
                            //     ),
                            //   ),
                            // ),
                            // Divider(
                            //   endIndent: 15,
                            //   indent: 15,
                            //   height: 5,
                            //   color: Colors.black12,
                            // ),
                            ListTile(
                              onTap: () {
                                // Navigator.of(context).pushNamed('/privacyScreen');

                                locator<NotificationSwitchManager>()
                                    .notificationSwitch(
                                        !locator<NotificationSwitchManager>()
                                            .currentValue);
                              },
                              trailing: StreamBuilder(
                                stream: locator<NotificationSwitchManager>()
                                    .switch$,
                                initialData: true,
                                builder: (context, snapshot) {
                                  return Switch(
                                    value:
                                        snapshot.hasData ? snapshot.data : true,
                                    onChanged: (value) {
                                      locator<NotificationSwitchManager>()
                                          .notificationSwitch(value);
                                    },
                                  );
                                },
                              ),
                              title: Text(
                                AppLocalizations.of(context)
                                    .translate('notifications_str'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
              //   child: ButtonTheme(
              //     minWidth: MediaQuery.of(context).size.width * 0.8,
              //     child: RaisedButton(
              //       color: Colors.teal.shade900,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //         side: BorderSide(color: Colors.white24),
              //       ),
              //       child: Text(
              //         AppLocalizations.of(context).translate('joinUs_str'),
              //         style: TextStyle(
              //           color: Colors.white70,
              //           fontFamily:
              //               locator<PrefsService>().appLanguage == 'en'
              //                   ? 'en'
              //                   : 'ar',
              //         ),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).pushNamed('/joinUsFirstScreen');
              //       },
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}
