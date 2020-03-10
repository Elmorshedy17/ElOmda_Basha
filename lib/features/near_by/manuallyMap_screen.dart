import 'dart:async';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:momentoo/features/near_by/getAddress_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';

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
  Completer<GoogleMapController> _controller = Completer();
  ManuallyMapScreenArguments args;

  GetAddressManager getAddressManager = locator<GetAddressManager>();

  // Get Address From coordinates
  getAddress(double lat, double lng) async {
    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    getAddressManager.inFeatureName.add(first.featureName);
    getAddressManager.inAddressLine.add(first.addressLine);
    print("${first.featureName} : ${first.addressLine}");
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
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
            bottom: 0.0,
            child: deliveryAddress(context),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
            'Deliver Here',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/nearByScreen');
          },
        ),
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
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
    );
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
