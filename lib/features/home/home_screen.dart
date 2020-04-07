import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/home/home_manager.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_widgets/content.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/main_drawer.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class HomeScreen extends StatefulWidget {
  static _HomeScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  int categoryId = 1;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
//    locator<PageController>().dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          drawer: MainDrawer(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('momentoo_str'),
              style: TextStyle(
                color: Colors.white,
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                onPressed: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  // overlayEntry?.remove();
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  // overlayEntry?.remove();
                  Navigator.of(context).pushNamed('/notificationsScreen');
                },
              ),
            ],
          ),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search, color: Colors.teal.shade900),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('search..._str'),
                          style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/searchScreen');
                  },
                ),
              ),
              categoryList(),
              Expanded(
                child: CustomObserver(
                  stream: locator<HomeManager>().getData(categoryId),
                  onSuccess: (_, HomeModel model) {
                    return PageView.builder(
                        onPageChanged: (index) {
                          pageIndex = index;
                        },
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: model.data.categories.length,
                        itemBuilder: (_, index) {
                          return HomeContent(
                            categoryId: categoryId,
                            adsList: model.data.ads,
                            trendingSellersList: model.data.trandingSellers,
                            trendingProductsList: model.data.trandingProducts,
                            sellersList: model.data.sellers,
                            trendingSellersName:
                                model.data.activeCategory.trandingSellersName,
                            trendingProductName:
                                model.data.activeCategory.trandingProductName,
                            sellersName: model.data.activeCategory.sellersName,
                          );
                        });
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigation(),
        ),
      ),
    );
  }

  Widget categoryList() {
    return Container(
      height: 75,
      child: CustomObserver(
        stream: locator<HomeManager>().getData(categoryId),
        onSuccess: (BuildContext context, HomeModel model) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
            scrollDirection: Axis.horizontal,
            itemCount: model.data.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                        heroTag: index,
                        backgroundColor: pageIndex == index
                            ? Colors.teal.shade900
                            : Colors.black12,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: pageIndex == index
                                  ? Colors.white
                                  : Colors.black12,
                              width: pageIndex == index ? 2 : 0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                        child: Image.network(
                          model.data.categories[index].image,
                          fit: BoxFit.fill,
                        ),
                        onPressed: () async {
                          if (_pageController.hasClients) {
                            setState(() {
                              _pageController.jumpToPage(index);
                              categoryId = model.data.categories[index].id;
                            });
                          }
                        }),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      model.data.categories[index].name,
                      style: TextStyle(
                          fontSize: locator<PrefsService>().appLanguage == 'en'
                              ? 12
                              : 11,
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                          color: pageIndex == index
                              ? Colors.teal[900]
                              : Colors.black38,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
