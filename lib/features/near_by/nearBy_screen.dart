import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:momentoo/features/near_by/_model.dart';
import 'package:momentoo/features/near_by/manger.dart';
import 'package:momentoo/features/near_by/nearByMarkers.dart';
import 'package:momentoo/features/storeDetails/storeDetails_screen.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';

class NearByScreenargs {
  final cityID;

  NearByScreenargs(this.cityID);
}

class NearByScreen extends StatefulWidget {
  // final cityID;

  // NearByScreen(this.cityID);

  @override
  _NearByScreenState createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController wordSearch = TextEditingController();

  int cusinId;

  @override
  Widget build(BuildContext context) {
    NearByScreenargs args = ModalRoute.of(context).settings.arguments;
    return NetworkSensitive(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: Scaffold(
            appBar: PreferredSize(
              child: Container(
                color: Colors.teal.shade900,
                child: Center(
                  child: Container(
                    height: 55,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(19.0)),
                    ),
                    child: TextField(
                      controller: wordSearch,
                      onSubmitted: (v) {
                        setState(() {
                          wordSearch.text;
                        });
                        print("wordSearch.text ${wordSearch.text}");
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
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.black54,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                // wordSearch.clear();
                                wordSearch.text = '';
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                color: Colors.red.shade800,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              child: new Icon(
                                Icons.close,
                                color: Colors.white,
                                // size: 35.0,
                              ),
                            ),
                          ),
                          hintText: "Search...",
                          fillColor: Colors.white),
                    ),
                  ),
                ),
              ),
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.18),
            ),
            body: SafeArea(
              child: CustomObserver(
                  stream: locator<NearByManager>().getData(
                      locator<NearByManager>().catSubject.value,
                      wordSearch.text,
                      args.cityID,
                      cusinId == null ? "" : cusinId),
                  onSuccess: (_, NearByModel model) {
                    print("NearByModel ${model}");
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        _googleMap(context, model),
                        nearbyStoresList(model),
                        Positioned(
                          left: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          child: CustomBottomNavigation(),
                        ),
                        filterList(model),
                      ],
                    );
                  }),
            ),
//        bottomNavigationBar: CustomBottomNavigation(),
          ),
        ),
      ),
    );
  }

  Set<Marker> markers = Set();

  Widget _googleMap(BuildContext context, model) {
    for (int index = 0; index < model.data.sellers.length; index++) {
      // Create a new marker
      Marker resultMarker = Marker(
        markerId: MarkerId(model.data.sellers[index].name),
        infoWindow: InfoWindow(
            title: "${model.data.sellers[index].name}",
            snippet: "${model.data.sellers[index].cuisine}"),
        position: LatLng(double.parse(model.data.sellers[index].lat),
            double.parse(model.data.sellers[index].lng)),
      );
// Add it to Set
      markers.add(resultMarker);
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            29.378586,
            47.990341,
//            40.761421,
//            -73.981667,
          ),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // markers: {currentMarker(context)},

        markers: markers,

//        markers:
//        {
//
//
//          newyork1Marker,
//          newyork2Marker,
//          newyork3Marker,
//          gramercyMarker,
//          bernardinMarker,
//          blueMarker,
//
//
//        }
//        ,
      ),
    );
  }

  Widget filterList(dataModel) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dataModel.data.cuisines.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: RaisedButton(
                color: Colors.teal.shade900,
                child: Text(
//                    'data00000',
                  dataModel.data.cuisines[index].name,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  print(
                      "dataModel.data.cuisines[index].name ${dataModel.data.cuisines[index].id} ${cusinId} ${dataModel.data.sellers.length} ");
                  setState(() {
                    cusinId = dataModel.data.cuisines[index].id;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget nearbyStoresList(dataModel) {
    return Positioned(
//      alignment: Alignment.bottomCenter,
      left: 0.0,
      right: 0.0,
      bottom: 70,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dataModel.data.sellers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: _boxes(
                  sellerId: dataModel.data.sellers[index].id,

                  image: dataModel.data.sellers[index].image,

//                      "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",

//                      lat: 40.761421
                  lat: double.parse(dataModel.data.sellers[index].lat),
                  long: double.parse(dataModel.data.sellers[index].lng),
//                      -73.981667,
                  restaurantName: dataModel.data.sellers[index].name,
                  rate: dataModel.data.sellers[index].rate,
                  favourite: dataModel.data.sellers[index].favourite,
                ),
              );
            },
          )),
    );
  }

  Widget _boxes(
      {int sellerId,
      String image,
      double lat,
      double long,
      String restaurantName,
      int rate,
      String favourite}) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.2,
        // height: 400,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Colors.grey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/StoreDetailsScreen',
                              arguments: StoreDetailsArguments(
                                categoryId:
                                    locator<NearByManager>().catSubject.value,
                                sellerId: sellerId,
                              ),
                            );
                          },
                          child: Image(
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            image: NetworkImage(image),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            favourite == "yes"
                                ? FontAwesomeIcons.solidStar
                                : FontAwesomeIcons.star,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: myDetailsContainer1(restaurantName, rate, favourite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(
      String restaurantName, int rate, String favourite) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              restaurantName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5.0),
//          Container(
//            child: Text(
//              "Closed \u00B7 Opens 17:00 Thu",
//              style: TextStyle(
//                  color: Colors.black54,
//                  fontSize: 12.0,
//                  fontWeight: FontWeight.bold),
//            ),
//          ),
          SizedBox(height: 5.0),
          Container(
//            width: 100.0,
            height: 25.0,
            child:
//              ListView.builder(
//                shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
//                scrollDirection: Axis.horizontal,
//                itemCount: rate,
//                itemBuilder: (context, index) {
//                  return Container(
//                    child: Icon(
//                      FontAwesomeIcons.solidStar,
//                      color: Colors.red,
//                      size: 15.0,
//                    ),
//                  );
//                },
//              )

                RatingBar(
              initialRating: rate.toDouble(),
              minRating: 0,
              direction: Axis.horizontal,
              ignoreGestures: true,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24.0,
              itemPadding: EdgeInsets.symmetric(horizontal: .4),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.red),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 15,
          tilt: 50.0,
          bearing: 45.0,
        ),
      ),
    );
  }
}
