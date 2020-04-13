import 'package:flutter/material.dart';
import 'package:momentoo/features/ads/ads_manager.dart';
import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class AdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      //   manager: locator<AdsManager>(),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomObserver(
                stream: locator<AdsManager>().getData(),
                onSuccess: (BuildContext context, AdsModel model) {
                  return Image.network(model.data.ads.image);
                }),
          ),
          Positioned(
            bottom: 5.0,
            right: 0.0,
            child: ButtonTheme(
              minWidth: 150,
              child: RaisedButton(
                  // color: Color(0x00413f),
                  color: Colors.teal.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      bottomLeft: Radius.circular(18.0),
                    ),
                    side: BorderSide(color: Colors.white70),
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('skip_str'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'en',
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (locator<PrefsService>().hasWelcomeSeen) {
                      Navigator.of(context).pushReplacementNamed('/homeScreen');
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed('/welcomeScreen');
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
