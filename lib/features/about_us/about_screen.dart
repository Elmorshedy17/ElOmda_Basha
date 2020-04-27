import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:momentoo/features/about_us/about_manager.dart';
import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/theme_setting.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            title: Text("About Momento"),
            centerTitle: true,
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
                            : 'ar'),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            // padding: EdgeInsets.all(15.0),
            // margin: EdgeInsets.only(right:15.0,left: 15.0,bottom: 15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Container(
                child: CustomObserver(
                  stream: locator<AboutManager>().getData(),
                  onSuccess: (_, AboutModel model) {
                    About content = model.data.about;
                    return ListView(
                      children: <Widget>[
                        Html(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          data: content.content,
                          customTextAlign: (data) {
                            return TextAlign.justify;
                          },
                        ),
                        ButtonTheme(
                            height: 60.0,
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: RaisedButton(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0)),
//                    color: Theme.of(context).primaryColor,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.0),
                                  child: Text(
                                    'Join US',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MainFont,
                                        fontWeight: semiFont,
                                        fontFamily: "sukar"),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/joinUsFirstScreen');
                                },
                              ),
                            ))
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
