import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/near_by/nearBy_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class CustomBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      height: 85,
      width: MediaQuery.of(context).size.width,
      child: Stack(
//        alignment: Alignment.bottomCenter,
//        fit: StackFit.loose,
        // alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          //! [Background]
          Positioned(
            height: 90,
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.transparent,
              // height: MediaQuery.of(context).size.height * 0.2,
              height: 85,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/tab_bar.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          //! Near by
          Positioned(
            // height: 70,
            bottom: 10,
            right: 0.0,
            left: 0.0,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'main',
                  backgroundColor:
                      ModalRoute.of(context).settings.name == '/nearByScreen'
                          ? Colors.teal.shade900
                          : Colors.black12,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/near_by_icon.png',
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (locator<PrefsService>().isNearbyFirstTimeOpining ==
                        true) {
                      locator<PrefsService>().isNearbyFirstTimeOpining = false;
                      Navigator.of(context).pushNamed('/getLocationScreen');
                    } else {
//                      Navigator.of(context).pushNamedAndRemoveUntil(
//                          "/nearByScreen",
//                          (route) => route.isCurrent
//                              ? route.settings.name == "/nearByScreen"
//                                  ? false
//                                  : true
//                              : true);
//                      Navigator.of(context).pushNamed('/getLocationScreen');




                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NearByScreen(locator<PrefsService>().cityID)),
                      );


                    }
                  },
                ),
                Text(
                  'Near by',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    color:
                        ModalRoute.of(context).settings.name == '/nearByScreen'
                            ? Colors.teal.shade900
                            : Colors.black12,
                  ),
                )
              ],
            ),
          ),
          //! Home
          Positioned(
            // height: 70,
            left: 10,
            bottom: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/homeScreen",
                    (route) => route.isCurrent
                        ? route.settings.name == "/homeScreen" ? false : true
                        : true);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    color: ModalRoute.of(context).settings.name == '/homeScreen'
                        ? Colors.teal.shade900
                        : Colors.black12,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                      color:
                          ModalRoute.of(context).settings.name == '/homeScreen'
                              ? Colors.teal.shade900
                              : Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! Cart
          Positioned(
            // height: 70,
            left: MediaQuery.of(context).size.width / 4,
            bottom: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/cartScreen",
                    (route) => route.isCurrent
                        ? route.settings.name == "/cartScreen" ? false : true
                        : true);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: ModalRoute.of(context).settings.name == '/cartScreen'
                        ? Colors.teal.shade900
                        : Colors.black12,
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                      color:
                          ModalRoute.of(context).settings.name == '/cartScreen'
                              ? Colors.teal.shade900
                              : Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! Settings
          Positioned(
            // height: 70,
            right: MediaQuery.of(context).size.width / 4,
            bottom: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/settingsScreen",
                    (route) => route.isCurrent
                        ? route.settings.name == "/settingsScreen"
                            ? false
                            : true
                        : true);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: ModalRoute.of(context).settings.name ==
                            '/settingsScreen'
                        ? Colors.teal.shade900
                        : Colors.black12,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                      color: ModalRoute.of(context).settings.name ==
                              '/settingsScreen'
                          ? Colors.teal.shade900
                          : Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! Profile
          Positioned(
            // height: 70,
            right: 10,
            bottom: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/profileScreen",
                    (route) => route.isCurrent
                        ? route.settings.name == "/profileScreen" ? false : true
                        : true);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color:
                        ModalRoute.of(context).settings.name == '/profileScreen'
                            ? Colors.teal.shade900
                            : Colors.black12,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                      color: ModalRoute.of(context).settings.name ==
                              '/profileScreen'
                          ? Colors.teal.shade900
                          : Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
