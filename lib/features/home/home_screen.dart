import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/home/home_widgets/content.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/main_drawer.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class HomeScreen extends StatefulWidget {
  static _HomeScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
//    locator<PageController>().dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        drawer: MainDrawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Momentoo',
            // AppLocalizations.of(context).translate('test'),
            style: TextStyle(color: Colors.white),
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
                      child: Text('Search...'),
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
              child: PageView.builder(
                  onPageChanged: (index) {
                    pageIndex = index;
                  },
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: content.length,
                  itemBuilder: (_, index) {
                    return content[index];
                  }),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  Widget categoryList() {
    return Container(
      height: 75,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    heroTag: index,
                    backgroundColor:
//                        (_pageController.page ?? _pageController.initialPage) ==
                        pageIndex == index
                            ? Colors.teal.shade900
                            : Colors.black12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: index == 0
                          ? Image.asset(
                              'assets/images/restaurant.png',
                              color: Colors.white,
                            )
                          : index == 1
                              ? Image.asset(
                                  'assets/images/flower.png',
                                  color: Colors.white,
                                )
                              : Image.asset(
                                  'assets/images/pharmacy.png',
                                  color: Colors.white,
                                ),
                    ),
                    onPressed: () async {
                      if (_pageController.hasClients) {
//                        await Future.delayed(Duration.zero, () {
                        setState(() {
                          _pageController.jumpToPage(index);
                        });
//                        HomeScreen.of(context).setState(() {});
//                        });
                      }
//                      _pageController.animateToPage(index,
//                          duration: Duration(seconds: 1), curve: Curves.easeIn);
//                      HomeScreen.of(context).setState(() {});
                    }),
                Text(
                  index == 0
                      ? 'Restaurants'
                      : index == 1 ? 'Flowers' : 'Pharmacies',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    color:
//                        (_pageController.page ?? _pageController.initialPage) ==
                        pageIndex == index ? Colors.teal[900] : Colors.black12,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
