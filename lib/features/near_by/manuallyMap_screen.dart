import 'dart:async';
import 'package:momentoo/features/near_by/cities/_repo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:momentoo/features/near_by/geo_code/repo.dart';
import 'package:momentoo/features/near_by/getAddress_manager.dart';
import 'package:momentoo/features/near_by/nearBy_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class ManuallyMapScreenArguments {
  final double lat;
  final double lng;

  ManuallyMapScreenArguments({@required this.lat, @required this.lng});
}

class ManuallyMapScreen extends StatefulWidget {
  @override
  _ManuallyMapScreenState createState() => _ManuallyMapScreenState();
}

class _ManuallyMapScreenState extends State<ManuallyMapScreen> {
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  var manualcityIdChosen;

  var cityIdChosen;

  bool itsOk = false;

  List adressesCity = [];
  List formattedAddress = [];

  Completer<GoogleMapController> _controller = Completer();
  ManuallyMapScreenArguments args;

  GetAddressManager getAddressManager = locator<GetAddressManager>();

  void ChosenCity() {
    citiesRepo.getcitiesData().then((onValue) {
      isLoading.add(false);

      if (onValue.status == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(
                height: 400,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(    AppLocalizations.of(context).translate('cant_regonize_city_str'),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: onValue.data.cities.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  //                   <--- left side
                                  color: Colors.grey.withOpacity(.6),
                                  width: 1.0,
                                ),
                              ),
                            ),
//                                          color: Colors.red,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  cityIdChosen = onValue.data.cities[index].id;
//                                                        Navigator.of(context).pushReplacementNamed('/nearByScreen');

                                  locator<PrefsService>().cityID = onValue.data.cities[index].id.toString();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NearByScreen(cityIdChosen)),
                                  );

                                  print("cityIdChosen$cityIdChosen");
                                },
                                child: Text(
                                  onValue.data.cities[index].name,
                                  style: TextStyle(fontSize: 14),
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
  }

  // Get Address From coordinates
  getAddress(double lat, double lng) async {
//    final coordinates = new Coordinates(lat, lng);
//    var addresses =
//        await Geocoder.local.findAddressesFromCoordinates(coordinates);
//    var first = addresses.first;
//    getAddressManager.inFeatureName.add(first.featureName);
//    getAddressManager.inAddressLine.add(first.addressLine);
//    print(   " featureName  ${first.featureName} : ${first.addressLine} lat = > ${lat} long = > ${lng}");

    isLoading.add(true);


    citiesRepo.getcitiesData().then((onCities) async {

      if(onCities.status == 1){
        await geoCodeRepo.geoCode(lat, lng).then((onValue) {

          print("onValueonValueonValueonValueonValueonValue ${onValue.status}");
          print("onValueonValueonValueonValueonValueonValue $lat $lng");

          if (onValue.status == "OK") {
            setState(() {

              itsOk = true;

            });
            for (int i = 0; i < 2; i++) {
              isLoading.add(false);

              if (onValue.results.length == 0 || i > onValue.results.length - 1) {
                print("hahahaho ");
                ChosenCity();
              } else {
                var addressComponents = onValue.results[i].addressComponents;
                addressComponents.forEach((f) {
                  if (f.types[0] == "locality" || f.types[0] == "political") {
                    print(f.longName);
                    adressesCity.remove(f.longName);
                    adressesCity.add(f.longName);

                    print(f);
                  }else{
                    isLoading.add(false);
                    ChosenCity();
                  }
                });
              }
              formattedAddress.remove(onValue.results[i].formattedAddress);
              formattedAddress.add(onValue.results[i].formattedAddress);
            }
            getAddressManager.inFeatureName.add(locator<PrefsService>().appLanguage == "en" ? adressesCity[0] : adressesCity[1]);
            getAddressManager.inAddressLine.add(locator<PrefsService>().appLanguage == "en" ? formattedAddress[0]:formattedAddress[1]);


            for (int index = 0;index < onCities.data.cities.length;index++) {
              if(adressesCity[0] == onCities.data.cities[index].name ){
                print("ya rab ya karim ${onCities.data.cities[index].id}");
                manualcityIdChosen = onCities.data.cities[index].id;
                locator<PrefsService>().cityID = onCities.data.cities[index].id.toString();

              }
            }

          } else {
            isLoading.add(false);
            ChosenCity();
          }
        });
      }else{
        isLoading.add(false);
        ChosenCity();
      }

    });

  }

  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    getAddress(29.378586, 47.990341);
  }

  @override
  void dispose() {
    getAddressManager.dispose();
    isLoading.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder(
          stream: isLoading.stream,
          builder: (context, isLoadingSnapshot) {
            return Stack(
              children: <Widget>[
                _googleMap(context),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.13,
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/home_header.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 50.0,
                  child: deliveryAddress(context),
                ),
            Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 10.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.teal.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.white24),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('Deliver_Here_str'),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NearByScreen(manualcityIdChosen)),
                        );

//                        Navigator.of(context).pushReplacementNamed('/nearByScreen');
                      },
                    ),
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
//      bottomNavigationBar: Container(
//        padding: EdgeInsets.symmetric(horizontal: 4),
//        height: 50,
//        width: MediaQuery.of(context).size.width * 0.8,
//        child: RaisedButton(
//          padding: EdgeInsets.all(16),
//          color: Colors.teal.shade900,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(5.0),
//            side: BorderSide(color: Colors.white24),
//          ),
//          child: Text(
//            AppLocalizations.of(context).translate('Deliver_Here_str'),
//            style: TextStyle(
//              color: Colors.white,
//            ),
//          ),
//          onPressed: () {
//            Navigator.of(context).pushReplacementNamed('/nearByScreen');
//          },
//        ),
//      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return itsOk == true ? Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onTap: (LatLng latLng) {
          setState(() {
            markers.add(Marker(
              markerId: MarkerId('current'),
              position: LatLng(latLng.latitude, latLng.longitude),
              infoWindow: InfoWindow(title: 'Your Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
            ));
            getAddress(latLng.latitude, latLng.longitude);
          });
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(args.lat, args.lng),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
    ) : Container();
  }

  Widget deliveryAddress(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: Text(
                'Delivery Location',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.teal.shade900,
                size: 40,
              ),
              title: StreamBuilder<Object>(
                  initialData: '',
                  stream: getAddressManager.featureName$,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData ? snapshot.data : '',
                      style: TextStyle(color: Colors.teal.shade900),
                    );
                  }),
              subtitle: StreamBuilder<Object>(
                  initialData: 'Select Your Location',
                  stream: getAddressManager.addressLine$,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData ? snapshot.data : 'Select Your Location',
                      style: TextStyle(fontSize: 12),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
