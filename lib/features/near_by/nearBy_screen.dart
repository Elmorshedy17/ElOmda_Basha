import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:momentoo/features/near_by/nearByMarkers.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';

class NearByScreen extends StatefulWidget {
  @override
  _NearByScreenState createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            color: Colors.teal.shade900,
            child: Center(
              child: Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(19.0)),
                ),
                child: TextField(
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
                        onTap: () {},
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
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _googleMap(context),
            nearbyStoresList(),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: CustomBottomNavigation(),
            ),
            filterList(),
          ],
        ),
//        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            40.761421,
            -73.981667,
          ),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // markers: {currentMarker(context)},
        markers: {
          newyork1Marker,
          newyork2Marker,
          newyork3Marker,
          gramercyMarker,
          bernardinMarker,
          blueMarker
        },
      ),
    );
  }

  Widget filterList() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              color: Colors.teal.shade900,
              child: Text(
                'data00000',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              color: Colors.teal.shade900,
              child: Text(
                'data222222',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              color: Colors.teal.shade900,
              child: Text(
                'data333333',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              color: Colors.teal.shade900,
              child: Text(
                'data444444',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              color: Colors.teal.shade900,
              child: Text(
                'data55555',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              color: Colors.teal.shade900,
              child: Text(
                'data6666666',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nearbyStoresList() {
    return Positioned(
//      alignment: Alignment.bottomCenter,
      left: 0.0,
      right: 0.0,
      bottom: 70,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              width: 2.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _boxes(
                  image:
                      "https://lh5.googleusercontent.com/p/AF1QipO3VPL9m-b355xWeg4MXmOQTauFAEkavSluTtJU=w225-h160-k-no",
                  lat: 40.738380,
                  long: -73.988426,
                  restaurantName: "Gramercy Tavern"),
            ),
            SizedBox(
              width: 2.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _boxes(
                  image:
                      "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
                  lat: 40.761421,
                  long: -73.981667,
                  restaurantName: "Le Bernardin"),
            ),
            SizedBox(
              width: 2.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _boxes(
                  image:
                      "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  lat: 40.732128,
                  long: -73.999619,
                  restaurantName: "Blue Hill"),
            ),
            SizedBox(
              width: 2.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _boxes(
                  image:
                      "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  lat: 40.732128,
                  long: -73.999619,
                  restaurantName: "Blue Hill"),
            ),
            SizedBox(
              width: 2.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _boxes(
                  image:
                      "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  lat: 40.732128,
                  long: -73.999619,
                  restaurantName: "Blue Hill"),
            ),
            SizedBox(
              width: 2.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _boxes(
                  image:
                      "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  lat: 40.732128,
                  long: -73.999619,
                  restaurantName: "Blue Hill"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(
      {String image, double lat, double long, String restaurantName}) {
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
                        Image(
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          image: NetworkImage(image),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: myDetailsContainer1(restaurantName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
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
          Container(
            child: Text(
              "Closed \u00B7 Opens 17:00 Thu",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.red,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.red,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.red,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.red,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStarHalf,
                    color: Colors.red,
                    size: 15.0,
                  ),
                ),
              ],
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
