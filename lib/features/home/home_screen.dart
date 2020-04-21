import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/home/autoComplete_manager.dart';
import 'package:momentoo/features/home/autoComplete_model.dart';
import 'package:momentoo/features/home/home_manager.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_widgets/content.dart';
import 'package:momentoo/features/notifications/notifications_manager.dart';
import 'package:momentoo/features/search/searchResult_screen.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
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
  bool isSearchQueryEmpty = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    locator<NotificationsManager>().getData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    locator<AutoCompleteManager>().query$.listen((v) =>
        v.isEmpty ? isSearchQueryEmpty = true : isSearchQueryEmpty = false);

    // if (MediaQuery.of(context).viewInsets.bottom == 0) {
    //   FocusScope.of(context).requestFocus(FocusNode());
    //   if (overlayEntry != null) {
    //     if (overlayEntry.opaque) {
    //       overlayEntry?.remove();
    //     }
    //   }
    // }

    return NetworkSensitive(
      child: WillPopScope(
        onWillPop: () async {
          locator<TextEditingController>().clear();
          if (isSearchQueryEmpty) {
            // setState(() {
            //   FocusScope.of(context).requestFocus(FocusNode());
            // });
            return true;
          } else {
            setState(() {
              isSearchQueryEmpty = true;
              locator<TextEditingController>().clear();
              FocusScope.of(context).requestFocus(FocusNode());
            });

            return false;
          }
        },
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
                AppLocalizations.of(context).translate(
                    isSearchQueryEmpty ? 'momentoo_str' : 'search_str'),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily:
                      locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                ),
              ),
              leading: isSearchQueryEmpty
                  ? Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {});
                          isSearchQueryEmpty = true;
                          FocusScope.of(context).requestFocus(FocusNode());
                          // if (overlayEntry.opaque) {
                          //   overlayEntry?.remove();
                          // }
                          locator<TextEditingController>().clear();
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        locator<TextEditingController>().clear();
                        setState(() {
                          isSearchQueryEmpty = true;
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back_ios),
                          Text(
                            AppLocalizations.of(context).translate('back_str'),
                            style: TextStyle(
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar',
                            ),
                          ),
                        ],
                      ),
                    ),
              actions: <Widget>[
                isSearchQueryEmpty
                    ? NotificationWidget(
                        onPressedNotifications: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          isSearchQueryEmpty = true;
                          locator<TextEditingController>().clear();
                          Navigator.of(context)
                              .pushNamed('/notificationsScreen');
                          locator<PrefsService>().notificationFlag = false;
                        },
                      )
                    : Container(
                        height: 1,
                        width: 1,
                      ),
              ],
            ),
            body: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 55,
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: TextField(
                    controller: locator<TextEditingController>(),
                    onChanged: (value) {
                      setState(() {});
                      locator<AutoCompleteManager>()
                          .inQuery
                          .add(locator<TextEditingController>().text);
                      // locator<SearchManager>().inQuery.add(value);
                      // print(value);
                    },
                    onTap: () {
                      setState(() {
                        isSearchQueryEmpty = false;
                      });
                      locator<AutoCompleteManager>()
                          .inCategoryId
                          .add(categoryId);
                    },
                    onSubmitted: (value) {
                      locator<TextEditingController>().clear();
                    },
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.teal[900],
                        ),
                        hintText: AppLocalizations.of(context)
                            .translate('search..._str'),
                        fillColor: Colors.white),
                  ),
                ),
                // SizedBox.fromSize(
                //   size: Size.fromHeight(35),
                // ),
                MediaQuery.of(context).size.height != 569.3333333333334
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      )
                    : Container(),
                isSearchQueryEmpty ? categoryList() : Container(),
                isSearchQueryEmpty
                    ? Expanded(
                        child:
                            // isSearchQueryEmpty
                            //     ?
                            CustomObserver(
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
                                  trendingSellersList:
                                      model.data.trandingSellers,
                                  trendingProductsList:
                                      model.data.trandingProducts,
                                  sellersList: model.data.sellers,
                                  trendingSellersName: model
                                      .data.activeCategory.trandingSellersName,
                                  trendingProductName: model
                                      .data.activeCategory.trandingProductName,
                                  sellersName:
                                      model.data.activeCategory.sellersName,
                                );
                              });
                        },
                      )
                        // : CustomObserver(
                        //     stream: locator<SearchManager>().searchResult$,
                        //     onSuccess: (_, SearchModel model) {
                        //       return Card(
                        //         elevation: 5,
                        //         child: Container(
                        //           width: MediaQuery.of(context).size.width * 0.95,
                        //           height: MediaQuery.of(context).size.height / 2,
                        //           child: ListView.separated(
                        //             shrinkWrap: true,
                        //             itemCount: model.data.words?.length ?? 0,
                        //             separatorBuilder:
                        //                 (BuildContext context, int index) {
                        //               return Divider(
                        //                 color: Colors.grey,
                        //               );
                        //             },
                        //             itemBuilder: (context, index) {
                        //               return ListTile(
                        //                   onTap: () {
                        //                     Navigator.of(context)
                        //                         .pushNamed('/searchResultScreen');
                        //                     locator<TextEditingController>()
                        //                         .clear();
                        //                     isSearchQueryEmpty = true;
                        //                     FocusScope.of(context)
                        //                         .requestFocus(FocusNode());
                        //                   },
                        //                   title: Text(model.data.words[index]));
                        //             },
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        )
                    : CustomObserver(
                        stream: locator<AutoCompleteManager>().searchResult$,
                        onWaiting: (_) => Container(),
                        onSuccess: (_, AutoCompleteModel model) {
                          return Card(
                            elevation: 5,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height / 2,
                              child: model.data.words.isNotEmpty
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: model.data.words?.length ?? 0,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          color: Colors.grey,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                '/searchResultScreen',
                                                arguments:
                                                    SearchResultsScreenArguments(
                                                  categoryId: categoryId,
                                                  title:
                                                      model.data.words[index],
                                                ),
                                              );
                                              locator<TextEditingController>()
                                                      .text =
                                                  model.data.words[index];
                                              isSearchQueryEmpty = true;
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            },
                                            title:
                                                Text(model.data.words[index]));
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('noSearchResult_str'),
                                      ),
                                    ),
                            ),
                          );
                        }),
              ],
            ),
            bottomNavigationBar: isSearchQueryEmpty
                ? CustomBottomNavigation()
                : Container(
                    height: 1,
                  ),
          ),
        ),
      ),
    );
  }

  Widget categoryList() {
    return Container(
      height: 75,
      child: CustomObserver(
        stream: locator<HomeManager>().getData(categoryId),
        onWaiting: (_) => Container(),
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
