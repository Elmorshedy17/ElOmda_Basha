import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:momentoo/features/settings/settings_model.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class PrivacyTermsScreenArguments {
  final Pages page;

  PrivacyTermsScreenArguments({
    @required this.page,
  });
}

class PrivacyTermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PrivacyTermsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            args.page.title,
            // AppLocalizations.of(context).translate('privacyPolicy_str'),
            style: TextStyle(
              fontFamily:
                  locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            NotificationWidget(
              onPressedNotifications: () {
                Navigator.of(context).pushNamed('/notificationsScreen');
              },
            )
          ],
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
        body: Container(
          width: MediaQuery.of(context).size.width * 0.99,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Card(
            elevation: 5,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/welcome_logo.png',
                      // scale: 0.8,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  Html(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    data: args.page.content,
                    customTextAlign: (data) {
                      return TextAlign.justify;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
