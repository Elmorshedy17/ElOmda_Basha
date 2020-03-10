import 'package:flutter/material.dart';
import 'package:momentoo/shared//helper/locator.dart';
import 'package:momentoo/shared/services/connection_service.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  NetworkSensitive({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<InternetStatus>(context);
    bool hasConnection;

    switch (connectionStatus) {
      case InternetStatus.Online:
        hasConnection = true;
        break;
      case InternetStatus.Offline:
        hasConnection = false;
        break;
      default:
        hasConnection = true;
        break;
    }

    if (hasConnection) {
      if (locator<PrefsService>().isBackToOnline) {
        locator<PrefsService>().isBackToOnline = false;

        print('BACE TO ONLINE');
      }
      return child;
    } else {
      return AbsorbPointer(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // widget.child,
              child,
              InternetAlert(),
            ],
          ),
        ),
      );
    }
  }
}

////////////////////////////////////////////////////////////////////////////
class InternetAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    locator<PrefsService>().isBackToOnline = true;

    return Scaffold(
      backgroundColor: Colors.black12.withOpacity(0.3),
      body: Center(
        child: AlertDialog(
          content: Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            height: locator<PrefsService>().appLanguage == 'en' ? 120 : 130,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/no-wifi.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('noWifiTitle_str'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )
                  ],
                ),
                Container(
                    child: Text(
                  AppLocalizations.of(context).translate('noWifiContent_str'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, height: 1.5),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
