//import 'package:flutter/material.dart';
//import 'package:momentoo/features/home/home_screen.dart';
//import 'package:momentoo/shared/helper/locator.dart';
//import 'package:momentoo/shared/services/prefs_service.dart';
//
//int pageIndex = 0;
//
//class CategoryList extends StatefulWidget {
//  @override
//  _CategoryListState createState() => _CategoryListState();
//}
//
//class _CategoryListState extends State<CategoryList> {
////  final _pageController = locator<PageController>();
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 75,
//      child: ListView.builder(
//        shrinkWrap: true,
//        physics: BouncingScrollPhysics(),
//        reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
//        scrollDirection: Axis.horizontal,
//        itemCount: 3,
//        itemBuilder: (context, index) {
//          return Padding(
//            padding: const EdgeInsets.symmetric(
//              horizontal: 16,
//            ),
//            child: Column(
//              children: <Widget>[
//                FloatingActionButton(
//                    heroTag: index,
//                    backgroundColor:
////                        (_pageController.page ?? _pageController.initialPage) ==
//                        pageIndex == index
//                            ? Colors.teal.shade900
//                            : Colors.black12,
//                    shape: RoundedRectangleBorder(
//                      side: BorderSide(color: Colors.white, width: 2),
//                      borderRadius: BorderRadius.circular(30),
//                    ),
//                    elevation: 0,
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Image.asset(
//                        'assets/images/near_by_icon.png',
//                        color: Colors.white,
//                      ),
//                    ),
//                    onPressed: () async {
//                      if (locator<PageController>().hasClients) {
////                        await Future.delayed(Duration.zero, () {
//
//                        locator<PageController>().jumpToPage(index);
//                        HomeScreen.of(context).setState(() {});
////                        });
//                      }
////                      _pageController.animateToPage(index,
////                          duration: Duration(seconds: 1), curve: Curves.easeIn);
////                      HomeScreen.of(context).setState(() {});
//                    }),
//                Text(
//                  'Near by',
//                  style: TextStyle(
//                    fontSize: 11,
//                    fontFamily: locator<PrefsService>().appLanguage == 'en'
//                        ? 'en'
//                        : 'ar',
//                    color:
////                        (_pageController.page ?? _pageController.initialPage) ==
//                        pageIndex == index ? Colors.teal[900] : Colors.black12,
//                  ),
//                )
//              ],
//            ),
//          );
//        },
//      ),
//    );
//  }
//}
