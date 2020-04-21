import 'package:flutter/material.dart';
import 'package:momentoo/features/home/home_manager.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_language.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/drawer_bk.png',
              fit: BoxFit.fill,
            ),
          ),
          // AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          //   leading: Container(),
          //   actions: <Widget>[
          //     Builder(builder: (context) {
          //       return IconButton(
          //           icon: Icon(Icons.arrow_back_ios),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           });
          //     }),
          //   ],
          // ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 80),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: 110,
                  height: 110,
                  child: Image.asset('assets/images/logo.png'),
                ),
                locator<PrefsService>().userObj != null
                    ? ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/favoritesScreen",
                              (route) => route.isCurrent
                                  ? route.settings.name == "/favoritesScreen"
                                      ? false
                                      : true
                                  : true);
                        },
                        leading: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('favorites_str'),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                      )
                    : Container(),
                locator<PrefsService>().userObj != null
                    ? Container(
                        margin: locator<PrefsService>().appLanguage == 'en'
                            ? EdgeInsets.only(left: 16, right: 5)
                            : EdgeInsets.only(right: 16, left: 5),
                        height: 0.5,
                        color: Colors.white,
                      )
                    : Container(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/allTrendingScreen",
                        (route) => route.isCurrent
                            ? route.settings.name == "/allTrendingScreen"
                                ? false
                                : true
                            : true);
                  },
                  leading: Icon(
                    Icons.trending_up,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalizations.of(context).translate('allTrending_str'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar'),
                  ),
                ),
                Container(
                  margin: locator<PrefsService>().appLanguage == 'en'
                      ? EdgeInsets.only(left: 16, right: 5)
                      : EdgeInsets.only(right: 16, left: 5),
                  height: 0.5,
                  color: Colors.white,
                ),
                locator<PrefsService>().userObj != null
                    ? ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/myOrdersScreen",
                              (route) => route.isCurrent
                                  ? route.settings.name == "/myOrdersScreen"
                                      ? false
                                      : true
                                  : true);
                        },
                        leading: Icon(
                          Icons.touch_app,
                          color: Colors.white,
                        ),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('myOrders_str'),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar'),
                        ),
                      )
                    : Container(),
                locator<PrefsService>().userObj != null
                    ? Container(
                        margin: locator<PrefsService>().appLanguage == 'en'
                            ? EdgeInsets.only(left: 16, right: 5)
                            : EdgeInsets.only(right: 16, left: 5),
                        height: 0.5,
                        color: Colors.white,
                      )
                    : Container(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/helpSupportScreen",
                        (route) => route.isCurrent
                            ? route.settings.name == "/helpSupportScreen"
                                ? false
                                : true
                            : true);
                  },
                  leading: Image.asset(
                    'assets/images/drawer_help.png',
                    color: Colors.white,
                    width: 30,
                    height: 30,
                  ),
                  title: Text(
                    AppLocalizations.of(context).translate('help&support_str'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar'),
                  ),
                ),
                Container(
                  margin: locator<PrefsService>().appLanguage == 'en'
                      ? EdgeInsets.only(left: 16, right: 5)
                      : EdgeInsets.only(right: 16, left: 5),
                  height: 0.5,
                  color: Colors.white,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/aboutScreen",
                        (route) => route.isCurrent
                            ? route.settings.name == "/aboutScreen"
                                ? false
                                : true
                            : true);
                  },
                  leading: Image.asset(
                    'assets/images/drawer_about.png',
                    color: Colors.white,
                    width: 30,
                    height: 30,
                  ),
                  title: Text(
                    AppLocalizations.of(context).translate('aboutMomentoo_str'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar'),
                  ),
                ),
                Container(
                  margin: locator<PrefsService>().appLanguage == 'en'
                      ? EdgeInsets.only(left: 16, right: 5)
                      : EdgeInsets.only(right: 16, left: 5),
                  height: 0.5,
                  color: Colors.white,
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalizations.of(context).translate('language_str'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar'),
                  ),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Text(
                          'AR',
                          style: TextStyle(
                              color: locator<PrefsService>().appLanguage == 'ar'
                                  ? Colors.white
                                  : Colors.white54,
                              fontFamily: 'en'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 1,
                          height: 15,
                          color: Colors.white,
                        ),
                        Text(
                          'EN',
                          style: TextStyle(
                              color: locator<PrefsService>().appLanguage == 'en'
                                  ? Colors.white
                                  : Colors.white54,
                              fontFamily: 'en'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    if (locator<PrefsService>().appLanguage == 'en') {
                      appLanguage.changeLanguage(Locale('ar'));
                      locator<PrefsService>().appLanguage = 'ar';
                    } else {
                      appLanguage.changeLanguage(Locale('en'));
                      locator<PrefsService>().appLanguage = 'en';
                    }
                  },
                ),
                Container(
                  margin: locator<PrefsService>().appLanguage == 'en'
                      ? EdgeInsets.only(left: 16, right: 5)
                      : EdgeInsets.only(right: 16, left: 5),
                  height: 0.5,
                  color: Colors.white,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context)
                            .translate('deliveryInAMoment_str'),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar'),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: locator<PrefsService>().appLanguage == 'en'
                            ? EdgeInsets.only(left: 8)
                            : EdgeInsets.only(right: 8),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('poweredByLine_str'),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar',
                              fontSize:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 13
                                      : 11),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: 400,
                          height: 30,
                          child: CustomObserver(
                              stream: locator<HomeManager>().socialMedia$,
                              onSuccess: (_, List<SocialMedia> data) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data?.length ?? 0,
                                    itemBuilder: (_, index) {
                                      return InkWell(
                                        onTap: () async {
                                          await canLaunch(data[index].link)
                                              ? await launch(data[index].link)
                                              : throw 'Link cannot be handled';
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Image.network(
                                            data[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text('Delivery in A Moment'),
              ],
            ),
          ),
          locator<PrefsService>().appLanguage == 'en'
              ? Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              : Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
        ],
      ),
    );
  }
}
