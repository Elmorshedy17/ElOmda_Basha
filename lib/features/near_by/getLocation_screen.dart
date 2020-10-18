import 'package:flutter/material.dart';
import 'package:momentoo/features/near_by/currentMap_screen.dart';
import 'package:momentoo/features/near_by/manuallyMap_screen.dart';
import 'package:momentoo/features/near_by/nearBy_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/location_service.dart';
import 'package:momentoo/features/near_by/geo_code/repo.dart';
import 'package:momentoo/features/near_by/cities/_repo.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class GetLocationScreen extends StatefulWidget {
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  var cityIdChosen;

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: StreamBuilder<Object>(
              stream: isLoading.stream,
              builder: (context, isLoadingSnapshot) {
                return Stack(
                  children: <Widget>[
                    Center(
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
//                  'Hi, nice to meet you!',
                              AppLocalizations.of(context)
                                  .translate('nice_to_meet_you_str'),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
//                  'Choose your location to start find restaurants around you.',
                              AppLocalizations.of(context)
                                  .translate('choose_your_location_str'),
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
//                          'Use current location',
                                      AppLocalizations.of(context).translate(
                                          'Use_current_location_str'),
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
                              Navigator.of(_scaffoldKey.currentContext)
                                  .pushNamed(
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
//                        'Select it manually',
                                    AppLocalizations.of(context)
                                        .translate('Select_it_manually_str'),
                                    style:
                                        TextStyle(color: Colors.teal.shade800),
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
                          InkWell(
                            onTap: () {
                              isLoading.add(true);

                              citiesRepo.getcitiesData().then((onValue) {
                                isLoading.add(false);

                                if (onValue.status == 1) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Container(
                                          height: 400,
                                          width: 300,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: onValue
                                                      .data.cities.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 45.0,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            //                   <--- left side
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .6),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
//                                                  padding: EdgeInsets.symmetric(vertical: 8.0),
//                                          color: Colors.red,
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            cityIdChosen =
                                                                onValue
                                                                    .data
                                                                    .cities[
                                                                        index]
                                                                    .id;
                                                            locator<PrefsService>()
                                                                    .cityID =
                                                                onValue
                                                                    .data
                                                                    .cities[
                                                                        index]
                                                                    .id
                                                                    .toString();
//                                                        Navigator.of(context).pushReplacementNamed('/nearByScreen');
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder: (context) =>
                                                            //           NearByScreen(
                                                            //               cityIdChosen)),
                                                            // );
                                                            Navigator.of(context).pushNamed(
                                                                '/nearByScreen',
                                                                arguments:
                                                                    NearByScreenargs(
                                                                        cityIdChosen));

                                                            print(
                                                                "cityIdChosen$cityIdChosen");
                                                          },
                                                          child: Text(
                                                            onValue
                                                                .data
                                                                .cities[index]
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(onValue.message),
                                      );
                                    },
                                  );
                                }
                              });

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
//                  Navigator.of(_scaffoldKey.currentContext).pushNamed(
//                    '/manuallyMapScreen',
//                    arguments: ManuallyMapScreenArguments(
//                      lat: 29.378586,
//                      lng: 47.990341,
//                    ),
//                  );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                children: <Widget>[
                                  Text(
//                        'Select it manually',
                                    AppLocalizations.of(context)
                                        .translate('chooseCity_str'),
                                    style:
                                        TextStyle(color: Colors.teal.shade800),
                                  ),
                                  Container(
                                    color: Colors.teal.shade900,
                                    height: 1,
                                    width: 70,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isLoading.value == true
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                                child: Container(
//                      color: mainColor,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )),
                          )
                        : Container(),
                  ],
                );
              }),
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
//                          "No",
                          AppLocalizations.of(context).translate('No_str'),
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
                        locator<LocationService>()
                            .location$
                            .listen((value) async {
//                          await geoCodeRepo.geoCode(value.latitude,value.longitude).then((onValue){
//
//                            if(onValue.status == "OK"){
//
//                              for (int i = 0; i < 2; i++) {
//                                if (onValue.results.length == 0 ||
//                                    i > onValue.results.length - 1) {
//                                  print("hahahaho ");
//                                } else {
//                                  var addressComponents =
//                                      onValue.results[i].addressComponents;
//                                  addressComponents.forEach((f) {
//                                    if (f.types[0] == "locality" ||
//                                        f.types[0] == "political") {
//                                      print(f.longName);
//                                      print(f);
//                                    }
//                                  });
//                                }
//                              }
//
//                            }else{
//                              print("hahahaho ");
//
//                            }
//
//                            print("onValueonValueonValueonValueonValueonValue ${onValue.status}");
//                          });

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
//                          AppLocalizations.of(context).translate('Yes_str'),
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

  @override
  void dispose() {
    isLoading.close();
  }
}
