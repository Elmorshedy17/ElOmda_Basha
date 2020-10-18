import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

Widget noAvailable(text, icon) {
  return FadeInDown(
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.teal.shade900.withOpacity(.5),
              // color:  Color(0xFF858585),
              fontSize: 21,
              fontFamily:
                  locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 8.0,
          ),
          Icon(
            icon,
            color: Colors.teal.shade900.withOpacity(.5),
            size: 25.0,
          )
        ],
      ),
    ),
  );
}

Widget needSignIn(BuildContext context) {
  return FadeInDown(
    child: Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.lock,
              size: 150.0,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
              color: Colors.teal.shade900,
              onPressed: () {
                Navigator.of(context).pushNamed('/signInScreen');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  AppLocalizations.of(context).translate("signToContinue_str"),
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              )),
        ],
      )),
    ),
  );
}
