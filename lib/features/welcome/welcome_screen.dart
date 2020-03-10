import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

int currentPageIndex = 0;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _welcomePageController;
  List<Widget> welcomeScreens = <Widget>[
    _Welcome(
        index: 1,
        title: 'Discover place near you',
        content:
            '''We make it simple to find the food you crave. Enter your address and let us do the rest.'''),
    _Welcome(
        index: 2,
        title: 'Choose A Tasty Dish',
        content:
            """When you order Eat Street. we'll hook you up with exclusive coupons, specials and rewards."""),
    _Welcome(
        index: 3,
        title: 'Delivery',
        content:
            '''We make food ordering fast, simple and free - no matter if you order online or cache'''),
  ];

  @override
  void initState() {
    super.initState();
    _welcomePageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _welcomePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
                child: Image.asset(
              'assets/images/welcome_logo.png',
              height: (MediaQuery.of(context).size.height * 0.3) - 40,
              color: Colors.white,
            )),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: PreferredSize(
            //   preferredSize:
            //       Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height * 0.3,
            //     child: Center(
            //         child: Image.asset(
            //       'assets/images/welcome_logo.png',
            //       height: (MediaQuery.of(context).size.height * 0.3) - 40,
            //       color: Colors.white,
            //     )),
            //   ),
            // ),
            body: Center(
              child: PageView.builder(
                controller: _welcomePageController,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  currentPageIndex = index;
                },
                itemCount: welcomeScreens.length,
                itemBuilder: (_, index) {
                  // currentPageIndex = index;
                  return welcomeScreens[index];
                },
              ),
            ),
          ),
          Positioned(
            bottom: 13,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.transparent,
              child: DotsIndicator(
                controller: _welcomePageController,
                itemCount: welcomeScreens.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
class _Welcome extends StatelessWidget {
  final int index;
  final String title;
  final String content;

  const _Welcome(
      {@required this.title, @required this.content, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily:
                  locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: index == 3
              ? RaisedButton(
                  color: Colors.teal.shade900,
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/langScreen');
                  },
                )
              : InkWell(
                  child: Text(
                    'Skip>>',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                      // fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/langScreen');
                  },
                ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
// An Indicator showing the currently selected page of a PageController.
class DotsIndicator extends AnimatedWidget {
  /// The pageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController.
  final int itemCount;

  /// Called when a dot is tapped.
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to 'Colors.white'.
  final Color color;

  DotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color: Colors.white})
      : super(listenable: controller);

  // The base size of the dots.
  static const double _DOT_SIZE = 25.0;

  // The increase in the size of selected dot.
  static const double _MAX_ZOOM = 2.0;

  // The distance between the center of each dot.
  static const double _DOT_SPACING = 80.0;

  Widget _buildDot(int index) {
    double selectness = Curves.easeOut.transform(
      max(0.0,
          1.0 - ((controller.page ?? controller.initialPage) - index).abs()),
    );
    double zoom = 1.0 + (_MAX_ZOOM - 1.0) * selectness;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      width: _DOT_SIZE,
      child: Center(
        child: Material(
          color:
              index == currentPageIndex ? Colors.teal.shade900 : Colors.black12,
          type: MaterialType.card,
          child: Container(
            width: _DOT_SPACING,
            height: 3 * zoom,
            // child: InkWell(
            //   onTap: () => onPageSelected(index),
            // ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      verticalDirection: VerticalDirection.down,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      textDirection: locator<PrefsService>().appLanguage == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
