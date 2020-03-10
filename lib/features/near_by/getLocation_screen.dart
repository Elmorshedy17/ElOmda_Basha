import 'package:flutter/material.dart';
import 'package:momentoo/features/near_by/currentMap_screen.dart';
import 'package:momentoo/features/near_by/manuallyMap_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/location_service.dart';

class GetLocationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/images/location.png',
//                  scale: 0.8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hi, nice to meet you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose your location to start find restaurants around you.',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  child: FlatButton(
                    color: Colors.transparent,
                    highlightColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.teal.shade900),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Icon(
                            Icons.near_me,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        Text(
                          'Use current location',
                          style: TextStyle(
                            color: Colors.teal.shade800,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      locationPermissionDialog(context);
                      // showDialog(
                      //     context: context,
                      //     builder: (context) =>
                      //         locationPermissionDialog(context));
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // locator<LocationService>().location$.listen((value) {
                  //   print('lat=> ${value.latitude} && lng=>${value.longitude}');
                  //   Navigator.of(context).pushNamed(
                  //     '/manuallyMapScreen',
                  //     arguments: ManuallyMapScreenArguments(
                  //       lat: 29.378586,
                  //       lng: 47.990341,
                  //     ),
                  //   );
                  // });
                  Navigator.of(_scaffoldKey.currentContext).pushNamed(
                    '/manuallyMapScreen',
                    arguments: ManuallyMapScreenArguments(
                      lat: 29.378586,
                      lng: 47.990341,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Select it manually',
                        style: TextStyle(color: Colors.teal.shade800),
                      ),
                      Container(
                        color: Colors.teal.shade900,
                        height: 1,
                        width: 110,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  locationPermissionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/location.png',
//                  scale: 0.8,
                      ),
                    ),
                    title: Text(
                      'Allow Momentoo to take your location!',
                      style: TextStyle(color: Colors.teal.shade900),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(_scaffoldKey.currentContext).pop();
                      },
                      child: Container(
                        height: 50,
                        width: 119,
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            // bottomRight: Radius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: 50,
                      color: Colors.grey,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(_scaffoldKey.currentContext);
                        locator<LocationService>().location$.listen((value) {
                          print(
                              'lat=> ${value.latitude} && lng=>${value.longitude}');
                          Navigator.of(_scaffoldKey.currentContext).pushNamed(
                            '/currentMapScreen',
                            arguments: CurrentMapScreenArguments(
                              lat: value.latitude,
                              lng: value.longitude,
                            ),
                          );
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 119,
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.only(
                            // bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.teal.shade900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
