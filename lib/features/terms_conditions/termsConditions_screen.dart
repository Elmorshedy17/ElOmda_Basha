import 'package:flutter/material.dart';
import 'package:momentoo/features/settings/settings_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class TermsConditionsScreenArguments {
  final List<Pages> pages;

  TermsConditionsScreenArguments({
    @required this.pages,
  });
}

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TermsConditionsScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                          : 'ar',
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Center(
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 60,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('termsOfUse_str'),
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
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  elevation: 5,
                  child: SingleChildScrollView(),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
