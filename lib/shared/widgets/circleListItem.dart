//import 'package:flutter/material.dart';
//import 'package:momentoo/shared/helper/locator.dart';
//import 'package:momentoo/shared/services/prefs_service.dart';
//
//int pageIndex = 0;
//
//class CircleItem extends StatefulWidget {
//  final int heroTag;
////  final PageController pageController;
//
//  CircleItem({
//    this.heroTag,
//  });
//
//  @override
//  _CircleItemState createState() => _CircleItemState();
//}
//
//class _CircleItemState extends State<CircleItem> {
//  final _pageController = locator<PageController>();
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        FloatingActionButton(
//            heroTag: widget.heroTag,
//            backgroundColor:
////                (_pageController.page ?? _pageController.initialPage) ==
//                widget.heroTag == pageIndex ? Colors.teal.shade900 : Colors.red,
//            shape: RoundedRectangleBorder(
//                side: BorderSide(color: Colors.white, width: 2),
//                borderRadius: BorderRadius.circular(30)),
//            elevation: 0,
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Image.asset(
//                'assets/images/near_by_icon.png',
//                color: Colors.white,
//              ),
//            ),
//            onPressed: () {
//              _pageController.jumpToPage(widget.heroTag);
//              setState(() {});
//            }),
//        Text(
//          'Near by',
//          style: TextStyle(
//            fontSize: 11,
//            fontFamily:
//                locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
//            color: ModalRoute.of(context).settings.name == '/homeScreen'
//                ? Colors.teal[900]
//                : Colors.black12,
//          ),
//        )
//      ],
//    );
//  }
//}
//
//List<Widget> meCircles = <Widget>[
//  CircleItem(
//    heroTag: 0,
//  ),
////      pageController: locator<PageController>()),
//  CircleItem(
//    heroTag: 1,
//  ),
////pageController: locator<PageController>()),
//  CircleItem(
//    heroTag: 2,
//  ),
////pageController: locator<PageController>()),
//];
