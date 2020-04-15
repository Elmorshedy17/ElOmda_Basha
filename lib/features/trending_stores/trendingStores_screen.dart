import 'package:flutter/material.dart';
import 'package:momentoo/features/trending_stores/trendingStore_manager.dart';
import 'package:momentoo/features/trending_stores/trendingStore_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class TrendingStoresArguments {
  final int categoryId;

  TrendingStoresArguments({@required this.categoryId});
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
          centerTitle: true,
          title: CustomObserver(
            stream: locator<TrendingStoreManager>().getData(args.categoryId),
            onWaiting: (_) => Container(),
            onSuccess: (_, TrendingStoreModel model) => FittedBox(
              child: Text(
                model.message,
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  fontFamily:
                      locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                ),
              ),
            ),
          ),
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomObserver(
            stream: locator<TrendingStoreManager>().getData(args.categoryId),
            onSuccess: (_, TrendingStoreModel model) => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: model.data.sellers.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(top: 8),
                      height: 250,
                      child: Card(
                        elevation: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              model.data.sellers[index].image,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4),
                              child: Text(
                                model.data.sellers[index].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar'),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4),
                              child: Text(
                                model.data.sellers[index].cuisine,
                                style: TextStyle(
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                    color: Colors.black38),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List<Widget>.generate(
                                  5,
                                  (innerIndex) => Icon(
                                    Icons.star,
                                    color: innerIndex <
                                            model.data.sellers[index].rate
                                        ? Colors.pink
                                        : Colors.grey,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                          icon: Icon(
                            Icons.star,
                            color: model.data.sellers[index].favourite == 'yes'
                                ? Colors.pink
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {}),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}