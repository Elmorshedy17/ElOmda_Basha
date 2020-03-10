import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_language.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:provider/provider.dart';

class LangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height * 0.6) - 35,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                        color: Colors.teal.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          'English',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'en',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          appLanguage.changeLanguage(Locale('en'));
                          locator<PrefsService>().appLanguage = 'en';
                          locator<PrefsService>().hasChosenLanguage = true;
                          Navigator.pushReplacementNamed(context, '/adsScreen');
                        }),
                  ),
                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                        color: Colors.teal.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          'عربي',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ar',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          appLanguage.changeLanguage(Locale('ar'));
                          locator<PrefsService>().appLanguage = 'ar';
                          locator<PrefsService>().hasChosenLanguage = true;
                          Navigator.pushReplacementNamed(context, '/adsScreen');
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
