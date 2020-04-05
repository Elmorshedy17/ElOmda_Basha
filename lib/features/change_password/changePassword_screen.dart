import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text(
                  AppLocalizations.of(context).translate('back_str'),
                  style: TextStyle(
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar'),
                ),
              ],
            ),
          ),
          title: Text(
            AppLocalizations.of(context).translate('changePassword_str'),
            style: TextStyle(
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar'),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Card(
                margin: EdgeInsets.only(top: 12),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar'),
                      hintText: AppLocalizations.of(context)
                          .translate('currentEmail_str'),
                      fillColor: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar'),
                      hintText: AppLocalizations.of(context)
                          .translate('newPassword_str'),
                      fillColor: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar'),
                      hintText: AppLocalizations.of(context)
                          .translate('retypeNewPassword_str'),
                      fillColor: Colors.white),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ListTile(
          title: ButtonTheme(
            height: 50,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              color: Colors.teal.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.white24),
              ),
              child: Text(
                AppLocalizations.of(context).translate('save_str'),
                style: TextStyle(
                    color: Colors.white70,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar'),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
