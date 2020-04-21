import 'package:flutter/material.dart';
import 'package:momentoo/features/favorites/favorites_manager.dart';
import 'package:momentoo/features/favorites/favorites_model.dart';
import 'package:momentoo/features/favorites/favorites_widgets/favoritesContent.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int pageIndex = 0;
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('favorites_str'),
            style: TextStyle(
              color: Colors.white,
              fontFamily:
                  locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                locator<TextEditingController>().clear();
                Navigator.of(context)
                    .pushNamed('/notificationsScreen');
                locator<PrefsService>().notificationFlag = false;
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            favoritesCategoryList(),
            Expanded(
              child: CustomObserver(
                stream: locator<FavoritesManager>().getData(),
                onSuccess: (_, FavoritesModel model) => PageView.builder(
                    onPageChanged: (index) {
                      pageIndex = index;
                    },
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.data.categories?.length ?? 0,
                    itemBuilder: (_, index) {
                      return FavoritesContent(
                        pageIndex: pageIndex,
                        categories: model.data.categories,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget favoritesCategoryList() {
    return Container(
      height: 40,
      child: CustomObserver(
        stream: locator<FavoritesManager>().getData(),
        onSuccess: (_, FavoritesModel model) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
            scrollDirection: Axis.horizontal,
            itemCount: model.data.categories?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: RaisedButton(
                    color: pageIndex == index ? Colors.white24 : Colors.white54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.white,
                          width: pageIndex == index ? 1 : 0.0),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.data.categories[index].name,
                        style: TextStyle(
                          color: pageIndex == index
                              ? Colors.white
                              : Colors.teal.shade100,
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_pageController.hasClients) {
                        setState(() {
                          _pageController.jumpToPage(index);
                        });
                      }
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
