import 'package:flutter/material.dart';
import 'package:momentoo/features/trending_products/trendinfProduct_manager.dart';
import 'package:momentoo/features/trending_products/trendingProduct_model.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class TrendingProductsArguments {
  final int categoryId;

  TrendingProductsArguments({@required this.categoryId});
}

class TrendingProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrendingProductsArguments args = ModalRoute.of(context).settings.arguments;

    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: CustomObserver(
              stream:
                  locator<TrendingProductsManager>().getData(args.categoryId),
              onWaiting: (_) => Container(),
              onSuccess: (_, TrendingProductsModel model) => FittedBox(
                child: Text(
                  model.message,
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
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
              NotificationWidget(
                onPressedNotifications: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.of(context).pushNamed('/notificationsScreen');
                  locator<PrefsService>().notificationFlag = false;
                },
              ),
            ],
          ),
          body: CustomObserver(
            stream: locator<TrendingProductsManager>().getData(args.categoryId),
            onSuccess: (_, TrendingProductsModel model) => GridView.builder(
              itemCount: model.data.products.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FittedBox(
                  fit: BoxFit.fill,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        width: 200,
                        height: 200,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                model.data.products[index].image,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 120,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  model.data.products[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  model.data.products[index].section,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${model.data.products[index].price} ${model.data.products[index].currency}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 15,
                          right: 5,
                          child: IconButton(
                              icon: Icon(
                                Icons.star,
                                color: model.data.products[index].favourite ==
                                        'yes'
                                    ? Color(0xffF52B57)
                                    : Colors.white,
                              ),
                              onPressed: () {}))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
