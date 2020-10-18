import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

Widget noAvailable(text,icon) {
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
              fontFamily: locator<PrefsService>().appLanguage == 'en'  ? 'en'  : 'ar',
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

Widget emptyCart(context){
  return FadeInDown(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('NoItemsInCart_str'),
                style: TextStyle(
                  color: Colors.teal.shade900.withOpacity(.5),
                  fontSize: 21,
                   fontFamily: locator<PrefsService>().appLanguage == 'en'  ? 'en'  : 'ar',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 8.0,
              ),
              Image.asset(
                "assets/imgs/cart.png",
                width: 40.0,
                height: 40.0,
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),

          ButtonTheme(
            height: 40.0,
            minWidth: 120.0,
            child: RaisedButton(
                elevation: 10,
                color: Colors.teal.shade900.withOpacity(.5),

                child: Text(AppLocalizations.of(context).translate("back_str"),style: TextStyle( fontFamily: locator<PrefsService>().appLanguage == 'en'  ? 'en'  : 'ar'),),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
        ],
      ),
    ),
  );
}