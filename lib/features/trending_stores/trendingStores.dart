import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class TrendingStoresArguments {
  final String title;
  final double lng;

  TrendingStoresArguments({@required this.title, @required this.lng});
}

class TrendingStoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrendingStoresArguments args = ModalRoute.of(context).settings.arguments;

    return MainBackground(
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 60,
              child: Text(
                AppLocalizations.of(context)
                    .translate('trendingRestaurants_str'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily:
                      locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(top: 8),
                      height: 250,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/icon.png',
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4),
                              child: Text(
                                'title',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4),
                              child: Text('description'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.star,
                                    size: 15,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.star,
                                    size: 15,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.star,
                                    size: 15,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.star,
                                    size: 15,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.star,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
